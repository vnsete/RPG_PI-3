import 'dart:async';

import 'package:flutter/material.dart';

import '../data/ambientes_mock.dart';
import '../data/cenas_mock.dart';
import '../models/ambiente.dart';
import '../models/cena.dart';
import '../services/localizacao_service.dart';
import '../services/progresso_service.dart';
import '../widgets/botao_jogo.dart';
import 'jogo/tela_capitulo.dart';
import 'jogo/tela_espera_gps.dart';

class JogoScreen extends StatefulWidget {
  const JogoScreen({super.key});

  @override
  State<JogoScreen> createState() => _JogoScreenState();
}

class _JogoScreenState extends State<JogoScreen> {
  final LocalizacaoService _localizacaoService = LocalizacaoService();
  final ProgressoService _progressoService = ProgressoService();

  int _indiceAmbiente = 0;
  int _versaoCapitulo = 0;
  bool _carregandoProgresso = true;
  bool _verificandoGps = false;
  bool _salvandoTeste = false;
  bool _ambienteLiberado = false;
  bool _interacaoIniciada = false;
  bool _jogoFinalizado = false;

  String? _mensagemGps;
  double? _distanciaMetros;
  Timer? _monitoramentoLocalizacao;

  Ambiente get _ambienteAtual => ambientes[_indiceAmbiente];

  @override
  void initState() {
    super.initState();
    unawaited(_carregarProgressoSalvo());
  }

  @override
  void dispose() {
    _pararMonitoramentoLocalizacao();
    super.dispose();
  }

  void _iniciarMonitoramentoLocalizacao() {
    _monitoramentoLocalizacao ??= Timer.periodic(
      const Duration(seconds: 8),
      (_) {
        if (!_carregandoProgresso &&
            !_jogoFinalizado &&
            !_ambienteLiberado &&
            !_interacaoIniciada &&
            !_verificandoGps) {
          unawaited(_verificarLocalizacao());
        }
      },
    );
  }

  void _pararMonitoramentoLocalizacao() {
    _monitoramentoLocalizacao?.cancel();
    _monitoramentoLocalizacao = null;
  }

  Future<void> _carregarProgressoSalvo() async {
    try {
      final indiceSalvo = await _progressoService.carregarProgresso();
      final indiceSeguro = indiceSalvo.clamp(0, ambientes.length - 1).toInt();

      if (!mounted) return;

      setState(() {
        _indiceAmbiente = indiceSeguro;
        _carregandoProgresso = false;
      });
      _iniciarMonitoramentoLocalizacao();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _carregandoProgresso = false;
        _mensagemGps = 'Nao foi possivel carregar o progresso salvo: $e';
      });
    }
  }

  Future<void> _verificarLocalizacao() async {
    setState(() {
      _verificandoGps = true;
      _mensagemGps = null;
      _distanciaMetros = null;
    });

    try {
      final posicao = await _localizacaoService.obterPosicaoAtual();

      if (!mounted) return;

      final distancia = _localizacaoService.calcularDistanciaMetros(
        origemLat: posicao.latitude,
        origemLng: posicao.longitude,
        destinoLat: _ambienteAtual.latitude,
        destinoLng: _ambienteAtual.longitude,
      );

      setState(() {
        _distanciaMetros = distancia;
      });

      if (distancia <= _ambienteAtual.raioMetros) {
        _pararMonitoramentoLocalizacao();
        setState(() {
          _versaoCapitulo++;
          _ambienteLiberado = true;
          _interacaoIniciada = true;
          _jogoFinalizado = false;
          _mensagemGps = 'Local confirmado! Capitulo iniciado.';
        });
      } else {
        setState(() {
          _ambienteLiberado = false;
          _interacaoIniciada = false;
          _mensagemGps =
              'Voce ainda esta a ${distancia.toStringAsFixed(0)} metros de ${_ambienteAtual.nome}.';
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _mensagemGps = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _verificandoGps = false;
        });
      }
    }
  }

  Future<void> _simularChegadaTeste() async {
    setState(() {
      _salvandoTeste = true;
      _mensagemGps = 'Salvando simulacao no Firebase...';
    });

    try {
      await _progressoService.registrarSimulacaoTeste(
        indiceAmbiente: _indiceAmbiente,
        ambienteId: _ambienteAtual.id,
        ambienteNome: _ambienteAtual.nome,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _salvandoTeste = false;
        _mensagemGps = 'Nao foi possivel salvar no Firebase: $e';
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      _salvandoTeste = false;
      _versaoCapitulo++;
      _ambienteLiberado = true;
      _interacaoIniciada = true;
      _jogoFinalizado = false;
      _distanciaMetros = 0;
      _mensagemGps = 'Simulacao de teste: capitulo iniciado.';
    });
  }

  Future<void> _proximoAmbienteTeste() async {
    if (_indiceAmbiente < ambientes.length - 1) {
      final proximoIndice = _indiceAmbiente + 1;
      final proximoAmbiente = ambientes[proximoIndice];

      try {
        await _progressoService.registrarAmbienteConcluidoTeste(
          indiceAmbiente: proximoIndice,
          ambienteId: proximoAmbiente.id,
          ambienteNome: proximoAmbiente.nome,
          jogoFinalizado: false,
        );
      } catch (e) {
        if (!mounted) return;

        setState(() {
          _mensagemGps = 'Nao foi possivel salvar o progresso: $e';
        });
        return;
      }

      if (!mounted) return;

      setState(() {
        _indiceAmbiente = proximoIndice;
        _ambienteLiberado = false;
        _interacaoIniciada = false;
        _jogoFinalizado = false;
        _mensagemGps = null;
        _distanciaMetros = null;
      });
      _iniciarMonitoramentoLocalizacao();
    } else {
      try {
        await _progressoService.registrarAmbienteConcluidoTeste(
          indiceAmbiente: _indiceAmbiente,
          ambienteId: _ambienteAtual.id,
          ambienteNome: _ambienteAtual.nome,
          jogoFinalizado: true,
        );
      } catch (e) {
        if (!mounted) return;

        setState(() {
          _mensagemGps = 'Nao foi possivel salvar o fim do jogo: $e';
        });
        return;
      }

      if (!mounted) return;

      setState(() {
        _ambienteLiberado = false;
        _interacaoIniciada = false;
        _jogoFinalizado = true;
        _mensagemGps = 'Fim do jogo!';
      });
      _pararMonitoramentoLocalizacao();
    }
  }

  void _registrarEscolha({
    required int indiceCena,
    required OpcaoCena opcao,
  }) {
    unawaited(_registrarEscolhaAsync(indiceCena: indiceCena, opcao: opcao));
  }

  Future<void> _registrarEscolhaAsync({
    required int indiceCena,
    required OpcaoCena opcao,
  }) async {
    try {
      await _progressoService.salvarEscolha(
        ambienteId: _ambienteAtual.id,
        escolha: opcao.texto,
        indiceCena: indiceCena,
        proximaCena: opcao.proximaCena,
      );
    } catch (_) {
      // A escolha continua funcionando mesmo se o registro remoto falhar.
    }
  }

  Future<void> _reiniciarJogo() async {
    setState(() {
      _salvandoTeste = true;
      _mensagemGps = null;
    });

    try {
      await _progressoService.reiniciar();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _salvandoTeste = false;
        _mensagemGps = 'Nao foi possivel reiniciar no Firebase: $e';
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      _indiceAmbiente = 0;
      _versaoCapitulo++;
      _carregandoProgresso = false;
      _verificandoGps = false;
      _salvandoTeste = false;
      _ambienteLiberado = false;
      _interacaoIniciada = false;
      _jogoFinalizado = false;
      _mensagemGps = null;
      _distanciaMetros = null;
    });
    _iniciarMonitoramentoLocalizacao();
  }

  Widget _telaCarregandoProgresso() {
    return const Scaffold(
      backgroundColor: Color(0xFF0050A8),
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _telaFimJogo() {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/ambiente_sala_10a/46.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BotaoJogo(
                  texto: _salvandoTeste ? 'REINICIANDO...' : 'JOGAR NOVAMENTE',
                  onPressed: _salvandoTeste ? null : _reiniciarJogo,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_carregandoProgresso) {
      return _telaCarregandoProgresso();
    }

    if (_jogoFinalizado) {
      return _telaFimJogo();
    }

    if (_ambienteLiberado && _interacaoIniciada) {
      return TelaCapitulo(
        key: ValueKey('${_ambienteAtual.id}-$_versaoCapitulo'),
        ambiente: _ambienteAtual,
        cenas: cenasPorAmbiente[_ambienteAtual.id] ?? const [],
        onConcluir: _proximoAmbienteTeste,
        onEscolhaSelecionada: _registrarEscolha,
      );
    }

    return TelaEsperaGps(
      ambiente: _ambienteAtual,
      verificandoGps: _verificandoGps,
      mensagemGps: _mensagemGps,
      distancia: _distanciaMetros,
      onVerificar: _verificarLocalizacao,
      onSimular: _simularChegadaTeste,
      simulando: _salvandoTeste,
    );
  }
}

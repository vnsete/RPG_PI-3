import 'package:flutter/material.dart';

import '../data/ambientes_mock.dart';
import '../data/cenas_mock.dart';
import '../models/ambiente.dart';
import '../services/localizacao_service.dart';
import '../services/progresso_service.dart';
import 'jogo/tela_ambiente_liberado.dart';
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
  bool _verificandoGps = false;
  bool _salvandoTeste = false;
  bool _ambienteLiberado = false;
  bool _interacaoIniciada = false;

  String? _mensagemGps;
  double? _distanciaMetros;

  Ambiente get _ambienteAtual => ambientes[_indiceAmbiente];

  Future<void> _verificarLocalizacao() async {
    setState(() {
      _verificandoGps = true;
      _mensagemGps = null;
      _distanciaMetros = null;
    });

    try {
      final posicao = await _localizacaoService.obterPosicaoAtual();

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
        setState(() {
          _ambienteLiberado = true;
          _interacaoIniciada = false;
          _mensagemGps = 'Local confirmado! Ambiente liberado.';
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
      setState(() {
        _mensagemGps = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        _verificandoGps = false;
      });
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
      _distanciaMetros = 0;
      _mensagemGps = 'Simulacao de teste: capitulo iniciado.';
    });
  }

  void _iniciarInteracao() {
    setState(() {
      _versaoCapitulo++;
      _interacaoIniciada = true;
    });
  }

  Future<void> _proximoAmbienteTeste() async {
    if (_indiceAmbiente < ambientes.length - 1) {
      final proximoIndice = _indiceAmbiente + 1;
      final proximoAmbiente = ambientes[proximoIndice];

      await _progressoService.registrarAmbienteConcluidoTeste(
        indiceAmbiente: proximoIndice,
        ambienteId: proximoAmbiente.id,
        ambienteNome: proximoAmbiente.nome,
        jogoFinalizado: false,
      );

      if (!mounted) return;

      setState(() {
        _indiceAmbiente = proximoIndice;
        _ambienteLiberado = false;
        _interacaoIniciada = false;
        _mensagemGps = null;
        _distanciaMetros = null;
      });
    } else {
      await _progressoService.registrarAmbienteConcluidoTeste(
        indiceAmbiente: _indiceAmbiente,
        ambienteId: _ambienteAtual.id,
        ambienteNome: _ambienteAtual.nome,
        jogoFinalizado: true,
      );

      if (!mounted) return;

      setState(() {
        _ambienteLiberado = false;
        _interacaoIniciada = false;
        _mensagemGps = 'Fim do jogo!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_ambienteLiberado && !_interacaoIniciada) {
      return TelaAmbienteLiberado(
        ambiente: _ambienteAtual,
        distancia: _distanciaMetros,
        onIniciarInteracao: _iniciarInteracao,
      );
    }

    if (_ambienteLiberado && _interacaoIniciada) {
      return TelaCapitulo(
        key: ValueKey('${_ambienteAtual.id}-$_versaoCapitulo'),
        ambiente: _ambienteAtual,
        cenas: cenasPorAmbiente[_ambienteAtual.id] ?? const [],
        onConcluir: _proximoAmbienteTeste,
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

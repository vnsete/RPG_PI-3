import 'package:flutter/material.dart';
import '../data/ambientes_mock.dart';
import '../data/cenas_mock.dart';
import '../models/ambiente.dart';
import '../models/cena.dart';
import '../services/localizacao_service.dart';
import '../services/progresso_service.dart';
import '../widgets/botao_jogo.dart';

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
              'Você ainda está a ${distancia.toStringAsFixed(0)} metros de ${_ambienteAtual.nome}.';
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
      _mensagemGps = 'Simulação de teste: capítulo iniciado.';
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
      return _TelaAmbienteLiberado(
        ambiente: _ambienteAtual,
        distancia: _distanciaMetros,
        onIniciarInteracao: _iniciarInteracao,
      );
    }

    if (_ambienteLiberado && _interacaoIniciada) {
      return _TelaCapitulo(
        key: ValueKey('${_ambienteAtual.id}-$_versaoCapitulo'),
        ambiente: _ambienteAtual,
        cenas: cenasPorAmbiente[_ambienteAtual.id] ?? const [],
        onConcluir: _proximoAmbienteTeste,
      );
    }

    return _TelaEsperaGps(
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

class _TelaEsperaGps extends StatelessWidget {
  final Ambiente ambiente;
  final bool verificandoGps;
  final String? mensagemGps;
  final double? distancia;
  final VoidCallback onVerificar;
  final Future<void> Function() onSimular;
  final bool simulando;

  const _TelaEsperaGps({
    required this.ambiente,
    required this.verificandoGps,
    required this.mensagemGps,
    required this.distancia,
    required this.onVerificar,
    required this.onSimular,
    required this.simulando,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0050A8),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ambiente.imagemEspera,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withValues(alpha: 0.35),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxHeight: 360),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.78),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.white24),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 6),
                      const SizedBox(height: 10),
                      const Text(
                        'Vá fisicamente até este local para liberar o ambiente.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.3,
                        ),
                      ),
                      if (mensagemGps != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          mensagemGps!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.3,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      if (verificandoGps)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 14),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      BotaoJogo(
                        texto: 'VERIFICAR LOCALIZAÇÃO',
                        onPressed: simulando ? null : onVerificar,
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: simulando ? null : onSimular,
                        child: const Text(
                          'SIMULAR CHEGADA (apenas teste)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TelaAmbienteLiberado extends StatelessWidget {
  final Ambiente ambiente;
  final double? distancia;
  final VoidCallback onIniciarInteracao;

  const _TelaAmbienteLiberado({
    required this.ambiente,
    required this.distancia,
    required this.onIniciarInteracao,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ambiente.imagemEspera,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withValues(alpha: 0.25),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxHeight: 360),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.78),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.white24),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'AMBIENTE LIBERADO',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ambiente.nome,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        ambiente.descricao,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 18),
                      BotaoJogo(
                        texto: 'INICIAR INTERAÇÃO',
                        onPressed: onIniciarInteracao,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TelaCapitulo extends StatefulWidget {
  final Ambiente ambiente;
  final List<Cena> cenas;
  final VoidCallback onConcluir;

  const _TelaCapitulo({
    super.key,
    required this.ambiente,
    required this.cenas,
    required this.onConcluir,
  });

  @override
  State<_TelaCapitulo> createState() => _TelaCapituloState();
}

class _TelaCapituloState extends State<_TelaCapitulo> {
  int _indiceCena = 0;

  bool get _usaImagemComTexto => widget.ambiente.id == 'praca_alimentacao';

  Cena? get _cenaAtual {
    if (widget.cenas.isEmpty || _indiceCena >= widget.cenas.length) {
      return null;
    }

    return widget.cenas[_indiceCena];
  }

  void _avancarCena([int? proximaCena]) {
    final cena = _cenaAtual;

    if (cena == null || cena.concluiAmbiente || cena.tipo == TipoCena.fim) {
      widget.onConcluir();
      return;
    }

    final novoIndice = proximaCena ?? cena.proximaCena ?? _indiceCena + 1;

    if (novoIndice >= 0 && novoIndice < widget.cenas.length) {
      setState(() {
        _indiceCena = novoIndice;
      });
    } else {
      widget.onConcluir();
    }
  }

  Widget _botoesCena(Cena? cena) {
    if (cena != null && cena.tipo == TipoCena.escolha) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: cena.opcoes
            .map(
              (opcao) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: BotaoJogo(
                  texto: opcao.texto,
                  onPressed: () => _avancarCena(opcao.proximaCena),
                ),
              ),
            )
            .toList(),
      );
    }

    return BotaoJogo(
      texto: cena != null && (cena.concluiAmbiente || cena.tipo == TipoCena.fim)
          ? 'PRÓXIMO CAPÍTULO'
          : 'CONTINUAR',
      onPressed: _avancarCena,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cena = _cenaAtual;
    final imagem = cena?.imagem ?? widget.ambiente.imagemEspera;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagem,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withValues(alpha: 0.35),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _usaImagemComTexto
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: _botoesCena(cena),
                    )
                  : Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.82),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Capítulo ${widget.ambiente.ordem}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.ambiente.nome,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            cena?.texto ?? widget.ambiente.descricao,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 18),
                          if (cena != null && cena.tipo == TipoCena.escolha)
                            ...cena.opcoes.map(
                              (opcao) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: BotaoJogo(
                                  texto: opcao.texto,
                                  onPressed: () =>
                                      _avancarCena(opcao.proximaCena),
                                ),
                              ),
                            )
                          else
                            BotaoJogo(
                              texto: cena != null &&
                                      (cena.concluiAmbiente ||
                                          cena.tipo == TipoCena.fim)
                                  ? 'PRÓXIMO CAPÍTULO'
                                  : 'CONTINUAR',
                              onPressed: _avancarCena,
                            ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

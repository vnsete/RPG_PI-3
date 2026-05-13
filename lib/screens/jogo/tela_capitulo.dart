import 'package:flutter/material.dart';

import '../../models/ambiente.dart';
import '../../models/cena.dart';
import '../../widgets/botao_jogo.dart';

class TelaCapitulo extends StatefulWidget {
  final Ambiente ambiente;
  final List<Cena> cenas;
  final VoidCallback onConcluir;

  const TelaCapitulo({
    super.key,
    required this.ambiente,
    required this.cenas,
    required this.onConcluir,
  });

  @override
  State<TelaCapitulo> createState() => _TelaCapituloState();
}

class _TelaCapituloState extends State<TelaCapitulo> {
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

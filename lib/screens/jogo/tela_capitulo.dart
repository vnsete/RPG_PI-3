import 'package:flutter/material.dart';

import '../../models/ambiente.dart';
import '../../models/cena.dart';
import '../../widgets/botao_jogo.dart';

class TelaCapitulo extends StatefulWidget {
  final Ambiente ambiente;
  final List<Cena> cenas;
  final VoidCallback onConcluir;
  final void Function({
    required int indiceCena,
    required OpcaoCena opcao,
  }) onEscolhaSelecionada;

  const TelaCapitulo({
    super.key,
    required this.ambiente,
    required this.cenas,
    required this.onConcluir,
    required this.onEscolhaSelecionada,
  });

  @override
  State<TelaCapitulo> createState() => _TelaCapituloState();
}

class _TelaCapituloState extends State<TelaCapitulo> {
  int _indiceCena = 0;

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

  Widget _opcoesCena(Cena cena) {
    final alturaMaxima = MediaQuery.sizeOf(context).height * 0.48;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: alturaMaxima),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: cena.opcoes
              .map(
                (opcao) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: BotaoJogo(
                    texto: opcao.texto,
                    onPressed: () {
                      widget.onEscolhaSelecionada(
                        indiceCena: _indiceCena,
                        opcao: opcao,
                      );
                      _avancarCena(opcao.proximaCena);
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _sombraInferior() {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Color(0x99000000),
          ],
        ),
      ),
    );
  }

  Widget _conteudoInferior(Cena? cena) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: cena != null && cena.tipo == TipoCena.escolha
              ? _opcoesCena(cena)
              : _indicadorToque(),
        ),
      ),
    );
  }

  Widget _corpoCapitulo({
    required String imagem,
    required Cena? cena,
    required bool podeTocarNaTela,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: podeTocarNaTela ? () => _avancarCena() : null,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagem,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 220,
            child: _sombraInferior(),
          ),
          _conteudoInferior(cena),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cena = _cenaAtual;
    final imagem = cena?.imagem ?? widget.ambiente.imagemEspera;
    final podeTocarNaTela = cena == null || cena.tipo != TipoCena.escolha;

    return Scaffold(
      body: _corpoCapitulo(
        imagem: imagem,
        cena: cena,
        podeTocarNaTela: podeTocarNaTela,
      ),
    );
  }

  static Widget _indicadorToque() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white24),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.touch_app_rounded,
            color: Colors.white,
            size: 18,
          ),
          SizedBox(width: 8),
          Text(
            'TOQUE NA TELA PARA CONTINUAR',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}

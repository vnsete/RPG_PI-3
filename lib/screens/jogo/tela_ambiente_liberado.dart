import 'package:flutter/material.dart';

import '../../models/ambiente.dart';
import '../../widgets/botao_jogo.dart';

class TelaAmbienteLiberado extends StatelessWidget {
  static const _proporcaoArte = 9 / 16;

  final Ambiente ambiente;
  final double? distancia;
  final VoidCallback onIniciarInteracao;

  const TelaAmbienteLiberado({
    super.key,
    required this.ambiente,
    required this.distancia,
    required this.onIniciarInteracao,
  });

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Center(
            child: Transform.scale(
              scale: 1.06,
              child: AspectRatio(
                aspectRatio: _proporcaoArte,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      ambiente.imagemEspera,
                      fit: BoxFit.cover,
                    ),
                    Container(color: Colors.black.withValues(alpha: 0.25)),
                    SafeArea(
                      minimum: const EdgeInsets.only(bottom: 18),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          constraints:
                              BoxConstraints(maxHeight: alturaTela * 0.46),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.78),
                            borderRadius: BorderRadius.circular(18),
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
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  ambiente.descricao,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                BotaoJogo(
                                  texto: 'INICIAR INTERACAO',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

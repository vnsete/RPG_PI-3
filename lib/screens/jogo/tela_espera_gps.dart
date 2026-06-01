import 'package:flutter/material.dart';

import '../../models/ambiente.dart';
import '../../widgets/botao_jogo.dart';

class TelaEsperaGps extends StatelessWidget {
  static const _proporcaoArte = 9 / 16;

  final Ambiente ambiente;
  final bool verificandoGps;
  final String? mensagemGps;
  final double? distancia;
  final bool mostrarBotaoVerificar;
  final VoidCallback onVerificar;
  final Future<void> Function() onSimular;
  final bool simulando;

  const TelaEsperaGps({
    super.key,
    required this.ambiente,
    required this.verificandoGps,
    required this.mensagemGps,
    required this.distancia,
    required this.mostrarBotaoVerificar,
    required this.onVerificar,
    required this.onSimular,
    required this.simulando,
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
                    Container(color: Colors.black.withValues(alpha: 0.30)),
                    SafeArea(
                      minimum: const EdgeInsets.only(bottom: 26),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: 420,
                            maxHeight: alturaTela * 0.40,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.76),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Va fisicamente ate este local para liberar o ambiente.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    height: 1.2,
                                  ),
                                ),
                                if (mensagemGps != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    mensagemGps!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 10),
                                if (verificandoGps)
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                if (mostrarBotaoVerificar)
                                  BotaoJogo(
                                    texto: 'VERIFICAR LOCALIZACAO',
                                    onPressed: simulando ? null : onVerificar,
                                  ),
                                // const SizedBox(height: 2),
                                // TextButton(
                                //   onPressed: simulando ? null : onSimular,
                                //   child: const Text(
                                //     'SIMULAR CHEGADA (apenas teste)',
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 12,
                                //     ),
                                //   ),
                                // ),
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

import 'package:flutter/material.dart';

import '../../models/ambiente.dart';
import '../../widgets/botao_jogo.dart';

class TelaEsperaGps extends StatelessWidget {
  final Ambiente ambiente;
  final bool verificandoGps;
  final String? mensagemGps;
  final double? distancia;
  final VoidCallback onVerificar;
  final Future<void> Function() onSimular;
  final bool simulando;

  const TelaEsperaGps({
    super.key,
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
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  maxWidth: 420,
                  maxHeight: 220,
                ),
                margin: const EdgeInsets.fromLTRB(16, 66, 16, 0),
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Vá fisicamente até este local para liberar o ambiente.',
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
                      BotaoJogo(
                        texto: 'VERIFICAR LOCALIZAÇÃO',
                        onPressed: simulando ? null : onVerificar,
                      ),
                      const SizedBox(height: 4),
                      TextButton(
                        onPressed: simulando ? null : onSimular,
                        child: const Text(
                          'SIMULAR CHEGADA (apenas teste)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
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

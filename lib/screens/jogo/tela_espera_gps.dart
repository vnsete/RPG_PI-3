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
                        'VÃ¡ fisicamente atÃ© este local para liberar o ambiente.',
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
                        texto: 'VERIFICAR LOCALIZAÃ‡ÃƒO',
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

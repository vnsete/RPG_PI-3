import 'package:flutter/material.dart';

import '../widgets/botao_jogo.dart';
import 'jogo_screen.dart';

class HomeScreen extends StatelessWidget {
  static const _proporcaoArte = 9 / 16;

  const HomeScreen({super.key});

  void _iniciarJogo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const JogoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      'assets/images/tela_inicial.png',
                      fit: BoxFit.cover,
                    ),
                    Container(color: Colors.black.withValues(alpha: 0.18)),
                    SafeArea(
                      minimum: const EdgeInsets.only(bottom: 28),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: BotaoJogo(
                            texto: 'TOQUE PARA COMECAR',
                            onPressed: () => _iniciarJogo(context),
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

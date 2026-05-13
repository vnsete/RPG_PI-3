import 'package:flutter/material.dart';
import '../widgets/botao_jogo.dart';
import 'jogo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _iniciarJogo(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const JogoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/tela_inicial.png',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withValues(alpha: 0.18)),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                child: BotaoJogo(
                  texto: 'TOQUE PARA COMEÇAR',
                  onPressed: () => _iniciarJogo(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

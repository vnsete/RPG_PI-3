import 'dart:async';

import 'package:flutter/material.dart';

import '../services/progresso_service.dart';
import '../services/simple_audio.dart';
import '../widgets/botao_jogo.dart';
import 'jogo_screen.dart';

class HomeScreen extends StatefulWidget {
  static const _proporcaoArte = 9 / 16;

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controllerNome = TextEditingController();
  final _progressoService = ProgressoService();
  final _simpleAudio = SimpleAudioService();

  @override
  void initState() {
    super.initState();
    _carregarNome();
    unawaited(
      _simpleAudio.play(
        'assets/audio/musica_intro.mp3',
        loop: true,
        volume: 0.7,
      ),
    );
  }

  Future<void> _carregarNome() async {
    final nome = await _progressoService.carregarNomeJogador();
    if (nome != null && mounted) _controllerNome.text = nome;
  }

  Future<void> _iniciarJogo(BuildContext context) async {
    final nome = _controllerNome.text.trim();

    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, digite seu nome para começar'),
        ),
      );
      return;
    }

    final nomeMudou = await _progressoService.definirNomeJogador(nome);

    if (!context.mounted) return;

    if (nomeMudou) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bem-vindo, $nome! Começando novo jogo...')),
      );
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!context.mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const JogoScreen()),
      );
    });
  }

  @override
  void dispose() {
    unawaited(_simpleAudio.dispose());
    _controllerNome.dispose();
    super.dispose();
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
                aspectRatio: HomeScreen._proporcaoArte,
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _controllerNome,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Digite seu nome',
                                  hintStyle:
                                      const TextStyle(color: Colors.white70),
                                  filled: true,
                                  fillColor: Colors.black54,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              BotaoJogo(
                                texto: 'TOQUE PARA COMEÇAR',
                                onPressed: () => _iniciarJogo(context),
                              ),
                            ],
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

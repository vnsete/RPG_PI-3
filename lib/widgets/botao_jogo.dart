import 'package:flutter/material.dart';

class BotaoJogo extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;

  const BotaoJogo({
    super.key,
    required this.texto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0057B8),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            height: 1.15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

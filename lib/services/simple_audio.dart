import 'package:audioplayers/audioplayers.dart';

class SimpleAudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(
    String assetPath, {
    bool loop = true,
    double volume = 0.8,
  }) async {
    try {
      final normalizedPath = assetPath.startsWith('assets/')
          ? assetPath.substring('assets/'.length)
          : assetPath;

      await _player.setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.stop);
      await _player.play(AssetSource(normalizedPath), volume: volume);
    } catch (_) {
      // Audio should never block the game from opening.
    }
  }

  Future<void> stop() => _player.stop();

  Future<void> pause() => _player.pause();

  Future<void> resume() => _player.resume();

  Future<void> dispose() => _player.dispose();
}

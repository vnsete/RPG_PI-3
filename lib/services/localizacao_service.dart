import 'package:geolocator/geolocator.dart';

class LocalizacaoService {
  Future<Position> obterPosicaoAtual() async {
    final servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if (!servicoAtivo) {
      throw Exception('GPS desativado. Ative a localização do dispositivo.');
    }

    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      if (permissao == LocationPermission.denied) {
        throw Exception('Permissão de localização negada.');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      throw Exception(
        'Permissão negada permanentemente. Ative nas configurações.',
      );
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  double calcularDistanciaMetros({
    required double origemLat,
    required double origemLng,
    required double destinoLat,
    required double destinoLng,
  }) {
    return Geolocator.distanceBetween(
      origemLat,
      origemLng,
      destinoLat,
      destinoLng,
    );
  }
}
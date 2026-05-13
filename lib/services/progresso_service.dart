import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressoService {
  ProgressoService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  static const _indiceAmbienteKey = 'indice_ambiente_atual';
  static const _colecaoProgresso = 'progresso_jogadores';
  static const _jogadorTesteId = 'jogador_teste';

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> get _documentoJogadorTeste =>
      _firestore.collection(_colecaoProgresso).doc(_jogadorTesteId);

  Future<int> carregarIndiceAmbiente() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_indiceAmbienteKey) ?? 0;
  }

  Future<void> salvarIndiceAmbiente(int indice) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_indiceAmbienteKey, indice);
  }

  Future<void> registrarSimulacaoTeste({
    required int indiceAmbiente,
    required String ambienteId,
    required String ambienteNome,
  }) async {
    await salvarIndiceAmbiente(indiceAmbiente);

    await _documentoJogadorTeste.set(
      {
        'status': 'capitulo_iniciado_teste',
        'modo_teste': true,
        'ambiente_indice': indiceAmbiente,
        'ambiente_id': ambienteId,
        'ambiente_nome': ambienteNome,
        'atualizado_em': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> registrarAmbienteConcluidoTeste({
    required int indiceAmbiente,
    required String ambienteId,
    required String ambienteNome,
    required bool jogoFinalizado,
  }) async {
    await salvarIndiceAmbiente(indiceAmbiente);

    await _documentoJogadorTeste.set(
      {
        'status': jogoFinalizado
            ? 'jogo_finalizado_teste'
            : 'ambiente_concluido_teste',
        'modo_teste': true,
        'ambiente_indice': indiceAmbiente,
        'ambiente_id': ambienteId,
        'ambiente_nome': ambienteNome,
        'jogo_finalizado': jogoFinalizado,
        'atualizado_em': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> reiniciar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_indiceAmbienteKey);

    await _documentoJogadorTeste.set(
      {
        'status': 'reiniciado_teste',
        'modo_teste': true,
        'ambiente_indice': 0,
        'jogo_finalizado': false,
        'atualizado_em': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }
}

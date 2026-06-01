import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressoService {
  ProgressoService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  static const _indiceAmbienteKey = 'indice_ambiente_atual';
  static const _jogadorIdKey = 'jogador_id';
  static const _colecaoProgresso = 'progresso_jogadores';

  final FirebaseFirestore _firestore;

  Future<String> _obterJogadorId() async {
    final prefs = await SharedPreferences.getInstance();
    final jogadorIdSalvo = prefs.getString(_jogadorIdKey);

    if (jogadorIdSalvo != null && jogadorIdSalvo.isNotEmpty) {
      return jogadorIdSalvo;
    }

    final jogadorId = 'jogador_${DateTime.now().microsecondsSinceEpoch}';
    await prefs.setString(_jogadorIdKey, jogadorId);
    return jogadorId;
  }

  Future<DocumentReference<Map<String, dynamic>>>
      _obterDocumentoJogador() async {
    final jogadorId = await _obterJogadorId();
    return _firestore.collection(_colecaoProgresso).doc(jogadorId);
  }

  Future<int> carregarIndiceAmbiente() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_indiceAmbienteKey) ?? 0;
  }

  Future<void> salvarIndiceAmbiente(int indice) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_indiceAmbienteKey, indice);
  }

  Future<int> carregarProgresso() {
    return carregarIndiceAmbiente();
  }

  Future<void> salvarProgresso({
    required int indiceAmbienteAtual,
    required String ambienteAtualId,
    required String ambienteAtualNome,
    required bool ambienteLiberado,
    required bool interacaoIniciada,
    int indiceCenaAtual = 0,
    bool jogoFinalizado = false,
    double? ultimaDistanciaMetros,
  }) async {
    await salvarIndiceAmbiente(indiceAmbienteAtual);
    final documentoJogador = await _obterDocumentoJogador();

    await documentoJogador.set(
      {
        'status': 'progresso_salvo',
        'jogador_id': documentoJogador.id,
        'ambiente_indice': indiceAmbienteAtual,
        'ambiente_id': ambienteAtualId,
        'ambiente_nome': ambienteAtualNome,
        'ambiente_liberado': ambienteLiberado,
        'interacao_iniciada': interacaoIniciada,
        'indice_cena_atual': indiceCenaAtual,
        'jogo_finalizado': jogoFinalizado,
        if (ultimaDistanciaMetros != null)
          'ultima_distancia_metros': ultimaDistanciaMetros,
        'atualizado_em': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> salvarEscolha({
    required String ambienteId,
    required String escolha,
    int? indiceCena,
    int? proximaCena,
  }) async {
    final documentoJogador = await _obterDocumentoJogador();

    await documentoJogador.set(
      {
        'jogador_id': documentoJogador.id,
        'ultima_escolha': {
          'ambiente_id': ambienteId,
          'texto': escolha,
          if (indiceCena != null) 'indice_cena': indiceCena,
          if (proximaCena != null) 'proxima_cena': proximaCena,
          'registrada_em': FieldValue.serverTimestamp(),
        },
        'atualizado_em': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> reiniciarProgresso() {
    return reiniciar();
  }

  Future<void> registrarSimulacaoTeste({
    required int indiceAmbiente,
    required String ambienteId,
    required String ambienteNome,
  }) async {
    await salvarIndiceAmbiente(indiceAmbiente);
    final documentoJogador = await _obterDocumentoJogador();

    await documentoJogador.set(
      {
        'status': 'capitulo_iniciado_teste',
        'jogador_id': documentoJogador.id,
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
    final documentoJogador = await _obterDocumentoJogador();

    await documentoJogador.set(
      {
        'status': jogoFinalizado
            ? 'jogo_finalizado_teste'
            : 'ambiente_concluido_teste',
        'jogador_id': documentoJogador.id,
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
    final documentoJogador = await _obterDocumentoJogador();

    await documentoJogador.set(
      {
        'status': 'reiniciado_teste',
        'jogador_id': documentoJogador.id,
        'ambiente_indice': 0,
        'jogo_finalizado': false,
        'atualizado_em': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }
}

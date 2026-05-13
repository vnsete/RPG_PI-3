enum TipoCena { fala, escolha, resposta, fim }

class OpcaoCena {
  final String texto;
  final int proximaCena;

  const OpcaoCena({required this.texto, required this.proximaCena});
}

class Cena {
  final TipoCena tipo;
  final String imagem;
  final String? texto;
  final List<OpcaoCena> opcoes;
  final int? proximaCena;
  final bool concluiAmbiente;

  const Cena({
    required this.tipo,
    required this.imagem,
    this.texto,
    this.opcoes = const [],
    this.proximaCena,
    this.concluiAmbiente = false,
  });
}

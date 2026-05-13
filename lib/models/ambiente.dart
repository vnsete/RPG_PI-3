class Ambiente {
  final String id;
  final int ordem;
  final String nome;
  final String descricao;
  final double latitude;
  final double longitude;
  final double raioMetros;
  final String imagemEspera;

  const Ambiente({
    required this.id,
    required this.ordem,
    required this.nome,
    required this.descricao,
    required this.latitude,
    required this.longitude,
    required this.raioMetros,
    required this.imagemEspera,
  });
}
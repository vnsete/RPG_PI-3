import '../../models/cena.dart';

const List<Cena> pracaAlimentacaoCenas = [
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/ambiente_praca/praca_narrativa.png',
    texto:
        'Hoje e o grande dia! A banca e ate o reitor estarao la para avaliar nosso TCC, mas tem um problema: o Thiago. Ele ficou de trazer o pendrive com a conexao do banco de dados e mais alguns detalhes para finalizacao do projeto, mas nao achei ele ate agora em lugar nenhum.',
    proximaCena: 1,
  ),
  Cena(
    tipo: TipoCena.escolha,
    imagem: 'assets/images/ambiente_praca/praca_escolha.png',
    texto: 'E ai mano! Preparado para apresentacao hoje?',
    opcoes: [
      OpcaoCena(
        texto:
            'Estou meio desesperado. Viu o Thiago por ai? Ele ficou de trazer a parte final do nosso projeto.',
        proximaCena: 2,
      ),
      OpcaoCena(
        texto:
            'To maluco, me da um gole desse energetico ai, preciso achar o Thiago o quanto antes.',
        proximaCena: 3,
      ),
    ],
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/ambiente_praca/praca_resposta_a.png',
    texto:
        'Relaxa, ha uns 15 minutos vi ele passar meio neurotico tambem. Falou que esqueceu de formatar a citacao de um livro da documentacao nas normas ABNT e foi procurar o livro fisico para nao perder ponto com a banca. Agora va ate a Biblioteca.',
    concluiAmbiente: true,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/ambiente_praca/praca_resposta_b.png',
    texto:
        'Calma ai, respira! Se ajuda, vi ele passar aqui um tempo ja. Disse que esqueceu de formatar a citacao de um livro de engenharia de software nas normas ABNT e foi procurar o livro fisico. Agora va ate a Biblioteca.',
    concluiAmbiente: true,
  ),
];

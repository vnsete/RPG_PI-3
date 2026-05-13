import '../../models/cena.dart';

const List<Cena> pracaAlimentacaoCenas = [
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/ambiente_praca/praca_narrativa.png',
    texto:
        'Hoje e o grande dia! A banca de professores, e ate o reitor estara la para avaliar nosso TCC, mas tem um problema: o Thiago. Ele ficou responsavel por trazer o pendrive com a conexao do banco de dados e mais alguns detalhes para finalizacao do projeto, mas nao o encontrei ate agora em lugar nenhum.',
    proximaCena: 1,
  ),
  Cena(
    tipo: TipoCena.escolha,
    imagem: 'assets/images/ambiente_praca/praca_escolha.png',
    texto: 'Felipe: E ai mano! Preparado para apresentacao hoje?',
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
        'Felipe: Relaxa, ha uns 15 minutos vi ele passar meio neurotico tambem. Falou que esqueceu de formatar a citacao de um livro da documentacao nas normas ABNT e foi procurar o livro fisico para nao perder ponto com a banca.',
    proximaCena: 4,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/ambiente_praca/praca_resposta_b.png',
    texto:
        'Felipe: Calma ai, respira! Se ajuda, vi ele passar aqui um tempo ja... Disse que esqueceu de formatar a citacao de um livro de engenharia de software nas normas ABNT da documentacao do projeto e foi procurar o livro fisico para nao perder ponto com a banca.',
    proximaCena: 4,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/ambiente_praca/praca_narrativa.png',
    texto:
        'Ainda bem que encontrou o Felipe, ajudou demais! Agora ja sabe, o Thiago so pode estar na Biblioteca. Mova-se ate a Biblioteca para iniciar a proxima etapa.',
    concluiAmbiente: true,
  ),
];

import '../../models/cena.dart';

const String _imagemCapela = 'assets/images/ambiente_capela/14.png';

const List<Cena> capelaCenas = [
  Cena(
    tipo: TipoCena.fala,
    imagem: _imagemCapela,
    texto:
        'Correndo em direcao a Capela em busca de Thiago, voce desacelera ao notar que ele nao esta nem dentro nem ao redor do local. Entao avista Seu Joao, um dos monitores que caminham entre a Praca de Alimentacao e a Capela.',
    proximaCena: 1,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/ambiente_capela/15.png',
    texto:
        'Nao e possivel, ele deve estar brincando comigo. A apresentacao e as 21:30 e ja sao 19:30. Fiquei sem presenca na primeira aula por culpa dele. Voce viu um moleque besta passando por aqui?',
    proximaCena: 2,
  ),
  Cena(
    tipo: TipoCena.escolha,
    imagem: 'assets/images/ambiente_capela/16.png',
    texto:
        'Seu Joao: Boa noite jovem, como vai? Sabia que e de bom tom perguntar como os outros estao? Chama-se educacao!',
    opcoes: [
      OpcaoCena(
        texto:
            'Desculpa, Seu Joao, to muito nervoso. Um colega meu esta com um arquivo que preciso para apresentar nosso TCC hoje. Ele e alto e usa oculos. Para onde ele foi?',
        proximaCena: 3,
      ),
      OpcaoCena(
        texto: 'To nem ai, so preciso saber pra onde ele foi. Fala logo!',
        proximaCena: 4,
      ),
    ],
  ),
  Cena(
    tipo: TipoCena.escolha,
    imagem: 'assets/images/ambiente_capela/17.png',
    texto:
        'Seu Joao: Vi sim, mas nao vai ter essa informacao facil nao. Para ficar como licao de vida, me diga qual o resultado dessa expressao de matematica discreta. Se ate o Seu Joao sabe, voce TEM que saber tambem.',
    opcoes: [
      OpcaoCena(texto: 'V', proximaCena: 5),
      OpcaoCena(texto: 'F', proximaCena: 6),
    ],
  ),
  Cena(
    tipo: TipoCena.escolha,
    imagem: 'assets/images/ambiente_capela/18.png',
    texto:
        'Seu Joao: Que falta de respeito! Para ficar como licao de vida e aprender a respeitar os mais velhos, me diga qual o resultado dessa expressao de matematica discreta. Quem sabe eu tenha visto ele por aqui...',
    opcoes: [
      OpcaoCena(texto: 'V', proximaCena: 5),
      OpcaoCena(texto: 'F', proximaCena: 6),
    ],
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/ambiente_capela/19.png',
    texto:
        'Seu Joao: E, jovem... Tem que estudar mais, mas so porque ja passei por um TCC, vou te ajudar. Ele falou que precisava pegar a chave de algum laboratorio do H15 para testar uma API na rede dos alunos, que um fire alguma coisa ia travar. Ele deve ter ido pra la.',
    proximaCena: 7,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/ambiente_capela/20.png',
    texto:
        'Seu Joao: Ai sim, muito bem. Seu colega falou que precisava pegar a chave de algum laboratorio do H15 para testar uma API na rede dos alunos, que um fire alguma coisa ia travar. Ele deve ter ido pra la.',
    proximaCena: 7,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/ambiente_capela/21.png',
    texto:
        'Obrigado Seu Joao, e desculpe pela desconsideracao, nao vai se repetir. Seu Joao completou o quebra-cabeca: o Thiago nao estava fugindo, esta tentando salvar o nosso TCC. Mova-se ate o predio H15 para iniciar a proxima etapa.',
    concluiAmbiente: true,
  ),
];

import '../../models/cena.dart';

const String _imagemH15 = 'assets/images/fotos_projeto/23.png';

const List<Cena> h15Cenas = [
  Cena(
    tipo: TipoCena.fala,
    imagem: _imagemH15,
    texto:
        'Voce chega ao coracao das engenharias, o H15, em busca do bendito pendrive. Passa em frente a sala 10A, onde estao ocorrendo as apresentacoes, e ouve o professor dizendo para outro grupo: "Voces deveriam ter testado a conexao antes de vir pra ca." Voce acelera o passo para encontrar o Thiago.',
    proximaCena: 1,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/fotos_projeto/24.png',
    texto:
        'Vou procurar um monitor, quem sabe viu alguma coisa. Voce entra na sala dos professores e pergunta: Boa noite, tudo bem? Voces viram um menino alto, de oculos, pedindo a chave do laboratorio de informatica?',
    proximaCena: 2,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/fotos_projeto/25.png',
    texto: 'Monitor: Boa noite, veio sim, mas nao me lembro em qual deles.',
    proximaCena: 3,
  ),
  Cena(
    tipo: TipoCena.escolha,
    imagem: 'assets/images/fotos_projeto/26.png',
    texto:
        'Obrigado, vou procura-lo. Voce desce as escadas correndo e observa a bifurcacao dos laboratorios: de um lado, do S01 ao S03, e do outro, do S04 ao S06. Tente encontrar o Thiago com o pendrive.',
    opcoes: [
      OpcaoCena(texto: 'S01', proximaCena: 4),
      OpcaoCena(texto: 'S02', proximaCena: 5),
      OpcaoCena(texto: 'S03', proximaCena: 6),
      OpcaoCena(texto: 'S04', proximaCena: 7),
      OpcaoCena(texto: 'S05', proximaCena: 9),
      OpcaoCena(texto: 'S06', proximaCena: 8),
    ],
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/fotos_projeto/27.png',
    texto: 'A sala esta trancada, ele nao deve estar aqui.',
    proximaCena: 3,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/fotos_projeto/28.png',
    texto: 'O professor Maligno esta dando aula, melhor nao atrapalha-lo.',
    proximaCena: 3,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/fotos_projeto/30.png',
    texto:
        'Tem um grupo de alunos estudando para apresentacao tambem. Voce pergunta: Licenca gente, voces viram o Thiago por aqui? Grupo: Boa noite, por aqui nao.',
    proximaCena: 3,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/fotos_projeto/31.png',
    texto: 'Tambem esta tendo aula.',
    proximaCena: 3,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/fotos_projeto/32.png',
    texto: 'Aqui tambem esta trancado.',
    proximaCena: 3,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/fotos_projeto/33.png',
    texto: 'A luz esta apagada, mas a porta esta destrancada.',
    proximaCena: 10,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/fotos_projeto/34.png',
    texto:
        'Voce abre a porta da sala, e la no fundo a luz de uma das telas te chama, acompanhada de um ronco profundo. Em duvida, caminha ate la e adivinha quem esta dormindo com o pendrive na mao...',
    proximaCena: 11,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/fotos_projeto/35.png',
    texto: 'ACORDA THIAGO!!! A apresentacao e em 20 minutos!',
    proximaCena: 12,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/fotos_projeto/35.png',
    texto: 'Thiago: MEU DEUS! Eu cai no sono aqui, vamos testar isso logo.',
    proximaCena: 13,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/fotos_projeto/36.png',
    texto:
        'Voces testam o programa, fazem os acabamentos e... VOILA! Tudo certo para a apresentacao.',
    proximaCena: 14,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/fotos_projeto/36.png',
    texto:
        'Thiago: Vamos logo para a sala, o restante do grupo deve estar nos esperando! Mova-se ate a sala 10A, no H15, para iniciar a proxima etapa.',
    concluiAmbiente: true,
  ),
];

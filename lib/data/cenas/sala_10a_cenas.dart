import '../../models/cena.dart';

const String _imagemSala10a = 'assets/images/ambiente_sala_10a/38.png';

const List<Cena> sala10aCenas = [
  Cena(
    tipo: TipoCena.escolha,
    imagem: _imagemSala10a,
    texto: 'Chegando na porta da sala, voces avistam Samuel e Vinicius.',
    opcoes: [
      OpcaoCena(
        texto: 'Deu sim, foi um sucesso.',
        proximaCena: 1,
      ),
      OpcaoCena(
        texto:
            'Voces nao tem ideia do que aconteceu, o Thiago quase acabou com tudo!',
        proximaCena: 2,
      ),
    ],
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/ambiente_sala_10a/39.png',
    texto: 'Samuel: Que bom! Bora entao.',
    proximaCena: 4,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/ambiente_sala_10a/40.png',
    texto: 'Samuel: Como assim, o que rolou?',
    proximaCena: 3,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/ambiente_sala_10a/40.png',
    texto:
        'Vinicius: Nao interessa, depois eles contam. Vamos reprovar se nao entrarmos agora na sala!',
    proximaCena: 4,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/ambiente_sala_10a/41.png',
    texto:
        'Entrando na sala, voces realizam a apresentacao. Apos finalizada...',
    proximaCena: 5,
  ),
  Cena(
    tipo: TipoCena.escolha,
    imagem: 'assets/images/ambiente_sala_10a/42.png',
    texto:
        'Picolo: Muito bom, parabens! Voces estao aprovados. Que bom que testaram tudo antes, sao bem organizados.',
    opcoes: [
      OpcaoCena(
        texto: 'Nao foi bem assim, professor, kkkkkkk.',
        proximaCena: 6,
      ),
      OpcaoCena(
        texto: 'Sim, professor. Testamos tudo com antecedencia!',
        proximaCena: 7,
      ),
    ],
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/ambiente_sala_10a/43.png',
    texto:
        'Samuel: Isso nao vem ao caso, o que importa e que o trabalho e impecavel.',
    proximaCena: 8,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/ambiente_sala_10a/44.png',
    texto: 'Samuel: Parabens, grupo. Espero encontrar voces pelos corredores.',
    proximaCena: 8,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/ambiente_sala_10a/45.png',
    texto:
        'Voces comemoram como se o Brasil tivesse conquistado o hexa, e no fim das contas e de se comemorar mesmo. Afinal, toda essa aventura tinha que valer a pena. Parabens e obrigado por nos ajudar. Fim do jogo.',
    proximaCena: 9,
  ),
  Cena(
    tipo: TipoCena.fim,
    imagem: 'assets/images/ambiente_sala_10a/46.png',
    texto: 'Fim do jogo. Obrigado pela ajuda!',
    concluiAmbiente: true,
  ),
];

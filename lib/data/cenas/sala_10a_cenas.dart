import '../../models/cena.dart';

const String _imagemSala10a = 'assets/images/tela_inicial.png';

const List<Cena> sala10aCenas = [
  Cena(
    tipo: TipoCena.fala,
    imagem: _imagemSala10a,
    texto: 'Chegando na porta da sala, voces avistam Samuel e Vinicius.',
    proximaCena: 1,
  ),
  Cena(
    tipo: TipoCena.escolha,
    imagem: _imagemSala10a,
    texto:
        'Samuel: Caramba, onde voces estavam? Vinicius: Pois e, que demora. Ja era para termos apresentado, deu certo os testes?',
    opcoes: [
      OpcaoCena(
        texto: 'Deu sim, foi um sucesso.',
        proximaCena: 2,
      ),
      OpcaoCena(
        texto:
            'Voces nao tem ideia do que aconteceu, o Thiago quase acabou com tudo!',
        proximaCena: 3,
      ),
    ],
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: _imagemSala10a,
    texto: 'Samuel: Que bom! Bora entao.',
    proximaCena: 5,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: _imagemSala10a,
    texto: 'Samuel: Como assim, o que rolou?',
    proximaCena: 4,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: _imagemSala10a,
    texto:
        'Vinicius: Nao interessa, depois eles contam. Vamos reprovar se nao entrarmos agora na sala!',
    proximaCena: 5,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: _imagemSala10a,
    texto:
        'Entrando na sala, voces realizam a apresentacao. Apos finalizada...',
    proximaCena: 6,
  ),
  Cena(
    tipo: TipoCena.escolha,
    imagem: _imagemSala10a,
    texto:
        'Picolo: Muito bom, parabens! Voces estao aprovados. Que bom que testaram tudo antes, sao bem organizados.',
    opcoes: [
      OpcaoCena(
        texto: 'Nao foi bem assim, professor, kkkkkkk.',
        proximaCena: 7,
      ),
      OpcaoCena(
        texto: 'Sim, professor. Testamos tudo com antecedencia!',
        proximaCena: 8,
      ),
    ],
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: _imagemSala10a,
    texto:
        'Samuel: Isso nao vem ao caso, o que importa e que o trabalho e impecavel.',
    proximaCena: 9,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: _imagemSala10a,
    texto: 'Samuel: Parabens, grupo. Espero encontrar voces pelos corredores.',
    proximaCena: 9,
  ),
  Cena(
    tipo: TipoCena.fim,
    imagem: _imagemSala10a,
    texto:
        'Voces comemoram como se o Brasil tivesse conquistado o hexa, e no fim das contas e de se comemorar mesmo. Afinal, toda essa aventura tinha que valer a pena. Parabens e obrigado por nos ajudar. Fim do jogo.',
    concluiAmbiente: true,
  ),
];

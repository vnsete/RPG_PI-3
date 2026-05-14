import '../../models/cena.dart';

const String _imagemBiblioteca = 'assets/images/fotos_projeto/8.png';

const List<Cena> bibliotecaCenas = [
  Cena(
    tipo: TipoCena.fala,
    imagem: _imagemBiblioteca,
    texto:
        'Correndo, voce chega ate a biblioteca com a respiracao ofegante contrastando com o silencio ensurdecedor. Ao ir ate as estantes de Tecnologia procurando por Thiago, encontra o Ibrahim.',
    proximaCena: 1,
  ),
  Cena(
    tipo: TipoCena.escolha,
    imagem: 'assets/images/fotos_projeto/9.png',
    texto:
        'Ibrahim: Fica quieto, mano! Controla essa respiracao, ta procurando o Thiago ne? Ele pegou um livro e saiu correndo, nem cadastrou o emprestimo com a recepcionista. Ate brigaram com ele, mas ele nao parou.',
    opcoes: [
      OpcaoCena(
        texto:
            '(Sussurrando) Desculpa, to muito nervoso. Viu se ele deixou um pendrive cair? Para onde ele foi?',
        proximaCena: 2,
      ),
      OpcaoCena(
        texto:
            '(Desesperado, ignorando a regra do silencio) O QUE? ELE FUGIU DE NOVO?! Pelo amor de Deus, pra onde ele foi?',
        proximaCena: 3,
      ),
    ],
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/fotos_projeto/10.png',
    texto:
        'Ibrahim: Nao vi nada nao, mas pelo desespero dele, parecia estar rezando. Quem sabe nao foi fazer isso no local certo.',
    proximaCena: 4,
  ),
  Cena(
    tipo: TipoCena.resposta,
    imagem: 'assets/images/fotos_projeto/11.png',
    texto:
        'Ibrahim: Cala a boca! Jaja o seguranca aparece. Ele saiu delirando que precisava de um lugar sozinho, mais calmo que aqui.',
    proximaCena: 4,
  ),
  Cena(
    tipo: TipoCena.fala,
    imagem: 'assets/images/fotos_projeto/12.png',
    texto:
        'A Capela! Valeu, mano, voce me salvou! Mova-se ate a Capela para iniciar a proxima etapa.',
    concluiAmbiente: true,
  ),
];

# Registro de Alteracoes - Salve o TCC! (RPG)

## 14/05/2026

### Integracao com alteracoes do GitHub

- Baixada a referencia mais recente de `https://github.com/vnsete/RPG_PI-3`.
- Incorporada a entrada `FOTOS PROJETO.zip` no `.gitignore`.
- Mantida a ideia de padronizar a tela de capitulo, mas adaptada ao fluxo atual do projeto.

### Tela de capitulo

- Cenas sem opcoes agora avancam com toque em qualquer lugar da tela.
- O botao `CONTINUAR` foi substituido por um indicador discreto: `TOQUE NA TELA PARA CONTINUAR`.
- Cenas de escolha continuam usando botoes, para evitar selecoes acidentais.
- As opcoes usam rolagem quando necessario, evitando overflow em telas menores.
- As escolhas do jogador passam a ser registradas pelo servico de progresso.

### Imagens

- As imagens do arquivo `FOTOS PROJETO.zip` foram extraidas para `assets/images/fotos_projeto/`.
- O `pubspec.yaml` registra a nova pasta de imagens.
- As cenas foram ligadas as imagens correspondentes do roteiro.

### Revisao de fluxo

- O jogo carrega o progresso salvo ao abrir.
- O final do jogo agora exibe uma tela propria de encerramento.
- Cenas duplicadas ou inacessiveis foram removidas dos fluxos de Capela, H15 e Sala 10A.

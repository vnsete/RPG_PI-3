# Salve o TCC! - Jogo RPG Mobile

Projeto Flutter em formato de jogo mobile textual com geolocalização, narrativa interativa e persistência de progresso no Firebase.

## O que foi implementado

- Tela inicial do jogo.
- Ambientes desbloqueados por geolocalização.
- Diálogos e escolhas baseados no roteiro do relatório.
- Persistência de progresso com Firebase/Firestore.
- Botão de simulação para testes em sala ou laboratório.
- Cadastro estático de ambientes em `lib/data/ambientes_mock.dart`.
- Design lógico NoSQL em `assets/data/design_banco_nosql.json`.

## Como rodar

Abra esta pasta no VS Code:

```text
C:\Users\samue\Downloads\salve_o_tcc_celular_rpg
```

Depois rode:

```bash
flutter pub get
flutter run
```

Para testar no celular, selecione um dispositivo Android físico ou emulador Android.

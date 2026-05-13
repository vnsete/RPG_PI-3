# Salve o TCC! - Jogo RPG Mobile

Projeto Flutter em formato de jogo de celular, baseado nas telas enviadas.

## O que foi implementado
- Tela inicial vertical estilo jogo mobile.
- Telas de ambiente com desbloqueio progressivo.
- Tela de espera por geolocalização.
- Verificação real de GPS com `geolocator`.
- Botão de simulação para testes em sala/laboratório.
- Persistência de progresso local com `shared_preferences`.
- Cadastro estático de ambientes em `lib/data/ambientes_mock.dart`.
- Design lógico NoSQL em `assets/data/design_banco_nosql.json`.

## Como rodar
1. Abra a pasta no VS Code.
2. Rode:

```bash
flutter pub get
flutter run
```

## Importante
Para rodar como aplicativo de celular, use Android físico ou emulador Android.
Não selecione Chrome.

## Permissão Android
Se você criou o projeto com `flutter create`, confirme no arquivo:
`android/app/src/main/AndroidManifest.xml`

Dentro de `<manifest>`, antes de `<application>`, coloque:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

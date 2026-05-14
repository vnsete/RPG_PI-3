# 📋 Registro de Alterações - Salve o TCC! (RPG)

## 📅 Data: 14/05/2026

---

### 🔧 1. Layout Padronizado - Tela de Capítulo
**Arquivo:** `lib/screens/jogo/tela_capitulo.dart`

- **Removido** o layout diferenciado que existia apenas para a Praça de Alimentação (`_usaImagemComTexto`)
- **Padronizado** o visual de todos os ambientes: agora TODOS usam o mesmo estilo:
  - Imagem de fundo (cover)
  - Overlay escuro (35% opacidade)
  - Caixa preta semi-transparente (82% opacidade) com cantos arredondados
  - Título "Capítulo X"
  - Nome do ambiente
  - Texto narrativo / falas
  - Botões de escolha ou "CONTINUAR" / "PRÓXIMO CAPÍTULO"
  - Layout com `SingleChildScrollView` para evitar overflow em textos longos

---

### 🔧 2. Estrutura de Pastas de Imagens
**Pastas criadas em:** `assets/images/`

| Pasta | Status |
|-------|--------|
| `ambiente_praca/` | ✅ Já existia (6 imagens) |
| `ambiente_biblioteca/` | ✅ Já existia (1 imagem) |
| `ambiente_capela/` | ✅ **Criada** (vazia - aguardando imagens) |
| `ambiente_h15/` | ✅ **Criada** (vazia - aguardando imagens) |
| `ambiente_sala_10a/` | ✅ **Criada** (vazia - aguardando imagens) |

---

### 🔧 3. Caminhos de Imagens Corrigidos
**Arquivos alterados:**
- `lib/data/ambientes_mock.dart`
- `lib/data/cenas/capela_cenas.dart`
- `lib/data/cenas/h15_cenas.dart`
- `lib/data/cenas/sala_10a_cenas.dart`

Todos os ambientes agora apontam para suas respectivas pastas.
Ambientes sem imagens próprias usam `tela_inicial.png` como fallback temporário.

---

### 📁 Estrutura Final de Imagens
```
assets/images/
├── tela_inicial.png
├── ambiente_praca/
│   ├── ambiente_1_espera.png
│   ├── praca_narrativa.png
│   ├── praca_escolha.png
│   ├── praca_resposta_a.png
│   └── praca_resposta_b.png
├── ambiente_biblioteca/
│   └── ambiente_2_espera.png
├── ambiente_capela/     ← Aguardando imagens
├── ambiente_h15/        ← Aguardando imagens
└── ambiente_sala_10a/   ← Aguardando imagens
```

---

### 📝 Próximos Passos Sugeridos
- [ ] Adicionar imagens específicas para Capela, H15 e Sala 10A
- [ ] Testar o fluxo completo do jogo
- [ ] Ajustar textos/diálogos se necessário
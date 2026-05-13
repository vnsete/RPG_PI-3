import 'package:flutter_test/flutter_test.dart';
import 'package:salve_o_tcc_celular_rpg/main.dart';

void main() {
  testWidgets('mostra a tela inicial do jogo', (tester) async {
    await tester.pumpWidget(const SalveOTccApp());

    expect(find.text('TOQUE PARA COMEÇAR'), findsOneWidget);
  });
}

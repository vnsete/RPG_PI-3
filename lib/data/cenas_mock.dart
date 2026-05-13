import '../models/cena.dart';
import 'cenas/biblioteca_cenas.dart';
import 'cenas/capela_cenas.dart';
import 'cenas/h15_cenas.dart';
import 'cenas/praca_alimentacao_cenas.dart';
import 'cenas/sala_10a_cenas.dart';

const Map<String, List<Cena>> cenasPorAmbiente = {
  'praca_alimentacao': pracaAlimentacaoCenas,
  'biblioteca': bibliotecaCenas,
  'capela': capelaCenas,
  'h15': h15Cenas,
  'sala_10a': sala10aCenas,
};

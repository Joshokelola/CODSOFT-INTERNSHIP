import 'package:hive_ce/hive.dart';
import 'package:quotes/features/quotes/domain/quote.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<Quote>()])
// Annotations must be on some element
// ignore: unused_element
void _() {}
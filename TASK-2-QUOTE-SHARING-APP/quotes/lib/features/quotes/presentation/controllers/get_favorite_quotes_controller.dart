import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes/features/quotes/data/datasources/quote_local_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/quote.dart';

part 'get_favorite_quotes_controller.g.dart';

@riverpod
FutureOr<List<Quote>> getFavoriteQuotes(Ref ref) async {
  var favoriteQuotes =
      await ref.read(quoteLocalDataSourceImplProvider).getFavoriteQuotes();
  return favoriteQuotes;
}

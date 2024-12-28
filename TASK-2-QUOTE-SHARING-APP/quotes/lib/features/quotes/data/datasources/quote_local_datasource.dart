import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/quote.dart';
part 'quote_local_datasource.g.dart';

abstract class QuoteLocalDataSource {
  Future<List<Quote>> getFavoriteQuotes();
  Future<void> addQuoteToFavorites(Quote quote);
  Future<void> removeQuoteFromFavorites(String id);
  Future<Quote?> getCachedDailyQuote();
  Future<void> cacheDailyQuote(Quote quote);
   ValueListenable<Box<Quote>> watchFavoriteQuotes();
}

class QuoteLocalDataSourceImpl implements QuoteLocalDataSource {
  static const String DAILY_QUOTE_BOX = 'daily_quote_box';
  static const String FAVORITES_BOX = 'favorites_box';
  final Box<Quote> favoritesBox;
  final Box<Quote> dailyQuoteBox;
  QuoteLocalDataSourceImpl({
    required this.favoritesBox,
    required this.dailyQuoteBox,
  });

  @override
  Future<List<Quote>> getFavoriteQuotes() async {
    return favoritesBox.values.toList();
  }

  @override
  Future<void> addQuoteToFavorites(Quote quote) async {
    final quoteCopy = quote.copyWith();
    await favoritesBox.put(quote.id, quoteCopy);
  }

  bool checkIfIsFavorite(String quoteId) {
    final isFavorite = favoritesBox.values.any((quote) => quote.id == quoteId);

    return isFavorite;
  }

  @override
  Future<void> removeQuoteFromFavorites(String id) async {
    await favoritesBox.delete(id);
  }

  @override
  Future<Quote?> getCachedDailyQuote() async {
    final quote = dailyQuoteBox.get('daily_quote');
    return quote;
  }

  @override
  Future<void> cacheDailyQuote(Quote quote) async {
    final quoteCopy = quote.copyWith();
    await dailyQuoteBox.put('daily_quote', quoteCopy);
  }

  @override
  ValueListenable<Box<Quote>> watchFavoriteQuotes() {
    return favoritesBox.listenable();
  }
}

@riverpod
QuoteLocalDataSourceImpl quoteLocalDataSourceImpl(
    QuoteLocalDataSourceImplRef ref) {
  var favoritesBox = Hive.box<Quote>(QuoteLocalDataSourceImpl.FAVORITES_BOX);
  var dailyQuoteBox = Hive.box<Quote>(QuoteLocalDataSourceImpl.DAILY_QUOTE_BOX);
  return QuoteLocalDataSourceImpl(
    favoritesBox: favoritesBox,
    dailyQuoteBox: dailyQuoteBox,
  );
}

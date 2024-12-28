import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:quotes/features/quotes/data/datasources/quote_local_datasource.dart';
import 'package:quotes/features/quotes/data/datasources/quote_remote_datasource.dart';
import 'package:quotes/features/quotes/data/repositories/quote_repo.dart';
import 'package:quotes/features/quotes/domain/quote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_daily_quote_controller.g.dart';

@riverpod
class QuoteController extends _$QuoteController {
  @override
  FutureOr<Quote> build() {
    // Initial fetch
    return _fetchQuote();
  }

  Future<Quote> _fetchQuote() async {
    final repository = ref.read(quoteRepositoryImplProvider);
    return repository.getDailyQuote();
  }

  bool checkIfIsFavorite(String quoteId) {
    final localStorageRepo = ref.read(quoteLocalDataSourceImplProvider);
    return localStorageRepo.checkIfIsFavorite(quoteId);
  }

  Future<void> removeFromFavorites(String quoteId) async {
    final localStorageRepo = ref.read(quoteLocalDataSourceImplProvider);
    await localStorageRepo.removeQuoteFromFavorites(quoteId);
    // Optionally notify listeners that the favorites state has changed
    ref.notifyListeners();
  }

  Future<void> toggleFavorite(Quote quote) async {
    final isFavorite = checkIfIsFavorite(quote.id!);
    if (isFavorite) {
      await removeFromFavorites(quote.id!);
      ref.notifyListeners();
    } else {
      await addToFavorites(quote);
      ref.notifyListeners();
    }
  }

  Future<void> addToFavorites(Quote quote) async {
    final localStorageRepo = ref.read(quoteLocalDataSourceImplProvider);
    await localStorageRepo.addQuoteToFavorites(quote);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchQuote);
  }
}

@riverpod
bool isFavorite(IsFavoriteRef ref, String quoteId) {
  final controller = ref.watch(quoteControllerProvider.notifier);
  return controller.checkIfIsFavorite(quoteId);
}

@riverpod
ValueListenable<Box<Quote>> favoriteQuotesListenable(FavoriteQuotesListenableRef ref) {
  final dataSource = ref.read(quoteLocalDataSourceImplProvider);
  return dataSource.watchFavoriteQuotes();
}
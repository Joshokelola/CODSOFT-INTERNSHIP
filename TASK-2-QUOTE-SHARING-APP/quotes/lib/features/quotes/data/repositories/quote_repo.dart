import 'package:flutter/material.dart';
import 'package:quotes/core/errors/failure.dart';
import 'package:quotes/core/providers/core_providers.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/quote.dart';
import '../datasources/quote_local_datasource.dart';
import '../datasources/quote_remote_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'quote_repo.g.dart';

abstract class QuoteRepository {
  Future<Quote> getDailyQuote();
}

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;
  final QuoteLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  QuoteRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Quote> getDailyQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuote = await remoteDataSource.getDailyQuote();

        await localDataSource.cacheDailyQuote(remoteQuote);
        return remoteQuote;
      } on Failed catch (e) {
        debugPrint(e.message);
        return _getLastCachedQuote();
      }
    } else {
      return _getLastCachedQuote();
    }
  }

  Future<Quote> _getLastCachedQuote() async {
    final cachedQuote = await localDataSource.getCachedDailyQuote();
    if (cachedQuote != null) {
      return cachedQuote;
    }
    throw Failed(
        code: 'no-stored-quote', message: 'No quotes were found locally.');
  }
}

@riverpod
QuoteRepositoryImpl quoteRepositoryImpl(QuoteRepositoryImplRef ref) {
  return QuoteRepositoryImpl(
      remoteDataSource: ref.read(quoteRemoteDataSourceProvider),
      localDataSource: ref.read(quoteLocalDataSourceImplProvider),
      networkInfo: ref.read(networkInfoProvider));
}

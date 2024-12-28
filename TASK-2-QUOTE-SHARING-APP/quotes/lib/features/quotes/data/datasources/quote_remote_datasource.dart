// Interface
import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';
import 'package:quotes/core/errors/failure.dart';
import 'package:quotes/core/providers/core_providers.dart';
import 'package:quotes/features/quotes/domain/quote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:io'; // For HttpClientAdapter and SSL handling
import 'package:dio/io.dart';

part 'quote_remote_datasource.g.dart';

abstract class QuoteRemoteDataSource {
  Future<Quote> getDailyQuote();
}

// Implementation
class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final Dio dio;

  QuoteRemoteDataSourceImpl({required this.dio}) {
    // Ignore SSL issues if necessary
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  @override
  Future<Quote> getDailyQuote() async {
    try {
      final response = await dio.get('https://api.quotable.io/random');
      var quote = Quote.fromJson(response.data);

      final cachedBox = await Hive.openBox<Quote>('favorites_box');
      final cachedQuote = cachedBox.values.cast<Quote?>().firstWhere(
            (q) => q?.id == quote.id,
            orElse: () => null,
          );

      if (cachedQuote != null) {
        quote.isFavorite = true;
      }

      return quote;
    } on DioException catch (e) {
      throw Failed(
        code: e.response?.statusCode ?? 0,
        message: e.message ?? 'An unexpected error occurred',
      );
    }
  }
}

@riverpod
QuoteRemoteDataSourceImpl quoteRemoteDataSource(QuoteRemoteDataSourceRef ref) {
  return QuoteRemoteDataSourceImpl(dio: ref.read(dioProvider));
}

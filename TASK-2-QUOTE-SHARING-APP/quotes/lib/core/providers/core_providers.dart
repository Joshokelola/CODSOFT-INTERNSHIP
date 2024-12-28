// core/providers/core_providers.dart

import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../network/network_info.dart';

part 'core_providers.g.dart';

@riverpod
NetworkInfo networkInfo(NetworkInfoRef ref) {
  return NetworkInfoImpl(
    connectionChecker: InternetConnection(),
  );
}

@riverpod
Dio dio(DioRef ref) {
  return Dio();
}

@riverpod
Stream<InternetStatus> internetStatus(InternetStatusRef ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  return networkInfo.onStatusChange;
}

// void _refreshQuote() {
//     ref.read(quoteControllerProvider.notifier).refresh();
//   }

//   void _addToFavorites(Quote quote) {
//     ref.read(quoteControllerProvider.notifier).addToFavorites(quote);
//   }

//   void _shareQuote(Quote quote) {
//     Share.share('''"${quote.text}"\n\n- ${quote.author}''');
//   }
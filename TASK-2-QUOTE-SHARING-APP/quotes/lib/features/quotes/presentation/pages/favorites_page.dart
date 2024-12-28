import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:quotes/features/quotes/presentation/controllers/get_daily_quote_controller.dart';
import 'package:quotes/features/quotes/presentation/controllers/get_favorite_quotes_controller.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/quote.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getFavoriteQuotesProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var favoriteQuotes = ref.watch(favoriteQuotesListenableProvider);
    return ValueListenableBuilder<Box<Quote>>(
        valueListenable: favoriteQuotes,
        builder: (context, box, child) {
          final data = box.values.toList();

          if (data.isEmpty) {
            return const Center(
              child: Text('No favorite quotes yet'),
            );
          }
          return Scaffold(
              backgroundColor: colorScheme.background,
              appBar: AppBar(
                backgroundColor: colorScheme.surface,
                elevation: 0,
                title: Text(
                  'Favorite Quotes',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              body: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      elevation: 1,
                      color: colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index].text,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "- ${data[index].author}",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color:
                                        colorScheme.onSurface.withOpacity(0.7),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.share),
                                      onPressed: () {
                                        // Implement share logic
                                        Share.share(
                                            '''"${data[index].text}"\n\n- ${data[index].author}''');
                                      },
                                      color: colorScheme.primary,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      onPressed: () {
                                        // Implement delete logic
                                        ref
                                            .read(quoteControllerProvider
                                                .notifier)
                                            .removeFromFavorites(
                                                data[index].id!);
                                      },
                                      color: colorScheme.error,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
        });
  }
}

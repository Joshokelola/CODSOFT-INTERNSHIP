import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:quotes/features/quotes/presentation/controllers/get_daily_quote_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
import '../../domain/quote.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(quoteControllerProvider.notifier).build();
    });
  }

  bool isFavorite = false;
  var currentQuote = Quote(id: '', text: '', author: '');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final quoteController = ref.watch(quoteControllerProvider);
    final internetStatus = ref.watch(internetStatusProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: Text(
          'Daily Quote',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Banner for No Internet Connection
          if (internetStatus.value == InternetStatus.disconnected)
            Container(
              width: double.infinity,
              color: Colors.redAccent,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'No Internet Connection',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child:
                    _buildQuoteCard(context, quoteController, internetStatus),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(
      BuildContext context,
      AsyncValue<Quote> quoteController,
      AsyncValue<InternetStatus> internetStatus) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.format_quote,
              size: 40,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            // Quote Section
            quoteController.when(
              data: (data) {
                currentQuote = data;
                isFavorite = ref
                    .read(quoteControllerProvider.notifier)
                    .checkIfIsFavorite(data.id!);
                return Column(
                  children: [
                    Text(
                      data.text,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "- ${data.author}",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                );
              },
              error: (error, __) => Text(
                error.toString(),
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              loading: () => const SizedBox(
                height: 60, // Adjust size as needed
                width: 60,
                child: CircularProgressIndicator(),
              ),
            ),
            const SizedBox(height: 32),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.refresh,
                  label: 'New Quote',
                  onPressed: () => _refreshQuote(internetStatus.maybeWhen(
                      data: (data) => data,
                      orElse: () => InternetStatus.disconnected)),
                ),
                _buildActionButton(
                  icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                  label: 'Favorite',
                  onPressed: () {
                    final controller =
                        ref.read(quoteControllerProvider.notifier);
                    setState(() {
                      controller.toggleFavorite(currentQuote);
                      isFavorite = !isFavorite;
                    });
                  },
                ),
                _buildActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  onPressed: () {
                    Share.share(
                        '''"${currentQuote.text}"\n\n- ${currentQuote.author}''');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _refreshQuote(InternetStatus internetStatus) {
    if (internetStatus == InternetStatus.disconnected) {
      _showNoInternetDialog();
    } else {
      ref.read(quoteControllerProvider.notifier).refresh();
    }
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
              'Unable to fetch a new quote. Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

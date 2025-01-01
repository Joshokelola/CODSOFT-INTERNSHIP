// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizSessionControllerHash() =>
    r'b68ba31b982cee578fdca74a79cb591a1d17dd06';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$QuizSessionController
    extends BuildlessAutoDisposeNotifier<QuizSession> {
  late final Quiz quiz;

  QuizSession build(
    Quiz quiz,
  );
}

/// See also [QuizSessionController].
@ProviderFor(QuizSessionController)
const quizSessionControllerProvider = QuizSessionControllerFamily();

/// See also [QuizSessionController].
class QuizSessionControllerFamily extends Family<QuizSession> {
  /// See also [QuizSessionController].
  const QuizSessionControllerFamily();

  /// See also [QuizSessionController].
  QuizSessionControllerProvider call(
    Quiz quiz,
  ) {
    return QuizSessionControllerProvider(
      quiz,
    );
  }

  @override
  QuizSessionControllerProvider getProviderOverride(
    covariant QuizSessionControllerProvider provider,
  ) {
    return call(
      provider.quiz,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'quizSessionControllerProvider';
}

/// See also [QuizSessionController].
class QuizSessionControllerProvider extends AutoDisposeNotifierProviderImpl<
    QuizSessionController, QuizSession> {
  /// See also [QuizSessionController].
  QuizSessionControllerProvider(
    Quiz quiz,
  ) : this._internal(
          () => QuizSessionController()..quiz = quiz,
          from: quizSessionControllerProvider,
          name: r'quizSessionControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$quizSessionControllerHash,
          dependencies: QuizSessionControllerFamily._dependencies,
          allTransitiveDependencies:
              QuizSessionControllerFamily._allTransitiveDependencies,
          quiz: quiz,
        );

  QuizSessionControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quiz,
  }) : super.internal();

  final Quiz quiz;

  @override
  QuizSession runNotifierBuild(
    covariant QuizSessionController notifier,
  ) {
    return notifier.build(
      quiz,
    );
  }

  @override
  Override overrideWith(QuizSessionController Function() create) {
    return ProviderOverride(
      origin: this,
      override: QuizSessionControllerProvider._internal(
        () => create()..quiz = quiz,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quiz: quiz,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<QuizSessionController, QuizSession>
      createElement() {
    return _QuizSessionControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizSessionControllerProvider && other.quiz == quiz;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quiz.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QuizSessionControllerRef on AutoDisposeNotifierProviderRef<QuizSession> {
  /// The parameter `quiz` of this provider.
  Quiz get quiz;
}

class _QuizSessionControllerProviderElement
    extends AutoDisposeNotifierProviderElement<QuizSessionController,
        QuizSession> with QuizSessionControllerRef {
  _QuizSessionControllerProviderElement(super.provider);

  @override
  Quiz get quiz => (origin as QuizSessionControllerProvider).quiz;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selectedTaskProvider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedTaskHash() => r'cdbf5e2c9dbaa84a2f90fd33e878840e2cc0884f';

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

/// See also [selectedTask].
@ProviderFor(selectedTask)
const selectedTaskProvider = SelectedTaskFamily();

/// See also [selectedTask].
class SelectedTaskFamily extends Family<AsyncValue<TodoTask?>> {
  /// See also [selectedTask].
  const SelectedTaskFamily();

  /// See also [selectedTask].
  SelectedTaskProvider call(
    int taskId,
  ) {
    return SelectedTaskProvider(
      taskId,
    );
  }

  @override
  SelectedTaskProvider getProviderOverride(
    covariant SelectedTaskProvider provider,
  ) {
    return call(
      provider.taskId,
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
  String? get name => r'selectedTaskProvider';
}

/// See also [selectedTask].
class SelectedTaskProvider extends AutoDisposeFutureProvider<TodoTask?> {
  /// See also [selectedTask].
  SelectedTaskProvider(
    int taskId,
  ) : this._internal(
          (ref) => selectedTask(
            ref as SelectedTaskRef,
            taskId,
          ),
          from: selectedTaskProvider,
          name: r'selectedTaskProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedTaskHash,
          dependencies: SelectedTaskFamily._dependencies,
          allTransitiveDependencies:
              SelectedTaskFamily._allTransitiveDependencies,
          taskId: taskId,
        );

  SelectedTaskProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskId,
  }) : super.internal();

  final int taskId;

  @override
  Override overrideWith(
    FutureOr<TodoTask?> Function(SelectedTaskRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SelectedTaskProvider._internal(
        (ref) => create(ref as SelectedTaskRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskId: taskId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TodoTask?> createElement() {
    return _SelectedTaskProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedTaskProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SelectedTaskRef on AutoDisposeFutureProviderRef<TodoTask?> {
  /// The parameter `taskId` of this provider.
  int get taskId;
}

class _SelectedTaskProviderElement
    extends AutoDisposeFutureProviderElement<TodoTask?> with SelectedTaskRef {
  _SelectedTaskProviderElement(super.provider);

  @override
  int get taskId => (origin as SelectedTaskProvider).taskId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

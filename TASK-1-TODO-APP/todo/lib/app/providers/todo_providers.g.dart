// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoRepositoryHash() => r'd47dc48cbed082f7a23a5d6135e990ea573cbc9f';

/// See also [todoRepository].
@ProviderFor(todoRepository)
final todoRepositoryProvider = AutoDisposeProvider<TodoRepository>.internal(
  todoRepository,
  name: r'todoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodoRepositoryRef = AutoDisposeProviderRef<TodoRepository>;
String _$objectBoxHash() => r'8b532e679ee2ef8ad99ae1a6940ca033d904b1e2';

/// See also [objectBox].
@ProviderFor(objectBox)
final objectBoxProvider = Provider<ObjectBox>.internal(
  objectBox,
  name: r'objectBoxProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$objectBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ObjectBoxRef = ProviderRef<ObjectBox>;
String _$todoNotifierHash() => r'f25fad719f3c04fbe9067b3d0586a01e53c66330';

/// See also [TodoNotifier].
@ProviderFor(TodoNotifier)
final todoNotifierProvider =
    AutoDisposeStreamNotifierProvider<TodoNotifier, List<TodoTask>>.internal(
  TodoNotifier.new,
  name: r'todoNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoNotifier = AutoDisposeStreamNotifier<List<TodoTask>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

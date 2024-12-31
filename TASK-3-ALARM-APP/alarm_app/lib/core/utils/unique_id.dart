import 'dart:math';

class UniqueIdGenerator {
  static final Set<int> _usedIds = {};

  /// Generates a unique integer ID that is not 0 or -1
  static int generateId() {
    final Random random = Random();
    int newId;

    do {
      // Generate a random positive integer greater than 0
      newId = random.nextInt(1 << 31 - 1) + 1;
    } while (newId == -1 || _usedIds.contains(newId));

    _usedIds.add(newId);
    return newId;
  }

  /// Optionally, allow releasing unused IDs
  static void releaseId(int id) {
    _usedIds.remove(id);
  }
}

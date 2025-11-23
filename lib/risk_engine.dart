class RiskEngine {
  static const Map<String, List<String>> _map = {
    'peanuts': ['peanut', 'arachis'],
    'gluten': ['wheat', 'barley', 'rye', 'gluten'],
    'lactose': ['milk', 'lactose', 'whey', 'casein'],
    'fodmap': ['garlic', 'onion', 'honey', 'apple'],
  };

  static ({bool safe, List<String> flagged}) check(String text, List<String> avoid) {
    final flagged = <String>{};
    for (final item in avoid) {
      final words = _map[item] ?? [];
      for (final w in words) {
        if (text.contains(w)) flagged.add(w);
      }
    }
    return (safe: flagged.isEmpty, flagged: flagged.toList());
  }
}

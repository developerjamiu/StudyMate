enum Level { ND1, ND2, HND1, HND2 }

extension LevelExtension on Level {
  String get name {
    switch (this) {
      case Level.ND1:
        return 'ND 1';
      case Level.ND2:
        return 'ND 2';
      case Level.HND1:
        return 'HND 1';
      case Level.HND2:
        return 'HND 2';
    }
  }
}

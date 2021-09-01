enum Priority { normal, low, high }

extension PriorityExtension on Priority {
  String get name {
    switch (this) {
      case Priority.normal:
        return 'Normal';
      case Priority.low:
        return 'Low';
      case Priority.high:
        return 'High';
    }
  }
}

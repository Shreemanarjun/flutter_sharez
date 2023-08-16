sealed class ReceieveScan {
  const ReceieveScan();
}

class InitialReceiveScan implements ReceieveScan {
  const InitialReceiveScan();
}

class Scanning implements ReceieveScan {
  const Scanning();
}

class ScanError implements ReceieveScan {
  final String error;
  ScanError({
    required this.error,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScanError && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class RangeHeader {
  final int start;
  final int? end;

  RangeHeader(this.start, this.end);

  @override
  String toString() {
    if (end != null) {
      return 'bytes $start-$end';
    } else {
      return 'bytes $start-';
    }
  }
}

RangeHeader parseRangeHeader(String? rangeHeaderValue, int fileSize) {
  if (rangeHeaderValue == null) {
    return RangeHeader(0, null);
  }

  final matches = RegExp(r'bytes=(\d*)-(\d*)').firstMatch(rangeHeaderValue);
  if (matches != null) {
    final start = matches.group(1);
    final end = matches.group(2);
    if (start!.isNotEmpty) {
      final startByte = int.parse(start);
      if (end!.isNotEmpty) {
        final endByte = int.parse(end);
        if (endByte >= startByte && endByte < fileSize) {
          return RangeHeader(startByte, endByte);
        }
      } else {
        if (startByte < fileSize) {
          return RangeHeader(startByte, null);
        }
      }
    } else if (end!.isNotEmpty) {
      final endByte = int.parse(end);
      if (fileSize - endByte >= 0) {
        return RangeHeader(fileSize - endByte, fileSize - 1);
      }
    }
  }
  return RangeHeader(0, null);
}

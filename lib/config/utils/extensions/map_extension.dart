extension MapExtension on Map<String, dynamic>? {
  String? getMessage() {
    if (this == null) return null;
    final String _messageKey =
        this!.keys.firstWhere((_key) => _key != "statusCode", orElse: () => "");
    if (_messageKey == "") return null;
    return this![_messageKey] as String;
  }
}

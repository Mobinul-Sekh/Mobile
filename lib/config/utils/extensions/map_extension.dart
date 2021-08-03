extension MapExtension on Map<String, dynamic>? {
  String? getMessage({List<String>? ignoreKeys}) {
    if (this == null) return null;
    final List<String> _ignoreKeys = ['statusCode', ...?ignoreKeys];
    final String _messageKey = this!
        .keys
        .firstWhere((_key) => !_ignoreKeys.contains(_key), orElse: () => "");
    if (_messageKey == "") return null;
    if (this![_messageKey] is List) return this![_messageKey][0] as String;
    return this![_messageKey] as String;
  }
}

extension IntExtension on int {
  String toMinSec() {
    final int _min = this ~/ 60;
    final int _sec = this % 60;
    String _minString, _secString;
    _min < 10 ? _minString = "0$_min" : _minString = "$_min";
    _sec < 10 ? _secString = "0$_sec" : _secString = "$_sec";
    return "$_minString:$_secString";
  }
}

import 'dart:math';

List<String> _units = [
  "cm",
  "pic",
  "kg",
];

String randomQuantity({
  int min = 0,
  int max = 1000,
  String? unit,
}) {
  final Random _rng = Random();
  final int _range = max - min;
  final int _quantity = _rng.nextInt(_range) + min;
  final String _unit = unit ?? _units[_rng.nextInt(_units.length)];
  return "${_quantity.toString()} $_unit";
}

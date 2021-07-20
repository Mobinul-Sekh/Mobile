import 'package:equatable/equatable.dart';

class BlocFormField<T> with EquatableMixin {
  T? value;
  String? error;

  BlocFormField([this.value, this.error]);

  @override
  List<Object?> get props => [value, error];

  BlocFormField<T> copyWith({
    T? value,
    String? error,
  }) {
    return BlocFormField<T>(
      value ?? this.value,
      error ?? this.error,
    );
  }
}

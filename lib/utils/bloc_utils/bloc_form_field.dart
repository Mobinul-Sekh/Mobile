import 'package:bitecope/config/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

class BlocFormField<T> with EquatableMixin {
  T? value;
  LocaleString? error;

  BlocFormField([this.value, this.error]);

  @override
  List<Object?> get props => [value, error];

  BlocFormField<T> copyWith({
    T? value,
    LocaleString? error,
  }) {
    return BlocFormField<T>(
      value ?? this.value,
      error ?? this.error,
    );
  }
}

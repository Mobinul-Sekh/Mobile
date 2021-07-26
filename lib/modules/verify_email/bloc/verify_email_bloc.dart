// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bitecope/modules/verify_email/repositories/verify_email_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

part 'verify_email_state.dart';

class VerifyEmailBloc extends Cubit<VerifyEmailState> {
  VerifyEmailRepository verifyEmailRepository;

  VerifyEmailBloc({required this.verifyEmailRepository})
      : super(VerifyEmailState());
}

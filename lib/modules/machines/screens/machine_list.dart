// Flutter imports:

import 'package:bitecope/modules/machines/bloc/machine_bloc.dart';
import 'package:bitecope/modules/machines/bloc/machine_list_bloc.dart';
import 'package:bitecope/modules/machines/models/machine.dart';
import 'package:bitecope/modules/machines/screens/view_machine.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/core/common/components/action_button.dart';
import 'package:bitecope/core/common/models/user.dart';
import 'package:bitecope/core/common/screens/listing.dart';

import 'add_machine.dart';

class MachinesList extends StatelessWidget {
  const MachinesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MachineListBloc, MachineListState>(
      builder: (context, state) {
        return Listing<Machine>(
          title: AppLocalizations.of(context)!.buyers,
          data: state.machineListStatus == MachineListStatus.loading
              ? null
              : state.machines,
          getText: (machine) => machine.name,
          onTap: (context, machine) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider<MachineBloc>(
                create: (_) => MachineBloc(
                  context.read<MachineListBloc>(),
                ),
                child: ViewMachine(machine: machine),
              ),
            ),
          ),
          actionButton: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.authData!.userType == UserType.owner) {
                return ActionButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider<MachineBloc>(
                          create: (_) => MachineBloc(
                            context.read<MachineListBloc>(),
                          ),
                          child: AddMachine(),
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    size: 40,
                    color: AppColors.lightGrey,
                  ),
                );
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}

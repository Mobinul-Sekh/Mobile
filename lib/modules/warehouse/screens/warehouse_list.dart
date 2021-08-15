// Flutter imports:

import 'package:bitecope/modules/warehouse/bloc/warehouse_bloc.dart';
import 'package:bitecope/modules/warehouse/bloc/warehouse_list_bloc.dart';
import 'package:bitecope/modules/warehouse/models/warehouse.dart';
import 'package:bitecope/modules/warehouse/screens/view_warehouse.dart';
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

import 'add_warehouse.dart';

class WarehouseList extends StatelessWidget {
  const WarehouseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WarehouseListBloc, WarehouseListState>(
      builder: (context, state) {
        return Listing<Warehouse>(
          title: AppLocalizations.of(context)!.warehouses,
          data: state.warehouseListStatus == WarehouseListStatus.loading
              ? null
              : state.warehouse,
          getText: (warehouse) => warehouse.name,
          onTap: (context, warehouse) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider<WarehouseBloc>(
                create: (_) => WarehouseBloc(
                  context.read<WarehouseListBloc>(),
                ),
                child: ViewWarehouse(warehouse: warehouse),
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
                        builder: (_) => BlocProvider<WarehouseBloc>(
                          create: (_) => WarehouseBloc(
                            context.read<WarehouseListBloc>(),
                          ),
                          child: AddWarehouse(),
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

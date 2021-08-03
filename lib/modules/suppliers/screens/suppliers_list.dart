// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/suppliers/bloc/supplier_bloc.dart';
import 'package:bitecope/modules/suppliers/bloc/supplier_list_bloc.dart';
import 'package:bitecope/modules/suppliers/models/supplier.dart';
import 'package:bitecope/modules/suppliers/screens/add_supplier.dart';
import 'package:bitecope/modules/suppliers/screens/view_supplier.dart';
import 'package:bitecope/widgets/action_button.dart';
import 'package:bitecope/widgets/listing.dart';

class SuppliersList extends StatefulWidget {
  const SuppliersList({Key? key}) : super(key: key);

  @override
  _SuppliersListState createState() => _SuppliersListState();
}

class _SuppliersListState extends State<SuppliersList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierListBloc, SupplierListState>(
      builder: (context, state) {
        return Listing<Supplier>(
          title: "Suppliers",
          data: state.supplierListStatus == SupplierListStatus.loading
              ? null
              : state.suppliers,
          getText: (supplier) => supplier.name,
          onTap: (context, supplier) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ViewSupplier(supplier: supplier),
            ),
          ),
          actionButton: ActionButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider<SupplierBloc>(
                    create: (_) => SupplierBloc(
                      context.read<SupplierListBloc>().repository,
                    ),
                    child: AddSupplier(),
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              size: 40,
              color: AppColors.lightGrey,
            ),
          ),
        );
      },
    );
  }
}

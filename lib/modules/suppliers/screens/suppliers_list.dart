// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bitecope/modules/suppliers/bloc/supplier_bloc.dart';
import 'package:bitecope/widgets/listing.dart';

class SuppliersList extends StatefulWidget {
  const SuppliersList({Key? key}) : super(key: key);

  @override
  _SuppliersListState createState() => _SuppliersListState();
}

class _SuppliersListState extends State<SuppliersList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierBloc, SupplierState>(
      builder: (context, state) {
        return Listing(
          title: "Suppliers",
          tiles: state.supplierStatus == SupplierStatus.loading
              ? null
              : state.suppliers,
        );
      },
    );
  }
}

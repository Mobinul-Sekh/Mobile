// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bitecope/modules/suppliers/bloc/supplier_bloc.dart';
import 'package:bitecope/modules/suppliers/models/supplier.dart';
import 'package:bitecope/modules/suppliers/screens/view_supplier.dart';
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
        return Listing<Supplier>(
          title: "Suppliers",
          data: state.supplierStatus == SupplierStatus.loading
              ? null
              : state.suppliers,
          getText: (supplier) => supplier.name,
          onTap: (context, supplier) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ViewSupplier(supplier: supplier),
            ),
          ),
        );
      },
    );
  }
}

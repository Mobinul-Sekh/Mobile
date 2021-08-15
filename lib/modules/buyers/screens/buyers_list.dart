// Flutter imports:
import 'package:bitecope/modules/buyers/bloc/buyer_bloc.dart';
import 'package:bitecope/modules/buyers/bloc/buyer_list_bloc.dart';
import 'package:bitecope/modules/buyers/models/buyer.dart';
import 'package:bitecope/modules/buyers/screens/view_buyers.dart';
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

import 'add_buyers.dart';

class BuyersList extends StatelessWidget {
  const BuyersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyerListBloc, BuyerListState>(
      builder: (context, state) {
        return Listing<Buyer>(
          title: AppLocalizations.of(context)!.buyers,
          data: state.buyerListStatus == BuyerListStatus.loading
              ? null
              : state.buyers,
          getText: (buyer) => buyer.name,
          onTap: (context, buyer) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider<BuyerBloc>(
                create: (_) => BuyerBloc(
                  context.read<BuyerListBloc>(),
                ),
                child: ViewBuyer(buyer: buyer),
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
                        builder: (_) => BlocProvider<BuyerBloc>(
                          create: (_) => BuyerBloc(
                            context.read<BuyerListBloc>(),
                          ),
                          child: AddBuyer(),
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

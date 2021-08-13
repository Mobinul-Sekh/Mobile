// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bitecope/config/routes/route_names.dart';
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/core/authentication/bloc/authentication_bloc.dart';
import 'package:bitecope/core/common/components/gradient_widget.dart';
import 'package:bitecope/core/common/models/user.dart';
import 'package:bitecope/modules/home/screens/home_menu.dart';
import 'package:bitecope/modules/home/screens/page_selector.dart';
import 'package:bitecope/utils/dev_utils/random_quantity.dart';
import 'package:bitecope/utils/dev_utils/random_string.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  List<PageSelectorOption> _shipmentPages(BuildContext context) {
    return [
      PageSelectorOption(
        name: AppLocalizations.of(context)!.purchase,
      ),
      PageSelectorOption(
        name: AppLocalizations.of(context)!.shipment,
      ),
    ];
  }

  List<PageSelectorOption> _factoryPages(BuildContext context) {
    return [
      PageSelectorOption(
        name: AppLocalizations.of(context)!.production,
      ),
      PageSelectorOption(
        name: AppLocalizations.of(context)!.printing,
      ),
    ];
  }

  List<PageSelectorOption> _listingPages(BuildContext context, bool isOwner) {
    final List<PageSelectorOption> listingPages = [
      PageSelectorOption(
        name: AppLocalizations.of(context)!.buyer,
      ),
      PageSelectorOption(
        name: AppLocalizations.of(context)!.goods,
      ),
      PageSelectorOption(
        name: AppLocalizations.of(context)!.items,
      ),
      PageSelectorOption(
        name: AppLocalizations.of(context)!.machine,
      ),
      PageSelectorOption(
        name: AppLocalizations.of(context)!.supplier,
        onTap: () {
          Navigator.of(context).pushReplacementNamed(RouteName.suppliers);
        },
      ),
      PageSelectorOption(
        name: AppLocalizations.of(context)!.warehouse,
      ),
    ];

    if (isOwner) {
      listingPages.add(
        PageSelectorOption(
          name: AppLocalizations.of(context)!.worker,
          onTap: () {
            Navigator.of(context).pushReplacementNamed(RouteName.workers);
          },
        ),
      );
    }

    return listingPages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 30,
        centerTitle: false,
        title: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const HomeMenu(),
              ),
            );
          },
          child: SvgPicture.asset('assets/images/menu.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 75),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.lightBlue1,
                unselectedLabelColor: Theme.of(context).disabledColor,
                labelStyle: Theme.of(context).textTheme.bodyText1,
                labelPadding: const EdgeInsets.all(6.0),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.lightGrey,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowBlack,
                      blurRadius: 12,
                      spreadRadius: 1,
                    )
                  ],
                ),
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.goods),
                  Tab(text: AppLocalizations.of(context)!.items),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _listView(),
                  _listView(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: AppColors.lightGrey,
        padding: const EdgeInsets.symmetric(vertical: 12),
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: null,
              child: GradientWidget(
                gradient: AppGradients.primaryLinear,
                child: SvgPicture.asset('assets/images/home.svg'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PageSelector(
                      icon: SvgPicture.asset('assets/images/shipment.svg'),
                      pages: _shipmentPages(context),
                    ),
                  ),
                );
              },
              child: SvgPicture.asset('assets/images/shipment.svg'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PageSelector(
                      icon: SvgPicture.asset('assets/images/factory.svg'),
                      pages: _factoryPages(context),
                    ),
                  ),
                );
              },
              child: SvgPicture.asset('assets/images/factory.svg'),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                final bool _isOwner =
                    state.authData?.userType == UserType.owner;
                return TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PageSelector(
                          icon: SvgPicture.asset('assets/images/addToList.svg'),
                          pages: _listingPages(context, _isOwner),
                        ),
                      ),
                    );
                  },
                  child: SvgPicture.asset('assets/images/addToList.svg'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 21.0),
          decoration: BoxDecoration(
            color: index % 2 == 0 ? AppColors.grey : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  randomSentence(sentenceLength: 20, addPeriod: false),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: AppColors.black),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: GradientWidget(
                  gradient: AppGradients.primaryLinear,
                  child: Text(
                    randomQuantity(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 30,
      shrinkWrap: true,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

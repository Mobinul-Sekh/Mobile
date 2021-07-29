import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/post_signin_owner/cubit/post_owner_cubit.dart';
import 'package:bitecope/widgets/form_field_decoration.dart';
import 'package:bitecope/widgets/gradient_widget.dart';
import 'package:bitecope/widgets/rounded_wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerDetails extends StatefulWidget {
  const OwnerDetails({Key? key}) : super(key: key);

  @override
  _OwnerDetailsState createState() => _OwnerDetailsState();
}

class _OwnerDetailsState extends State<OwnerDetails> {
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();
  final FocusNode _ownerNameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _phoneNumberNode = FocusNode();
  final FocusNode _companyNameNode = FocusNode();
  final FocusNode _companyAddressNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final state = context.read<PostOwnerCubit>().state;
    _ownerNameController.text = state.ownerName.value ?? "";
    _emailController.text = state.email.value ?? "";
    _phoneNumberController.text = state.phoneNumber.value ?? "";
    _companyNameController.text = state.companyName.value ?? "";
    _companyAddressController.text = state.companyAddress.value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 40.0,
            ),
            child: BlocConsumer<PostOwnerCubit, PostOwnerState>(
              listener: (context, state) {
                if (state.postOwnerStatus == PostOwnerStatus.ownerInserted) {
                  print('owner inserted ');
                }
              },
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: GradientWidget(
                        gradient: AppGradients.primaryGradient,
                        child: Text(
                          AppLocalizations.of(context)!.ownerDetails,
                          style: const TextStyle(
                            fontSize: 21,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.05,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 3,
                      decoration: BoxDecoration(
                        gradient: AppGradients.primaryGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: MediaQuery.of(context).size.width * 0.70,
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    TextField(
                      controller: _ownerNameController,
                      focusNode: _ownerNameNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _emailNode.requestFocus(),
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: formFieldDecoration(
                        context,
                        labelText:
                            "${AppLocalizations.of(context)!.ownerName} ${AppLocalizations.of(context)!.mandatoryStar}",
                        //  errorText: state.username.error != null
                        //      ? state.username.error!(context)
                        //      : null,
                        suffixIcon: Icons.person,
                      ),
                    ),
                    const SizedBox(height: 45),
                    TextField(
                      controller: _emailController,
                      focusNode: _emailNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _phoneNumberNode.requestFocus(),
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: formFieldDecoration(
                        context,
                        labelText:
                            "${AppLocalizations.of(context)!.email} ${AppLocalizations.of(context)!.mandatoryStar}",
                        //  errorText: state.username.error != null
                        //      ? state.username.error!(context)
                        //      : null,
                        suffixIcon: Icons.email_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    TextField(
                      controller: _phoneNumberController,
                      focusNode: _phoneNumberNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _companyNameNode.requestFocus(),
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: formFieldDecoration(
                        context,
                        labelText:
                            "${AppLocalizations.of(context)!.phoneNumber} ${AppLocalizations.of(context)!.mandatoryStar}",
                        //  errorText: state.username.error != null
                        //      ? state.username.error!(context)
                        //      : null,
                        suffixIcon: Icons.local_phone_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    TextField(
                      controller: _companyNameController,
                      focusNode: _companyNameNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          _companyAddressNode.requestFocus(),
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: formFieldDecoration(
                        context,
                        labelText:
                            "${AppLocalizations.of(context)!.companyName} ${AppLocalizations.of(context)!.mandatoryStar}",
                        // errorText: state.companyName.error != null
                        //     ? state.companyName.error!(context)
                        //     : null,
                        suffixIcon: Icons.home_work_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    TextField(
                      maxLines: 2,
                      controller: _companyAddressController,
                      focusNode: _companyAddressNode,
                      textInputAction: TextInputAction.next,
                      //onEditingComplete: () => _passwordNode.requestFocus(),
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: formFieldDecoration(
                        context,
                        labelText: AppLocalizations.of(context)!.companyAddress,
                        // errorText: state.companyAddress.error != null
                        //     ? state.username.error!(context)
                        //     : null,
                        suffixIcon: Icons.location_on_outlined,
                      ),
                    ),
                    const Spacer(),
                    RoundedWideButton(
                      onTap: state.postOwnerStatus ==
                              PostOwnerStatus.ownerInsert
                          ? () {
                              context
                                  .read<PostOwnerCubit>()
                                  .validatePostOwnerPage(
                                    ownerName: _ownerNameController.text,
                                    email: _emailController.text,
                                    companyAddress:
                                        _companyAddressController.text,
                                    phoneNumber: _phoneNumberController.text,
                                    companyName: _companyNameController.text,
                                  );
                            }
                          : null,
                      child: state.postOwnerStatus ==
                              PostOwnerStatus.ownerInsert
                          ? GradientWidget(
                              gradient: AppGradients.primaryGradient,
                              child: Text(
                                AppLocalizations.of(context)!.confirm,
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(),
                            ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/modules/homepage/homepage.dart';
import 'package:bitecope/modules/signin/cubit/siginin_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  bool _hidePassword = false;
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[
      Color(0xff2cceff),
      Color(0xff30aaff),
      Color(0xff30aaff),
      Color(0xff30aaff),
      Color(0xff30abff),
      Color(0xff30adff),
      Color(0xff30b4ff),
      Color(0xff31b8ff),
      Color(0xff32c2ff),
      Color(0xff32c5ff),
      Color(0xff32c9ff),
      Color(0xff32ccff),
      Color(0xff32ceff),
      Color(0xff32ceff),
      Color(0xff33cfff)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();
    final state = context.read<SignInBloc>().state;
    _usernameController.text = state.username.value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.signInStatus == SignInStatus.signedIn) {
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Homepage(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.nearBlack,
          appBar: AppBar(
            backgroundColor: const Color(0xff252525),
            elevation: 0,
            leading: const BackButton(),
            centerTitle: false,
            title: Text(
              AppLocalizations.of(context)!.signIn,
              style: const TextStyle(
                color: Color(0xff32C5FF),
                fontSize: 26,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                letterSpacing: 1.08,
              ),
            ),
          ),
          body: Container(
            color: const Color(0xff252525),
          ),
          bottomSheet: SingleChildScrollView(
            child: BottomSheet(
              backgroundColor: const Color(0xff252525),
              elevation: 0,
              enableDrag: false,
              onClosing: () {},
              builder: (context) => SizedBox(
                height: 500,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20),
                        child: TextFormField(
                          style: const TextStyle(
                            color: Color(0xff9a9a9a),
                            fontSize: 17,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.85,
                          ),
                          controller: _usernameController,
                          focusNode: _usernameNode,
                          onEditingComplete: () => _passwordNode.requestFocus(),
                          decoration: InputDecoration(
                            //helperText: 'dc',
                            labelText: AppLocalizations.of(context)!.username,
                            labelStyle: const TextStyle(
                              color: Color(0xff252525),
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.26,
                            ),
                            errorText: state.username.error != null
                                ? state.username.error!(context)
                                : null,
                            suffixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),

                            //hoverColor: Colors.red,
                            //fillColor: Colors.red,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xff9a9a9a),
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xff32C5FF),
                              ),
                            ),
                            // border: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Color(0xff9a9a9a),
                            //   ),
                            // ),
                            //focusColor: Colors.red,
                            hintText:
                                AppLocalizations.of(context)!.sampleUsername,
                            hintStyle: const TextStyle(
                              color: Color(0xff9a9a9a),
                              fontSize: 17,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.85,
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          // onChanged: controller.usernameChanged,
                          // validator: controller.validationMessageUserName,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20),
                        child: TextFormField(
                          onTap: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                          style: const TextStyle(
                            color: Color(0xff9a9a9a),
                            fontSize: 17,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.85,
                          ),
                          controller: _passwordController,
                          focusNode: _passwordNode,
                          obscureText: _hidePassword,
                          decoration: InputDecoration(
                            //helperText: 'dc',

                            labelText: AppLocalizations.of(context)!.password,
                            labelStyle: const TextStyle(
                              color: Color(0xff252525),
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.26,
                            ),
                            errorText: state.password.error != null
                                ? state.password.error!(context)
                                : null,
                            suffixIcon: !_hidePassword
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                            //hoverColor: Colors.red,
                            //fillColor: Colors.red,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xff9a9a9a),
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xff32C5FF),
                              ),
                            ),
                            // border: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Color(0xff9a9a9a),
                            //   ),
                            // ),
                            //focusColor: Colors.red,
                            hintText:
                                AppLocalizations.of(context)!.samplePassword,
                            hintStyle: const TextStyle(
                              color: Color(0xff9a9a9a),
                              fontSize: 17,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.85,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          //onChanged: controller.passwordChanged,
                          // validator: controller.validationMessagePassword,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)!.forgotPassword,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  foreground: Paint()..shader = linearGradient),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: state.signInStatus == SignInStatus.signingIn
                            ? () {
                                context.read<SignInBloc>().validateSignInPage(
                                      username: _usernameController.text,
                                      password: _passwordController.text,
                                    );
                              }
                            : null,
                        // Navigator.pushNamed(context, NewSignUpTwo.routeName,
                        //     arguments: controller);

                        child: Container(
                          alignment: Alignment.center,
                          width: 257.22,
                          height: 55.20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(55),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3f000000),
                                blurRadius: 20,
                                offset: Offset(-2, 5),
                              ),
                            ],
                            color: const Color(0xff252525),
                          ),
                          padding: const EdgeInsets.only(
                            top: 7,
                            bottom: 8,
                          ),
                          child:
                              state.signInStatus != SignInStatus.inputValidated
                                  ? Text(
                                      AppLocalizations.of(context)!.signIn,
                                      style: const TextStyle(
                                        color: Color(0xff32C5FF),
                                        fontSize: 27,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.81,
                                      ),
                                    )
                                  : const CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _usernameNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }
}

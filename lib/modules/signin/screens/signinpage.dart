import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final Shader linearGradient = LinearGradient(
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
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff252525),
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xff32C5FF),
        ),
        centerTitle: false,
        title: const Text(
          "Sign In",
          style: TextStyle(
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
            height: 360,
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
                      decoration: const InputDecoration(
                        //helperText: 'dc',
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Color(0xff252525),
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.26,
                        ),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        //hoverColor: Colors.red,
                        //fillColor: Colors.red,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff9a9a9a),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
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
                        hintText: 'test',
                        hintStyle: TextStyle(
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
                      decoration: const InputDecoration(
                        //helperText: 'dc',
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color(0xff252525),
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.26,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: Colors.black,
                        ),
                        //hoverColor: Colors.red,
                        //fillColor: Colors.red,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff9a9a9a),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
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
                        hintText: '*************',
                        hintStyle: TextStyle(
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
                          "Forget Password?",
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
                    onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute<void>(
                      //       builder: (context) => NewSignUpTwo(
                      //         controller: controller,
                      //      ),
                      //    ),
                      //  );
                    },
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
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color(0xff32C5FF),
                          fontSize: 27,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.81,
                        ),
                      ),
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
  }
}

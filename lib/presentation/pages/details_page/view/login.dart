import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_rent/presentation/pages/details_page/view/create_account.dart';
import 'package:home_rent/presentation/themes/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../components/user_provider.dart';
import '../../home/view/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  String errorMessage = ''; // Added to display error messages

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xffffffff),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                      width: 300,
                      height: 300,
                      child: SvgPicture.asset('assets/images/1.svg')),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 8),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Ready to explore?',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                        fontSize: 25),
                  ),
                ),
                // Display the error message here if it exists
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'E-mail',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          style: (const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          )),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: kColorPrimary,
                            filled: true,
                            prefixIcon:
                                Image.asset('assets/images/icon_email.png'),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kColorAccent, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: (const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400)),
                        obscureText: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: kColorPrimary,
                          filled: true,
                          prefixIcon:
                              Image.asset('assets/images/icon_lock.png'),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kColorAccent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kColorAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          userProvider.setLoggedIn(true);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScreenHome()));
                        }
                      } catch (e) {
                        setState(() {
                          errorMessage =
                              'Incorrect email or password.'; // Customize based on specific errors
                        });
                      } finally {
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                    child: Text('Login'),
                  ),
                ),
                const Center(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: kColorPrimary),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccount()));
                      },
                      child: const Text('Sign up',
                          style: TextStyle(
                            color: kColorPrimary,
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

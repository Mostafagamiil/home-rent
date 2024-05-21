import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_rent/presentation/pages/details_page/view/login.dart';
import 'package:home_rent/presentation/themes/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../components/user_provider.dart';
import '../../home/view/home.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool showSpinner = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  String emailError = '';
  String passwordError = ''; // To display password validation error

  bool validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  bool isPasswordValid(String password) => password.length >= 6;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
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
                  child: SvgPicture.asset('assets/images/1.svg'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 8),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Fill in the details to create your account.',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      fontSize: 25),
                ),
              ),
              if (emailError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    emailError,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              if (passwordError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    passwordError,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              // Email input field
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.white,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: kColorPrimary,
                        filled: true,
                        prefixIcon: Image.asset('assets/images/icon_email.png'),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kColorAccent, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {
                        email = value;
                        if (!validateEmail(email)) {
                          emailError = 'Please enter a valid email address';
                        } else {
                          emailError = '';
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              // Password input field
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                      obscureText: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: kColorPrimary,
                        filled: true,
                        prefixIcon: Image.asset('assets/images/icon_lock.png'),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kColorAccent, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {
                        password = value;
                        if (!isPasswordValid(password)) {
                          passwordError = 'Password must be at least 6 characters';
                        } else {
                          passwordError = '';
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              // Sign Up button
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
                    if (emailError.isNotEmpty || passwordError.isNotEmpty) {
                      // If there is a format error, do not proceed
                      setState(() {});
                      return;
                    }
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email.trim(), password: password);
                      if (newUser != null) {
                        userProvider.setLoggedIn(true);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login()));
                      }
                    } catch (e) {
                      print(e);
                    } finally {
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Text('Sign in',
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
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:starlight_netchecker_widget/starlight_netchecker_widget.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  bool value = false;
  bool hide = false;
  bool showSpinner = false;
  CollectionReference userId= FirebaseFirestore.instance.collection('userId');

  Future<String> getCurrentUser() async {
    String currentUserUID = FirebaseAuth.instance.currentUser!.uid;
    String username = '';

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('userId')
        .where('uid', isEqualTo: currentUserUID)
        .get();

    if (snapshot.docs.isNotEmpty) {
      username = snapshot.docs[0].get('user_name');
    }
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StarlightNetChecker(
        position: StarlightNetCheckerPosition.top,
        indicatorHeight: 40,
        indicatorColor: Colors.green,
        errorIndicatorColor: Colors.red,
        label: "Connected",
        errorLabel: "No Internet Connection",
        duration: const Duration(seconds: 1),
        child: Scaffold(
          backgroundColor: const Color(0xffffffff),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text('Shikayat',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 28,
              ),
            ),
          ),
          body: ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              color:  Color(0xFF10B600),
            ),
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Login',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 35,
                        child: Divider(
                          color: Color(0xFF10B600),
                          thickness: 6,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: _emailTextController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email Address',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Color(0xFF10B600), width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Color(0xFFED0324), width: 1.5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Color(0xFFED0324), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Color(0xFF10B600), width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: _passwordTextController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Color(0xFF10B600), width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Color(0xFFED0324), width: 1.5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Color(0xFFED0324), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: Color(0xFF10B600), width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  forgotPass(context),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (_emailTextController.text.isEmpty && _passwordTextController.text.isEmpty) {
                          setState(() {
                            showSpinner = false;
                          });
                        } else {
                          setState(() {
                            showSpinner = true;
                          });
                        }

                        try {
                          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          );
                          String username = await getCurrentUser();
                          Navigator.of(context).pushReplacementNamed('/homePage');
                          final snackbar = SnackBar(
                            content: Text("Hey $username, Welcome Back!"),
                            elevation: 20,
                            backgroundColor: const Color(0xFF10B600),
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: '',
                              onPressed: () {},
                            ),
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);

                          setState(() {
                            showSpinner = false;
                          });
                        } catch (error) {
                          print("Error ${error.toString()}");
                          final snackbar = SnackBar(
                            content: const Text("User Credentials are Invalid!"),
                            elevation: 20,
                            backgroundColor: Colors.red,
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: '',
                              onPressed: () {},
                            ),
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);

                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },

                      color: const Color(0xFF000000),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      padding: const EdgeInsets.all(16),
                      textColor: const Color(0xffffffff),
                      height: 50,
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        "LOGIN NOW",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      color: const Color(0xffffffff),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        side: const BorderSide(
                            color: Color(0xffffffff), width: 1),
                      ),
                      padding: const EdgeInsets.all(16),
                      textColor: const Color(0xff000000),
                      height: 40,
                      minWidth: 140,
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.underline,
                            ),
                            children: [
                              TextSpan(
                                text: ' Sign up',
                                style: GoogleFonts.lato(
                                    color: const Color(0xFF10B600), fontSize: 18),
                              ),
                            ]),
                      ),
                    ),
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

Widget forgotPass(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 35,
    alignment: Alignment.bottomRight,
    child: TextButton(
      child: Text(
        "Forgot Password?",
        style: GoogleFonts.lato(color: const Color(0xFF000000)),
        textAlign: TextAlign.right,
      ),
      onPressed: () => Navigator.of(context).pushNamed('/forgot'),
    ),
  );
}
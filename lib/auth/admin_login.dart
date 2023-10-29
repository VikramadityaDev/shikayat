import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    child: Text('Admin Login',
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
                      width: 45,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: MaterialButton(
                    onPressed: () {
                      if (_emailTextController.text.isEmpty &&
                          _passwordTextController.text.isEmpty) {
                        setState(() {
                          showSpinner = false;
                        });
                      } else {
                        setState(() {
                          showSpinner = true;
                        });
                      }
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        Navigator.of(context).pushReplacementNamed('/adminHome');
                        final snackbar = SnackBar(
                          content:
                              const Text("Hello Admin, Welcome to Shikayat!"),
                          elevation: 20,
                          backgroundColor: const Color(0xFF10B600),
                          behavior: SnackBarBehavior.floating,
                          action: SnackBarAction(
                            textColor: Colors.white,
                            label: '',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        setState(() {
                          showSpinner = false;
                        });
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                        final snackbar = SnackBar(
                          content: const Text("Admin Credentials are Invalid!"),
                          elevation: 20,
                          backgroundColor: const Color(0xFFED0324),
                          behavior: SnackBarBehavior.floating,
                          action: SnackBarAction(
                            textColor: Colors.white,
                            label: '',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        setState(() {
                          showSpinner = false;
                        });
                      });
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

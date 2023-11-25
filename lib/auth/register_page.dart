import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:starlight_netchecker_widget/starlight_netchecker_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

CollectionReference userId = FirebaseFirestore.instance.collection('userId');

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  String valueChoose = "BCA";
  bool showSpinner = false;
  late String username;

  // late String department;
  List listItem = [
    'BCA',
    'BBA',
    'BAJMC',
    'B.COM',
    'B.COM(HONS.)',
  ];

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
                      child: Text('Registration',
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
                        width: 48,
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
                      controller: _userNameTextController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Name',
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
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 7),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF10B600), width: 1.5),
                          borderRadius: BorderRadius.circular(6.0),
                          color: const Color(0xffffffff),
                        ),
                        child: DropdownButton(
                          hint: const Text("Select Department"),
                          dropdownColor: const Color(0xffffffff),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                            size: 25,
                          ),
                          iconSize: 22,
                          isExpanded: true,
                          underline: const SizedBox(),
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 18),
                          value: valueChoose,
                          onChanged: (newValue) {
                            setState(() {
                              valueChoose = newValue as String;
                            });
                          },
                          items: listItem.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                    child: MaterialButton(
                      onPressed: () {
                        if (_userNameTextController.text.isEmpty) {
                          final snackbar = SnackBar(
                            content: const Text("Username can not be empty."),
                            elevation: 20,
                            backgroundColor: const Color(0xFFED0324),
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: '',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbar);
                        }
                        if (_passwordTextController.text.isEmpty) {
                          final snackbar = SnackBar(
                            content:
                                const Text("Please enter a valid Password."),
                            elevation: 20,
                            backgroundColor: const Color(0xFFED0324),
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: '',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbar);
                        }
                        if (_emailTextController.text.isEmpty) {
                          final snackbar = SnackBar(
                            content: const Text(
                                "Please enter a valid Email address."),
                            elevation: 20,
                            backgroundColor: const Color(0xFFED0324),
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: '',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbar);
                        }
                        if (valueChoose.isEmpty) {
                          final snackbar = SnackBar(
                            content:
                                const Text("Please Select your Department"),
                            elevation: 20,
                            backgroundColor: const Color(0xFFED0324),
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: '',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbar);
                        }
                        if (_userNameTextController.text.isEmpty == false &&
                            _emailTextController.text.isEmpty == false &&
                            _passwordTextController.text.isEmpty == false &&
                            valueChoose.isEmpty == false) {
                          setState(() {
                            showSpinner = true;
                          });
                        } else {
                          setState(() {
                            showSpinner = false;
                          });
                        }
                        if (_userNameTextController.text.isEmpty == false &&
                            _emailTextController.text.isEmpty == false &&
                            _passwordTextController.text.isEmpty == false &&
                            valueChoose.isEmpty == false) {
                          setState(() {
                            showSpinner = true;
                          });

                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text)
                              .then((value) {
                            username = _userNameTextController.text;
                            userId.add({
                              'uid': FirebaseAuth.instance.currentUser!.uid,
                              'user_name': username,
                              'user_department': valueChoose
                            }).then((value) => print("user added"));
                            print("Created new account Successfully");
                            Navigator.of(context).pushReplacementNamed('/homePage');
                            setState(() {
                              showSpinner = false;
                            });
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                          });
                          username = _userNameTextController.text;
                          userId.add({
                            'uid': FirebaseAuth.instance.currentUser!.uid,
                            'user_name': username,
                            'user_department': valueChoose
                          }).then((value) => print("user added"));
                          print(username);
                        }
                      },
                      color: const Color(0xFF10B600),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      padding: const EdgeInsets.all(16),
                      textColor: const Color(0xffffffff),
                      height: 50,
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        "REGISTER NOW",
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
                      onPressed: () => Navigator.of(context).pushNamed('/login'),
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
                            text: 'Already have an account?',
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.underline,
                            ),
                            children: [
                              TextSpan(
                                text: ' Sign in',
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

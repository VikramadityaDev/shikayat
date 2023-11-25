import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starlight_netchecker_widget/starlight_netchecker_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = " ";

  TextEditingController emailController = TextEditingController();

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
          backgroundColor: const Color(0xFF10B600),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color: Color(0x00ffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Container(
                  height: 100,
                  width: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZc_T9ZMJKST-5bqf21Uhc22dw1XVfdIAAg&usqp=CAU",
                      fit: BoxFit.fill),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    border:
                        Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Forgot Password",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: const Color(0xff000000),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text(
                            "Please enter your email for the verification process. We will send you a link to reset your password to your registered email.",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: const Color(0xff615f5f),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text(
                            "Email Address",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: TextField(
                            controller: emailController,
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: const Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff595757), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff595757), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff595757), width: 1),
                              ),
                              hintText: "Enter Registered Email Address",
                              hintStyle: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: const Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: const Color(0xffffffff),
                              isDense: false,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              suffixIcon: const Icon(Icons.mail,
                                  color: Color(0xff212435), size: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    onPressed: () {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: emailController.text)
                          .then((value) => Navigator.of(context).pop());
                      if(emailController.text.isEmpty){
                        final snackbar = SnackBar(
                          content:
                          const Text("Please enter a valid Email address."),
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
                      } if(emailController.text.isNotEmpty){
                        final snackbar = SnackBar(
                          content:
                          const Text("Reset link sent successfully!"),
                          elevation: 20,
                          backgroundColor: const Color(0xFF10B600),
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
                    },
                    color: const Color(0xFF10B600),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding: const EdgeInsets.all(16),
                    textColor: const Color(0xffffffff),
                    height: 45,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      "CONTINUE",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shikayat/utils/assets.dart';
import 'package:starlight_netchecker_widget/starlight_netchecker_widget.dart';

class Exam extends StatelessWidget {
  const Exam({super.key});

  static const assetPath = MyAssets.examRelated;
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
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  child: Hero(
                      tag: 'location-img-$assetPath',
                      child: Lottie.asset(assetPath, height: 360),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Complaints related to exams may include issues regarding the exam timetable, admit card, and center allocation.',
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/examRelated');
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
                      "View All Exam Complaints",
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shikayat/utils/assets.dart';
import 'package:starlight_netchecker_widget/starlight_netchecker_widget.dart';

class Canteen extends StatelessWidget {
  const Canteen({super.key});

  static const assetPath = MyAssets.canteenRelated;

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
                const Text(
                  "A canteen-related complaint may encompass issues such as food quality, a limited menu, or a frustrating overall experience.",
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                      final snackbar = SnackBar(
                        content: const Text("Coming soon.."),
                        elevation: 20,
                        backgroundColor: Colors.grey.shade600,
                        action: SnackBarAction(
                          textColor: Colors.white,
                          label: '',
                          onPressed: () {},
                        ),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
                      "View All Canteen Complaints",
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

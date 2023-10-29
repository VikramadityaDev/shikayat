import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shikayat/utils/assets.dart';

class Facility extends StatelessWidget {
  const Facility({super.key});

  static const assetPath = MyAssets.facilityRelated;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              Text("Facility-related complaints include students' grievances concerning the basic amenities provided on their college campus.",
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
                    Navigator.of(context).pushNamed('/facilityRelated');
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
                    "View All Facility Complaints",
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
    );
  }
}

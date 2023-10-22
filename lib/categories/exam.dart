import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shikayat/utils/assets.dart';

class Exam extends StatelessWidget {
  const Exam({super.key});

  static const assetPath = MyAssets.examRelated;
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
              const Text('Complaints related to exams may include issues regarding the exam timetable, admit card, and center allocation.',
                maxLines: 4,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                onPressed: () {},
                color: const Color(0xFF000000),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                padding: const EdgeInsets.all(16),
                textColor: const Color(0xffffffff),
                height: 50,
                minWidth: MediaQuery.of(context).size.width,
                child: const Text(
                  "View All Exam Complaints",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
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

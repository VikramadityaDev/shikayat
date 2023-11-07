import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shikayat/admin_categories/admin_home.dart';
import 'package:shikayat/admin_categories/admin_shikayat_categories/admin_document_shikayat.dart';
import 'package:shikayat/admin_categories/admin_shikayat_categories/admin_exam_shikayat.dart';
import 'package:shikayat/admin_categories/admin_shikayat_categories/admin_facility_shikayat.dart';
import 'package:shikayat/admin_categories/admin_shikayat_categories/admin_library_shikayat.dart';
import 'package:shikayat/admin_categories/admin_shikayat_categories/admin_lost&found_shikayat.dart';
import 'package:shikayat/admin_categories/admin_view_shikayat.dart';
import 'package:shikayat/admin_categories/approved_shikayat.dart';
import 'package:shikayat/admin_categories/pending_shikayat.dart';
import 'package:shikayat/admin_categories/resolved_shikayat.dart';
import 'package:shikayat/app.dart';
import 'package:shikayat/auth/admin_login.dart';
import 'package:shikayat/auth/forgot_page.dart';
import 'package:shikayat/auth/login_page.dart';
import 'package:shikayat/auth/register_page.dart';
import 'package:shikayat/categories/canteen.dart';
import 'package:shikayat/categories/document.dart';
import 'package:shikayat/categories/exam.dart';
import 'package:shikayat/categories/facility.dart';
import 'package:shikayat/categories/library.dart';
import 'package:shikayat/categories/lost&found.dart';
import 'package:shikayat/categories/shikayat_categories/document_shikayat.dart';
import 'package:shikayat/categories/shikayat_categories/exam_shikayat.dart';
import 'package:shikayat/categories/shikayat_categories/facility_shikayat.dart';
import 'package:shikayat/categories/shikayat_categories/library_shikayat.dart';
import 'package:shikayat/categories/shikayat_categories/lost&found_shikayat.dart';
import 'package:shikayat/screens/student/add_shikayat.dart';
import 'package:shikayat/screens/student/home_screen.dart';
import 'package:shikayat/screens/student/my_user_shikayat_screen.dart';
import 'package:shikayat/screens/student/view_user_shikayat.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF10B600),
          selectionColor: Color(0xFF10B600),
          selectionHandleColor: Color(0xFF10B600),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot': (context) => const ForgotPassword(),
        '/adminLogin': (context) => const AdminLogin(),
        '/adminHome': (context) => const AdminHome(),
        '/homePage': (context) => const HomeScreen(),
        '/exam': (context) => const Exam(),
        '/facility': (context) => const Facility(),
        '/document': (context) => const Document(),
        '/library': (context) => const Library(),
        '/canteen': (context) => const Canteen(),
        '/lost': (context) => const LostAndFound(),
        '/addShikayat': (context) => const AddShikayat(),
        '/viewShikayat': (context) => const ViewUserShikayat(),
        '/myShikayat': (context) => const MyUserShikayat(),
        '/examRelated': (context) => const ExamShikayat(),
        '/facilityRelated': (context) => const FacilityShikayat(),
        '/libraryRelated': (context) => const LibraryShikayat(),
        '/documentRelated': (context) => const DocumentShikayat(),
        '/lostAndFoundRelated': (context) => const LostAndFoundShikayat(),
        '/adminViewShikayat': (context) => const AdminViewShikayat(),
        '/pendingShikayat': (context) => const PendingShikayat(),
        '/approvedShikayat': (context) => const ApprovedShikayat(),
        '/resolvedShikayat': (context) => const ResolvedShikayat(),
        '/adminFacilityShikayat': (context) => const FacilityShikayatAdmin(),
        '/adminExamShikayat': (context) => const ExamShikayatAdmin(),
        '/adminDocumentShikayat': (context) => const DocumentShikayatAdmin(),
        '/adminLibraryShikayat': (context) => const LibraryShikayatAdmin(),
        '/adminLostAndFoundShikayat': (context) => const LostAndFoundShikayatAdmin(),
      },
    );
  }
}

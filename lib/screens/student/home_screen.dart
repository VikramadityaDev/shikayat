import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shikayat/categories/canteen.dart';
import 'package:shikayat/categories/document.dart';
import 'package:shikayat/categories/exam.dart';
import 'package:shikayat/categories/facility.dart';
import 'package:shikayat/categories/library.dart';
import 'package:shikayat/categories/lost&found.dart';
import 'package:shikayat/utils/assets.dart';

class HomeScreen extends StatefulWidget with WidgetsBindingObserver {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController slideController;
  late Animation<double> slideAnimation;
  List<Map<String, dynamic>> columnData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: slideController,
        curve: Curves.easeOut,
      ),
    );
    slideController.forward();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    slideController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _buildColumnData(BuildContext context) {
    return [
      {
        'asset': MyAssets.examRelated,
        'name': 'Exam Related',
        'onPress': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Exam()),
          );
        },
      },
      {
        'asset': MyAssets.facilityRelated,
        'name': 'Facility Related',
        'onPress': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Facility()),
          );
        },
      },
      {
        'asset': MyAssets.documentRelated,
        'name': 'Document Related',
        'onPress': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Document()),
          );
        },
      },
      {
        'asset': MyAssets.libraryRelated,
        'name': 'Library Related',
        'onPress': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Library()),
          );
        },
      },
      {
        'asset': MyAssets.canteenRelated,
        'name': 'Canteen Related',
        'onPress': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Canteen()),
          );
        },
      },
      {
        'asset': MyAssets.lostAndFound,
        'name': 'Lost & Found Related',
        'onPress': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LostAndFound()),
          );
        },
      },
    ];
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      slideController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    columnData = _buildColumnData(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  buildHeader(),
                  const SizedBox(
                    height: 20,
                  ),
                  buildAddViewComplaintRow(),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 10,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.25),
                      end: const Offset(0, 0),
                    ).animate(
                      CurvedAnimation(
                        parent: slideController,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18),
                      child: Text(
                        "Complaint Categories",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.67,
                    ),
                    itemCount: columnData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.25),
                            end: const Offset(0, 0),
                          ).animate(
                            CurvedAnimation(
                              parent: slideController,
                              curve: Interval(index / columnData.length, 1.0,
                                  curve: Curves.easeOut),
                            ),
                          ),
                          child: buildColumn(
                            context,
                            columnData[index]['asset'],
                            columnData[index]['name'],
                            columnData[index]['onPress'],
                          ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Image.asset('assets/decoration.png'),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          left: 20,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF50CD6D).withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(1, 1),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/shikayat_logo.png',
                    height: 40,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shikayat',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "An Complaint Management Application.",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildAddViewComplaintRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.25),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: slideController,
              curve: Curves.easeOut,
            ),
          ),
          child: SizedBox(
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF50CD6D).withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Image(
                        color: Colors.green,
                        image: AssetImage('assets/add_message.png')),
                  ),
                ),
                const Text(
                  'Add Complaint',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.25),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: slideController,
              curve: Curves.easeOut,
            ),
          ),
          child: SizedBox(
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF50CD6D).withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Image(
                        color: Colors.green,
                        image: AssetImage('assets/view.png'),),
                  ),
                ),
                const Text(
                  'View Complaint',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.25),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: slideController,
              curve: Curves.easeOut,
            ),
          ),
          child: SizedBox(
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF50CD6D).withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Image(
                        color: Colors.green,
                        image: AssetImage('assets/account.png')),
                  ),
                ),
                const Text(
                  'My Complaint',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildColumn(BuildContext context, String assetPath, String name,
      VoidCallback? onPress) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPress,
          child: Container(
            alignment: Alignment.center,
            height: 200,
            width: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: const Color(0xFF50CD6D).withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF50CD6D).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Hero(
              tag: 'location-img-$assetPath',
              child: Lottie.asset(assetPath),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

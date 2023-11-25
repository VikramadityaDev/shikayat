import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shikayat/utils/assets.dart';
import 'package:starlight_netchecker_widget/starlight_netchecker_widget.dart';

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
          Navigator.of(context).pushNamed('/exam');
        },
      },
      {
        'asset': MyAssets.facilityRelated,
        'name': 'Facility Related',
        'onPress': () {
          Navigator.of(context).pushNamed('/facility');
        },
      },
      {
        'asset': MyAssets.documentRelated,
        'name': 'Document Related',
        'onPress': () {
          Navigator.of(context).pushNamed('/document');
        },
      },
      {
        'asset': MyAssets.libraryRelated,
        'name': 'Library Related',
        'onPress': () {
          Navigator.of(context).pushNamed('/library');
        },
      },
      {
        'asset': MyAssets.canteenRelated,
        'name': 'Canteen Related',
        'onPress': () {
          Navigator.of(context).pushNamed('/canteen');
        },
      },
      {
        'asset': MyAssets.lostAndFound,
        'name': 'Lost & Found Related',
        'onPress': () {
          Navigator.of(context).pushNamed('/lost');
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
      child: StarlightNetChecker(
        position: StarlightNetCheckerPosition.top,
        indicatorHeight: 40,
        indicatorColor: Colors.green,
        errorIndicatorColor: Colors.red,
        label: "Connected",
        errorLabel: "No Internet Connection",
        duration: const Duration(seconds: 1),
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
                    height: 38,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
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
                        Text(
                          "Student Panel",
                          style: GoogleFonts.lato(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        );
                      },
                      icon: const Icon(Icons.logout)
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
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/addShikayat'),
                  child: Container(
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
                    child:  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/svgs/add_message.svg',
                          colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn)
                      ),
                    ),
                  ),
                ),
                Text(
                  'Add Complaint',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500),
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
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/viewShikayat'),
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/svgs/view.svg',
                          colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn)
                      ),
                    ),
                  ),
                  Text(
                    'View Complaint',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500),
                  )
                ],
              ),
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
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/myShikayat'),
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/svgs/account.svg',
                          colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn)
                      ),
                    ),
                  ),
                  Text(
                    'My Complaint',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500),
                  )
                ],
              ),
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
        const SizedBox(height: 5),
        Text(
          name,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shikayat/widgets/custom_dropdown.dart';
import 'package:starlight_netchecker_widget/starlight_netchecker_widget.dart';


class AddShikayat extends StatefulWidget {
  const AddShikayat({Key? key}) : super(key: key);

  @override
  _AddShikayatState createState() => _AddShikayatState();
}

class _AddShikayatState extends State<AddShikayat> {
  String? dropDownValue1;
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;
  String? dropDownValue2;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  CollectionReference Complaint_data =
      FirebaseFirestore.instance.collection('Complaint_data1');
  late List<Map<String, dynamic>> dataList = [];


  Future<String> getUsernameForCurrentUser() async {
    String currentUserUID = FirebaseAuth.instance.currentUser!.uid;
    String username = '';

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('userId')
        .where('uid', isEqualTo: currentUserUID)
        .get();

    if (snapshot.docs.isNotEmpty) {
      username = snapshot.docs[0].get('user_name');
    }
    return username;
  }

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();

    super.initState();
    getUsernameForCurrentUser().then((username) {
      textController3?.text = username;
    });

    getDataFromFirestore().then((value) {
      setState(() {
        dataList = value;
      });
    });
  }

  Future<List<Map<String, dynamic>>> getDataFromFirestore() async {
    List<Map<String, dynamic>> dataList = [];
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('userId')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      dataList.add(data);
    });
    
    return dataList;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    super.dispose();
  }

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
          key: scaffoldKey,
          backgroundColor: const Color(0xffffffff),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
              child: Container(
                height: 120,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color(0xFF10B600),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 0,
                      child: Container(
                        height: 40,
                        width: 220,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 13,
                      left: 35,
                      child: Text(
                        "Add Complaint",
                        style: GoogleFonts.lato(
                            fontSize: 25,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1, 0.05),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                        child: Text(
                          'Title',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-0.1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                        child: TextFormField(
                          controller: textController1,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter complaint Tittle',
                            hintStyle: GoogleFonts.lato(),
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
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0.05),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                        child: Text(
                          'Description',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-0.1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                        child: TextFormField(
                          controller: textController2,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter complaint Description',
                            hintStyle: GoogleFonts.lato(),
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
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0.05),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                        child: Text(
                          'Complaint Type',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 7),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF10B600), width: 1.5),
                          borderRadius: BorderRadius.circular(6.0),
                          color: const Color(0xffffffff),
                        ),
                        child: CustomDropDown(
                          options: const [
                            'Exam Related',
                            'Facility Related',
                            'Document Related',
                            'Library Related',
                            'Canteen Related',
                            'Lost and Found',
                          ],
                          onChanged: (val) =>
                              setState(() => dropDownValue1 = val),
                          width: 355,
                          height: 50,
                          textStyle: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                          ),
                          hintText: 'Select Complaint Type',
                          fillColor: Colors.white,
                          elevation: 2,
                          borderColor: Colors.transparent,
                          borderWidth: 0,
                          borderRadius: 0,
                          margin:
                              const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0.05),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                        child: Text(
                          'Username',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-0.1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                        child: TextFormField(
                          controller: textController3,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: "Enter Name",
                            hintStyle: GoogleFonts.lato(),
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
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0.05),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                        child: Text(
                          'User Department',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 7),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF10B600), width: 1.5),
                          borderRadius: BorderRadius.circular(6.0),
                          color: const Color(0xffffffff),
                        ),
                        child: CustomDropDown(
                          options: const [
                            'BCA',
                            'BBA',
                            'BAJMC',
                            'B.COM',
                            'B.COM(HONS.)',
                          ],
                          onChanged: (val) =>
                              setState(() => dropDownValue2 = val),
                          width: 350,
                          height: 50,
                          textStyle: GoogleFonts.lato(),
                          hintText: 'Select User Department',
                          fillColor: Colors.white,
                          elevation: 2,
                          borderColor: Colors.transparent,
                          borderWidth: 0,
                          borderRadius: 0,
                          margin:
                              const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                      child: MaterialButton(
                        onPressed: () {
                          if (textController1!.text.isEmpty) {
                            final snackbar = SnackBar(
                              content:
                                  const Text("Complaint title can not be empty."),
                              elevation: 20,
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: '',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                          if (textController2!.text.isEmpty) {
                            final snackbar = SnackBar(
                              content: const Text(
                                  "Complaint description can not be empty."),
                              elevation: 20,
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: '',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }

                          if (dropDownValue1 == null) {
                            final snackbar = SnackBar(
                              content:
                                  const Text("Please select the complaint type."),
                              elevation: 20,
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: '',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                          if (textController3!.text.isEmpty) {
                            final snackbar = SnackBar(
                              content: const Text("Username can not be empty."),
                              elevation: 20,
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: '',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                          if (dropDownValue2 == null) {
                            final snackbar = SnackBar(
                              content: const Text(
                                  "Please select the user department."),
                              elevation: 20,
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: '',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                          String id =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          if (textController1?.text.isEmpty == false &&
                              textController2?.text.isEmpty == false &&
                              textController3?.text.isEmpty == false &&
                              dropDownValue1!.isEmpty == false &&
                              dropDownValue2!.isEmpty == false) {
                            CollectionReference colref =
                                FirebaseFirestore.instance.collection('userId');
                            Complaint_data.doc(id).set({
                              'Complaint_Tittle': textController1?.text,
                              'Complaint_type': dropDownValue1,
                              'description': textController2?.text,
                              'roll_no': (textController4?.text),
                              'user_name': dataList[0]['user_name'],
                              'user department': dropDownValue2,
                              'Date': DateTime.now(),
                              'status': "Pending",
                              'id': id,
                              'uid': FirebaseAuth.instance.currentUser!.uid
                            });
                          }
                          if (textController1!.text.isNotEmpty &&
                              textController2!.text.isNotEmpty &&
                              textController3!.text.isNotEmpty &&
                              dropDownValue1 != null &&
                              dropDownValue2 != null){
                            final snackbar = SnackBar(
                              content: const Text("Complaint Added Successfully!"),
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
                            Navigator.of(context).pushNamed('/homePage');
                          } else {
                            final snackbar = SnackBar(
                              content: const Text("Something went wrong!"),
                              elevation: 20,
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: '',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
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
                          "SUBMIT",
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
        ),
      ),
    );
  }
}

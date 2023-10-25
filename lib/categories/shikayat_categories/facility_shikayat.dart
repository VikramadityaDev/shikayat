import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FacilityShikayat extends StatefulWidget {
  const FacilityShikayat({Key? key}) : super(key: key);

  @override
  FacilityShikayatState createState() => FacilityShikayatState();
}

class FacilityShikayatState extends State<FacilityShikayat> {
  late String complaintType;
  late List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    getDataFromFirestore().then((value) {
      setState(() {
        dataList = value;
      });
    });
  }

  Future<List<Map<String, dynamic>>> getDataFromFirestore() async {
    List<Map<String, dynamic>> dataList = [];

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Complaint_data1')
        .where('Complaint_type', isEqualTo: 'Facility Related')
        .get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      dataList.add(data);
    });

    if (dataList.isNotEmpty && dataList.length > 1) {
      print(dataList[1]);
    }
    return dataList;
  }

  List<String> sel = [];

  @override
  @override
  Widget build(BuildContext context) {
    String formatTimestamp(Timestamp timestamp) {
      var format = DateFormat('yyyy-MM-dd');
      return format.format(timestamp.toDate()).toString();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
              child: Container(
                height: 120,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50)),
                  color: Color(0xFF10B600),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 0,
                      child: Container(
                        height: 40,
                        width: 280,
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
                      top: 15,
                      left: 20,
                      child: Text(
                        " Facility Related Complaints",
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: (Card(
                        elevation: 2,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          width: 300,
                          height: 230,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dataList[index]['Complaint_type'] +
                                              " Complaint ",
                                          style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            "${"${"Posted by: " + dataList[index]['user_name']} (" + dataList[index]['user department']}) on ${formatTimestamp(dataList[index]['Date'])}",
                                            style: GoogleFonts.lato(
                                                color: Colors.blueGrey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: SizedBox(
                                            width: 220,
                                            child: Text(
                                              dataList[index]
                                                  ['Complaint_Tittle'],
                                              softWrap: true,
                                              style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: null,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: SizedBox(
                                            width: 220,
                                            child: Text(
                                              "Complaint Description: " +
                                                  dataList[index]
                                                      ['description'],
                                              softWrap: true,
                                              style: GoogleFonts.lato(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: null,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 20),
                                    child: MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Complaint status: " +
                                                    dataList[index]['status'],
                                                style: GoogleFonts.lato(
                                                    color: ((dataList[index]
                                                                ['status']) ==
                                                            "Pending")
                                                        ? Colors.red
                                                        : (dataList[index][
                                                                    'status']) ==
                                                                "Complaint Approved"
                                                            ? Colors.yellow
                                                            : Colors.green),
                                              ),
                                              content: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    " As on ${DateTime.now().toString().substring(0, 11)}",
                                                    style: GoogleFonts.lato(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      color: const Color(0xFF000000),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      textColor: const Color(0xffffffff),
                                      height: 40,
                                      minWidth: 100,
                                      child: Text(
                                        "View Status",
                                        style: GoogleFonts.lato(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

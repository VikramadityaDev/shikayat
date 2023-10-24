import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiDetailCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String detail1;
  final String detail2;
  final String detail3;

  const MultiDetailCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.detail1,
    required this.detail2,
    required this.detail3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 300,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
                maxLines: null,
              ),
              const SizedBox(height: 24),
              Text(
                'Posted on: $detail1',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Posted by: $detail2',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Complaint Status: $detail3',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewDetails extends StatefulWidget {
  const ViewDetails(
    int index, {
    Key? key,
  }) : super(key: key);

  @override
  ViewDetailsState createState() => ViewDetailsState();
}

class ViewDetailsState extends State<ViewDetails> {
  CollectionReference complaintData =
      FirebaseFirestore.instance.collection('Complaint_data1');
  late Stream<QuerySnapshot> complaintStream;

  @override
  void initState() {
    super.initState();
    complaintStream = complaintData.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  top: 50,
                  left: 0,
                  child: Container(
                    height: 40,
                    width: 250,
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
                  top: 55,
                  left: 35,
                  child: Text(
                    "Complaint Details",
                    style: GoogleFonts.lato(
                        fontSize: 25,
                        color: const Color(0xFF10B600),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: complaintStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.active) {
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                  querySnapshot.docs;
              QueryDocumentSnapshot document = listQueryDocumentSnapshot[7];
              return MultiDetailCard(
                title: document['Complaint_Tittle'],
                subtitle: document['status'],
                detail1: 'det1',
                detail2: 'det2',
                detail3: 'det3',
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
      ),
    );
  }
}

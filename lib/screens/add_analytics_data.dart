import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAnalyticsWidget extends StatefulWidget {
  const AddAnalyticsWidget({Key? key}) : super(key: key);

  @override
  _AddAnalyticsWidgetState createState() => _AddAnalyticsWidgetState();
}

class _AddAnalyticsWidgetState extends State<AddAnalyticsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController totalSalesController;
  late TextEditingController totalCustomers;
  late TextEditingController totalProducts;
  late TextEditingController totalRevenue;
  late TextEditingController allBarValues;
  late TextEditingController verifyEmail;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;
  late String email;

  @override
  void initState() {
    super.initState();
    totalSalesController = TextEditingController();
    totalCustomers = TextEditingController();
    totalProducts = TextEditingController();
    totalRevenue = TextEditingController();
    allBarValues = TextEditingController();
    verifyEmail = TextEditingController();
    getCurrentUser();
  }

  CollectionReference analyticsData =
      FirebaseFirestore.instance.collection('analyticsData');

  Future<void> addAnalyticsData() async {
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection('analyticsData')
        .where('verifyEmail', isEqualTo: email)
        .get();
    final List<DocumentSnapshot> documents = querySnap.docs;

    if (documents.isNotEmpty) {
      QueryDocumentSnapshot doc = querySnap.docs[
          0]; // Assumption: the query returns only one document, THE doc you are looking for.
      DocumentReference docRef = doc.reference;
      await docRef.update(
        {
          "sales": totalSalesController.text,
          "customers": totalCustomers.text,
          "allBarvalues": allBarValues.text,
          "revenue": totalRevenue.text,
          "products": totalProducts.text,
          "verifyEmail": verifyEmail.text,
        },
      );
      return;
    }

    // Call the user's CollectionReference to add a new user
    return analyticsData
        .add(
          {
            "sales": totalSalesController.text,
            "customers": totalCustomers.text,
            "allBarvalues": allBarValues.text,
            "revenue": totalRevenue.text,
            "products": totalProducts.text,
            "verifyEmail": verifyEmail.text,
          },
        )
        .then((value) => print("Data Added!!!!!!!!!"))
        .catchError((error) => print("Failed to add Product Data: $error"));
  }

  getCurrentUser() async {
    final User? user = _auth.currentUser;
    uid = user!.uid;
    email = user.email!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: const Color(0xFFF1F4F8),
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFF0F1113),
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                        child: Text(
                          'Back',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF0F1113),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text(
                    'Add Or Modify Analytics data',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Color(0xFF0F1113),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            actions: [],
            elevation: 0,
          ),
        ),
        backgroundColor: const Color(0xFFF1F4F8),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 6, 20, 6),
              child: TextFormField(
                controller: totalSalesController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Total Sales',
                  labelStyle: _style(14),
                  hintText: 'Enter Total Sales',
                  hintStyle: _style(14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                ),
                style: _style(14),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 6, 20, 6),
              child: TextFormField(
                controller: totalCustomers,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Total Customers',
                  labelStyle: _style(14),
                  hintText: 'Enter Total Number of Customers',
                  hintStyle: _style(14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                ),
                style: _style(14),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 6, 20, 6),
              child: TextFormField(
                controller: totalProducts,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Total Products',
                  labelStyle: _style(14),
                  hintText: 'Enter Total Products',
                  hintStyle: _style(14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                ),
                style: _style(14),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 3, 20, 3),
              child: TextFormField(
                controller: totalRevenue,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Revenue',
                  labelStyle: _style(14),
                  hintText: 'Amount of Revenue',
                  hintStyle: _style(14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                ),
                style: _style(14),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 6, 20, 6),
              child: TextFormField(
                controller: allBarValues,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Monthely Performance',
                  labelStyle: _style(14),
                  hintText: "Enter 5 Monthes vlues ','(comma) Separated ",
                  hintStyle: _style(14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                ),
                style: _style(14),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 6, 20, 6),
              child: TextFormField(
                controller: verifyEmail,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Verify Email',
                  labelStyle: _style(14),
                  hintText: 'Enter Email for Verification',
                  hintStyle: _style(14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24, 6, 24, 6),
                ),
                style: _style(14),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 18),
              child: GestureDetector(
                onTap: () {
                  addAnalyticsData();
                  Navigator.pop(context);
                },
                child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        'Save Changes',
                        style: GoogleFonts.openSans(
                          color: const Color(0xFFDEDEDE),
                          fontSize: 16,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _style(double fontsize) {
    return TextStyle(
      fontFamily: 'Outfit',
      color: const Color(0xFF0F1113),
      fontSize: fontsize,
      fontWeight: FontWeight.normal,
    );
  }
}

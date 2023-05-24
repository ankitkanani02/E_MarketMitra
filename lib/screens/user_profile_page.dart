import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emmitra/screens/edit_profile.dart';
import 'package:emmitra/user/user_data.dart';
import 'package:emmitra/utils/display_image_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfilePageWidget extends StatefulWidget {
  const UserProfilePageWidget({Key? key}) : super(key: key);

  @override
  State<UserProfilePageWidget> createState() => _UserProfilePageWidgetState();
}

class _UserProfilePageWidgetState extends State<UserProfilePageWidget> {
  final user = UserData.myUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;
  late String email;

  late final Stream<QuerySnapshot> data;
  String umobileno = "NA";
  String uname = "NA";
  String ushopedetails = "NA";
  String uemail = "NA";
  String ujobtitle = "NA";
  String ushopname = "NA";

  // String umobileno = "A";
  // String uname = "A";
  // String ushopedetails = "A";
  // String uemail = "A";
  // String ujobtitle = "A";
  // String ushopname = "A";

  // Future getuser() async {
  //    FirebaseFirestore.instance
  //       .collection("users")
  //       .where("email", isEqualTo: email)
  //       .get()
  //       .then((value) {

  //     return value;
  //   });

  // }

  @override
  initState() {
    // getuser();
    super.initState();
    getCurrentUser();
    setState(() {
      getUserData();
    });
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getUD() async {
  //   var firestore = FirebaseFirestore.instance;

  //   // var docRef = firestore.collection('companies').document(widget.docID);

  //   var querySnap = await firestore
  //       .collection('users')
  //       .where('email', isEqualTo: email)
  //       .get();

  //   return querySnap;
  //   // return querySnap.docs.map((snap) {
  //   //   snap.data();
  //   //   print(snap.data());
  //   // }).toList();
  // }

  getUserData() {
    FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then((value) {
      final userdata = value.docs.first.data();
      final udata = Map.from(userdata);
      umobileno = udata['mobileno'] ?? "NA";
      uname = udata['uname'] ?? "NA";
      ushopedetails = udata['shopedetails'] ?? "NA";
      uemail = udata['email'] ?? "NA";
      ujobtitle = udata['jobtitle'] ?? "NA";
      ushopname = udata['shopename'] ?? "NA";
    });
  }

  getCurrentUser() async {
    final User? user = _auth.currentUser;
    uid = user!.uid;
    email = user.email!;
  }

  _style(double fontsize) {
    return TextStyle(
      fontFamily: 'Outfit',
      color: const Color(0xFF0F1113),
      fontSize: fontsize,
      fontWeight: FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 4));
    getUserData();
    return FutureBuilder(
        // future: getUserData(),
        future: FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          Future.delayed(Duration(microseconds: 1000));
          return Scaffold(
            // key: scaffoldKey,
            appBar: AppBar(
              title: Text('Profile', style: _style(22)),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,

              // backgroundColor: Colors.white,
              // automaticallyImplyLeading: false,
              // leading: IconButton(
              //   icon: const Icon(
              //     Icons.arrow_back_rounded,
              //     color: Color(0xFF0F1113),
              //     size: 30,
              //   ),
              //   onPressed: () async {
              //     Navigator.pop(context);
              //   },
              // ),
              // actions: [],
              // centerTitle: false,
              // elevation: 0,
            ),
            backgroundColor: const Color(0xFFF1F4F8),
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: const Color(0x230F1113),
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 8, 16, 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: const BoxDecoration(
                                  color: const Color(0xFFE0E3E7),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      2, 2, 2, 2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: DisplayImage(
                                      imagePath: user.image,
                                      onPressed: () {},
                                      // imageOnly: true,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 0, 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      uname,
                                      style: _style(20),
                                    ),
                                    Text(
                                      ujobtitle,
                                      style: _style(14),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 32,
                                constraints: const BoxConstraints(
                                  maxHeight: 32,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF39D2C0),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  boxShadow: [
                                    const BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x32171717),
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return EditProfilePage();
                                    }));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 8, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(5, 5, 5, 5),
                                          child: Text(
                                            'Edit',
                                            style: _style(14),
                                          ),
                                        ),
                                        const FaIcon(
                                          FontAwesomeIcons.edit,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'About',
                              style: _style(18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 10),
                                child: Text(
                                  ushopedetails,
                                  style: _style(14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Personal Details',
                              style: _style(16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 12),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    boxShadow: [
                                      const BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            2, 2, 2, 2),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 12, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Shop Name',
                                                        style: _style(16),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 4, 16, 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    ushopedetails == null
                                                        ? "NA"
                                                        : ushopname,
                                                    style: _style(14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 12),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    boxShadow: [
                                      const BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: const Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            2, 2, 2, 2),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 12, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Email',
                                                        style: _style(16),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 4, 16, 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    uemail,
                                                    style: _style(14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 12),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      const BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: const Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            2, 2, 2, 2),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 12, 16, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Contact Number',
                                                        style: _style(16),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 4, 16, 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '+91 ' + umobileno,
                                                    style: _style(18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 120, 16, 12),
                        child: GestureDetector(
                          onTap: () async {
                            _auth.signOut();
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 170,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text("Log Out",
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            decoration: BoxDecoration(
                              color: const Color(0xFF090F13),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  width: 1, color: Colors.transparent),
                            ),
                            // elevation: 3,
                            // borderSide: BorderSide(
                            //   color: Colors.transparent,
                            //   width: 1,
                            // ),
                            // borderRadius: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

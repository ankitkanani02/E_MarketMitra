import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emmitra/screens/add_analytics_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String uid;
  late String email;
  var udata;
  List barValues = [0, 0, 0, 0, 0];

  getCurrentUser() async {
    final User? user = _auth.currentUser;
    uid = user!.uid;
    email = user.email!;
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getAD() async {
  //   var firestore = FirebaseFirestore.instance;
  //   var querySnap = await firestore
  //       .collection('analyticsData')
  //       .where('verifyEmail', isEqualTo: email)
  //       .get();
  //   return querySnap;
  // }

  getAnalyticsData() {
    FirebaseFirestore.instance
        .collection("analyticsData")
        .where("verifyEmail", isEqualTo: email)
        .get()
        .then((value) {
      final userdata = value.docs.first.data();
      setState(() {
        udata = Map.from(userdata);
      });
      barValues = udata['allBarvalues'].toString().split(',');
      print(barValues);
      // umobileno = udata['mobileno'] ?? "NA";
      // uname = udata['uname'] ?? "NA";
      // ushopedetails = udata['shopedetails'] ?? "NA";
      // uemail = udata['email'] ?? "NA";11
      // ujobtitle = udata['jobtitle'] ?? "NA";
      // ushopname = udata['shopename'] ?? "NA";
    }).catchError((e) {
      print('Erroe Featching Data');
    });
  }

  @override
  void initState() {
    getCurrentUser();
    getAnalyticsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('analyticsData').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: const Text(
                'Analytics',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.teal, size: 24),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AddAnalyticsWidget();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 2,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getMiddleTextWidget(lable: "Monthly Performance"),
                // getChartWidegt(),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      getBar(lable: barValues[0], barHeight: barValues[0]),
                      getBar(lable: barValues[1], barHeight: barValues[1]),
                      getBar(lable: barValues[2], barHeight: barValues[2]),
                      getBar(lable: barValues[3], barHeight: barValues[3]),
                      getBar(lable: barValues[4], barHeight: barValues[4])
                    ],
                  ),
                ),
                getMiddleTextWidget(lable: "Sales & Revenue"),
                Wrap(
                  spacing: 20, // to apply margin in the main axis of the wrap
                  runSpacing: 20,
                  children: [
                    getWarpElement(
                        context: context,
                        icon: Icons.payments,
                        data: udata['sales'],
                        label: "Total Sales".toUpperCase()),
                    getWarpElement(
                        context: context,
                        icon: Icons.supervisor_account_rounded,
                        data: udata['customers'],
                        label: "Customers".toUpperCase()),
                    getWarpElement(
                        context: context,
                        icon: Icons.web_asset_rounded,
                        data: udata['products'],
                        label: "no. of products".toUpperCase()),
                    getWarpElement(
                        context: context,
                        icon: Icons.pie_chart_outline_rounded,
                        data: udata['revenue'],
                        label: "total Revenue".toUpperCase())
                  ],
                )
              ],
            ),
          );
        });
  }
}

_style(double fontsize) {
  return TextStyle(
    fontFamily: 'Outfit',
    color: const Color(0xFF0F1113),
    fontSize: fontsize,
    fontWeight: FontWeight.normal,
  );
}

Widget getMiddleTextWidget({lable = "NA"}) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(28, 8, 20, 8),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          lable,
          style: _style(18),
        ),
      ],
    ),
  );
}

Column getBar({lable = "0", barHeight = "0"}) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Text(
        "$lable %",
        style: _style(14),
      ),
      Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
          child: Container(
            width: 36,
            height: int.parse(barHeight) * 2,
            decoration: BoxDecoration(
              color: const Color(0xFF39D2C0),
              borderRadius: BorderRadius.circular(12),
            ),
          )),
    ],
  );
}

Widget getWarpElement(
    {context, dynamic icon, String data = "NA", String label = "NA"}) {
  return // Generated code for this Column Widget...
      Container(
    width: MediaQuery.of(context).size.width * 0.4,
    height: 160,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(24),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFF0F1113),
            size: 44,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
            child: Text(data,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  color: const Color(0xFF0F1113),
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Outfit',
                color: Color(0xFF57636C),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              )),
        ],
      ),
    ),
  );
}

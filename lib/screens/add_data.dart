// import '../flutter_flow/flutter_flow_icon_button.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

_style(double fontsize) {
  return TextStyle(
    fontFamily: 'Outfit',
    color: const Color(0xFF0F1113),
    fontSize: fontsize,
    fontWeight: FontWeight.normal,
  );
}

class AddDataWidget extends StatelessWidget {
//   const AddDataWidget({Key? key}) : super(key: key);

//   @override
//   _AddDataWidgetState createState() => _AddDataWidgetState();
// }

// class _AddDataWidgetState extends State<AddDataWidget> {
  late TextEditingController latitudeController = TextEditingController();
  late TextEditingController productDetailsController = TextEditingController();
  late TextEditingController productNameController = TextEditingController();
  late TextEditingController productPriceController = TextEditingController();
  late TextEditingController shoeNameController = TextEditingController();
  late TextEditingController longitudeController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
  //   // super.initState();
  //   latitudeController = TextEditingController();
  //   productDetailsController = TextEditingController();
  //   productNameController = TextEditingController();
  //   productPriceController = TextEditingController();
  //   shoeNameController = TextEditingController();
  //   longitudeController = TextEditingController();
  // }

  CollectionReference productData =
      FirebaseFirestore.instance.collection('ProductData');

  AddDataWidget({Key? key}) : super(key: key);

  Future<void> addProductData() {
    // Call the user's CollectionReference to add a new user
    return productData
        .add({
          "lati": latitudeController.text,
          'longi': longitudeController.text,
          'pdetails': productDetailsController.text,
          'pname': productNameController.text,
          'pprice': productPriceController.text,
          'shopname': shoeNameController.text
        })
        .then((value) => print("Data Added!!!!!!!!!"))
        .catchError((error) => print("Failed to add Product Data: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: const Color(0xFFF1F4F8),
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
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
                            color: const Color(0xFF0F1113),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                      child: Text(
                        'Back',
                        style: _style(16),
                        // style: FlutterFlowTheme.of(context).title1.override(
                        //       fontFamily: 'Outfit',
                        //       color: Color(0xFF0F1113),
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 0, 0),
                child: Text(
                  'Add Product Details',
                  style: _style(32),
                  // style: FlutterFlowTheme.of(context).title1.override(
                  //       fontFamily: 'Outfit',
                  //       color: Color(0xFF0F1113),
                  //       fontSize: 32,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                ),
              ),
            ],
          ),
          actions: [],
          elevation: 0,
        ),
      ),
      backgroundColor: const Color(0xFFF1F4F8),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 7, 20, 7),
              child: TextFormField(
                controller: productNameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Enter  Product Name',
                  labelStyle: _style(14),
                  // FlutterFlowTheme.of(context).bodyText2.override(
                  //       fontFamily: 'Outfit',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  hintText: 'Enter  Product Name',
                  hintStyle: _style(14),
                  //  FlutterFlowTheme.of(context).bodyText1.override(
                  //       fontFamily: 'Lexend Deca',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: const Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24, 15, 20, 15),
                ),
                style: _style(14),
                //  FlutterFlowTheme.of(context).bodyText1.override(
                //       fontFamily: 'Outfit',
                //       color: Color(0xFF0F1113),
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal,
                //     ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 7, 20, 7),
              child: TextFormField(
                controller: productPriceController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Enter  Product Price',
                  labelStyle: _style(14),
                  // FlutterFlowTheme.of(context).bodyText2.override(
                  //       fontFamily: 'Outfit',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  hintText: 'Enter  Product Price',
                  hintStyle: _style(14),
                  // FlutterFlowTheme.of(context).bodyText1.override(
                  //       fontFamily: 'Lexend Deca',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
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
                      const EdgeInsetsDirectional.fromSTEB(24, 15, 20, 15),
                ),
                style: _style(14),
                // FlutterFlowTheme.of(context).bodyText1.override(
                //       fontFamily: 'Outfit',
                //       color: Color(0xFF0F1113),
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal,
                //     ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 20, 10),
              child: TextFormField(
                controller: productDetailsController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Enter  Product Details',
                  labelStyle: _style(14),
                  //  FlutterFlowTheme.of(context).bodyText2.override(
                  //       fontFamily: 'Outfit',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  hintText: 'Enter  Product Details',
                  hintStyle: _style(14),
                  // FlutterFlowTheme.of(context).bodyText1.override(
                  //       fontFamily: 'Lexend Deca',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
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
                      const EdgeInsetsDirectional.fromSTEB(24, 15, 20, 15),
                ),
                style: _style(14),
                // FlutterFlowTheme.of(context).bodyText1.override(
                //       fontFamily: 'Outfit',
                //       color: Color(0xFF0F1113),
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal,
                //     ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 20, 10),
              child: TextFormField(
                controller: shoeNameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Enter a Shop Name',
                  labelStyle: _style(14),
                  //  FlutterFlowTheme.of(context).bodyText2.override(
                  //       fontFamily: 'Outfit',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  hintText: 'Enter a Shop Name',
                  hintStyle: _style(14),
                  // FlutterFlowTheme.of(context).bodyText1.override(
                  //       fontFamily: 'Lexend Deca',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
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
                      const EdgeInsetsDirectional.fromSTEB(24, 15, 20, 15),
                ),
                style: _style(14),
                //  FlutterFlowTheme.of(context).bodyText1.override(
                //       fontFamily: 'Outfit',
                //       color: Color(0xFF0F1113),
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal,
                //     ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 20, 10),
              child: TextFormField(
                controller: latitudeController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Enter a latitude  of shope location',
                  labelStyle: _style(14),
                  // FlutterFlowTheme.of(context).bodyText2.override(
                  //       fontFamily: 'Outfit',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  hintText: 'Enter a latitude  of shope location',
                  hintStyle: _style(14),
                  // FlutterFlowTheme.of(context).bodyText1.override(
                  //       fontFamily: 'Lexend Deca',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: const Color(0x00000000),
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
                      const EdgeInsetsDirectional.fromSTEB(24, 15, 20, 15),
                ),
                style: _style(14),
                // FlutterFlowTheme.of(context).bodyText1.override(
                //       fontFamily: 'Outfit',
                //       color: Color(0xFF0F1113),
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal,
                //     ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 20, 10),
              child: TextFormField(
                controller: longitudeController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Enter a longitude of shope location',
                  labelStyle: _style(14),
                  // FlutterFlowTheme.of(context).bodyText2.override(
                  //       fontFamily: 'Outfit',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  hintText: 'Enter a longitude of shope location',
                  hintStyle: _style(14),
                  // FlutterFlowTheme.of(context).bodyText1.override(
                  //       fontFamily: 'Lexend Deca',
                  //       color: Color(0xFF57636C),
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.normal,
                  //     ),
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
                      const EdgeInsetsDirectional.fromSTEB(24, 15, 20, 15),
                ),
                style: _style(14),
                // FlutterFlowTheme.of(context).bodyText1.override(
                //       fontFamily: 'Outfit',
                //       color: Color(0xFF0F1113),
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal,
                //     ),
              ),
            ),

            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 18),
              child: GestureDetector(
                onTap: () {
                  addProductData();
                  Navigator.pop(context);
                },
                child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(width: 1, color: Colors.transparent),
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
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            //   child: FFButtonWidget(
            //     onPressed: () async {
            //       await Future.delayed(const Duration(milliseconds: 1000));
            //     },
            //     text: 'Save Changes',
            //     options: FFButtonOptions(
            //       width: 270,
            //       height: 50,
            //       color: Color(0xFF0F1113),
            //       textStyle: FlutterFlowTheme.of(context).subtitle2.override(
            //             fontFamily: 'Outfit',
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontWeight: FontWeight.normal,
            //           ),
            //       elevation: 3,
            //       borderSide: BorderSide(
            //         color: Colors.transparent,
            //         width: 1,
            //       ),
            //       borderRadius: 8,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

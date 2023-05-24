import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String title) {
  _style(double fontsize) {
    return TextStyle(
      fontFamily: 'Outfit',
      color: Color(0xFF0F1113),
      fontSize: fontsize,
      fontWeight: FontWeight.normal,
    );
  }

  return AppBar(
    iconTheme: IconThemeData(
        color: Colors
            .black), // set backbutton color here which will reflect in all screens.
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      title,
      style: _style(32),
    ),
  );
}

AppBar buildAppBarWhite({required String title}) {
  return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ));
}

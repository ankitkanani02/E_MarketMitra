// Future<void> signInWithGoogle() async {
//     //first trigger authentication
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     //obtain the auth details
//     final GoogleSignInAuthentication googleAuth =
//         await googleUser!.authentication;
//     //create a new credentials
//     final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

//     //saving the user data to shared preferences
//     final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     //-------------------- SharedPrefsHelper _sharedpref = new SharedPrefsHelper();--------------------

//     // // sign in method
//     try {
//       UserCredential firebaseUser =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//       if (firebaseUser != null) {
//         // Check is already sign up
//         final QuerySnapshot result = await FirebaseFirestore.instance
//             .collection('users')
//             .where('id', isEqualTo: firebaseUser.user?.uid)
//             .get();

// //userdata to update at firebase
// //passing this via constructor to the next page

//         Map<String, dynamic> userdata = {
//           'useremail': firebaseUser.user?.email,
//           'displayname': firebaseUser.user?.displayName,
//           'photoUrl': firebaseUser.user?.photoURL,
//           'userid': firebaseUser.user?.uid,
//         };

// // navigate . if you don't have context here you can pass this as a paramater to the method. no issue if you call inside build or init

//         //userdata is map. just for handling easily
//         //you can also create simple variables and pass each value to them.
//         Navigator.pushReplacement(_context,
//             MaterialPageRoute(builder: (context) => CreateUserAcc(userdata)));
//       }

//       final UserCredential _userCredential = firebaseUser;
//     } catch (error) {
//       print(error);
//     }
//   }

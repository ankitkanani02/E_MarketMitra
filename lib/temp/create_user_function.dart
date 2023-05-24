// final _collectionRef = FirebaseFirestore.instance.collection('users');

// createUserInFirestore() async {
//   final GoogleSignInAccount? user = googleSignIn.currentUser;
//   print(user!.id);
//   final DocumentSnapshot doc = await _collectionRef.doc(user.id).get();

//   if (!doc.exists) {
//     final username = await Navigator.push(
//         _context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 // Sample()
//                 const CreateAccount()));
//     _collectionRef.doc(user.id).set({
//       'id': user.id,
//       'name': username,
//       'photoUrl': user.photoUrl,
//       'email': user.email,
//       'displayName': user.displayName,
//       'bio': '',
//       'timestemp': timeStemp
//     });
//   } else {
//     print('User dose exits');
//   }
// }

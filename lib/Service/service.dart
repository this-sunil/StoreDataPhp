import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class Service {
  GoogleSignInAuthentication googleSignInAuth;
  GoogleSignInAccount googleSignIn;
  Future<UserCredential> handleSignIn() async {
    googleSignIn = await GoogleSignIn().signIn();
    googleSignInAuth = await googleSignIn.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuth.accessToken,
      idToken: googleSignInAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<GoogleSignInAccount> handleSignOut() async {
    googleSignIn = await GoogleSignIn().signOut();
    return googleSignIn;
  }

  String url = "http://192.168.32.124/conn.php";
  Future fetchData() async {
    final response = await http.get(Uri.parse(url));

    /* List<Users> users = new List();
    Map<String, dynamic> maps = jsonDecode(response.body);

    for (int i = 0; i < 20; i++) {
      users.add(Users.fromJson(maps));
    } */
    return jsonDecode(response.body);
  }

  /* Future post() async {
    final response = await http.post(Uri.parse(url), body: {});
    return jsonDecode(response.body);
  } */

  Future patch() async {
    final response = await http.patch(Uri.parse(url), body: {});
    return response.body;
  }

  Future put() async {
    final response = await http.put(Uri.parse(url), body: {});
    return response.body;
  }
}

import 'package:SocialMedia/Screen/HomeScreen.dart';
import 'package:SocialMedia/Service/service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({Key key}) : super(key: key);

  @override
  _SocialMediaState createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  Service service;

  @override
  void initState() {
    super.initState();
    setState(() {
      service = Service();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              heroTag: 'signIn',
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              icon: FaIcon(FontAwesomeIcons.google),
              label: Text("Sign In With Google"),
              onPressed: () {
                setState(() {
                  service.handleSignIn();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                });
              },
            ),
            SizedBox(height: 20),
            FloatingActionButton.extended(
              heroTag: 'signOut',
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              icon: FaIcon(FontAwesomeIcons.google),
              label: Text("Sign out"),
              onPressed: () {
                setState(() {
                  service.handleSignOut();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:SocialMedia/Screen/AddData.dart';
import 'package:SocialMedia/Service/SocialMedia.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SocialMedia/Service/service.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name;
  String email;
  String pic;
  Service service;

  @override
  void initState() {
    super.initState();
    setState(() {
      service = Service();
      service.fetchData();
      name = FirebaseAuth?.instance?.currentUser?.displayName;
      email = FirebaseAuth?.instance?.currentUser?.email;
      pic = FirebaseAuth?.instance?.currentUser?.photoURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Media"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              setState(() {
                service.handleSignOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SocialMedia()));
              });
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(email),
              accountName: Text(name),
              currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    pic,
                    fit: BoxFit.cover,
                  )),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: service.fetchData(),
        builder: (context, snapShot) {
          List user = snapShot.data;
          if (snapShot.hasData) {
            return ListView.builder(
              itemCount: snapShot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                        child: Text(
                            "${user[index]['firstname'].substring(0, 1)}")),
                    title: Text(
                        "${user[index]['firstname'] + "\t" + user[index]['lastname']}"),
                    subtitle: Text("${user[index]['mobile']}"),
                    trailing: IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            String url = 'http://192.168.32.124/delete.php';
                            http.post(url, body: {
                              'rollno': user[index]['rollno'],
                            });
                          });
                        }),
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddData(user: user, index: index)));
                      });
                    },
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddData()));
          });
        },
      ),
    );
  }
}

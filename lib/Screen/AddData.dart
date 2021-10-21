import 'package:SocialMedia/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  final List user;
  final int index;

  AddData({this.user, this.index});
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController mobile = TextEditingController();
  bool edit = false;
  void addData() {
    if (edit) {
      String url = "http://192.168.32.124/update.php";
      http.post(url, body: {
        'rollno': widget.user[widget.index]['rollno'],
        'firstname': firstname.text,
        'lastname': lastname.text,
        'mobile': mobile.text,
      });
    } else {
      String url = "http://192.168.32.124/AddData.php";
      http.post(url, body: {
        'firstname': firstname.text,
        'lastname': lastname.text,
        'mobile': mobile.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      edit = true;
      firstname.text = widget.user[widget.index]['firstname'];
      lastname.text = widget.user[widget.index]['lastname'];
      mobile.text = widget.user[widget.index]['mobile'];
    }
    setState(() {
      addData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(edit ? 'Update Data' : "Add Data With Php"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            TextFormField(
              controller: firstname,
              decoration: InputDecoration(
                  hintText: "Enter your firstname",
                  labelText: "Enter your firstname",
                  counterText: "",
                  border: OutlineInputBorder()),
              keyboardType: TextInputType.text,
              maxLength: 20,
              validator: (fname) => firstname.text = fname,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: lastname,
              decoration: InputDecoration(
                  hintText: "Enter your lastname",
                  labelText: "Enter your lastname",
                  counterText: "",
                  border: OutlineInputBorder()),
              keyboardType: TextInputType.text,
              validator: (lname) => lastname.text = lname,
              maxLength: 20,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: mobile,
              decoration: InputDecoration(
                  hintText: "Enter your mobile",
                  labelText: "Enter your mobile",
                  counterText: "",
                  border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
              maxLength: 10,
              validator: (mob) => mobile.text = mob,
            ),
            SizedBox(height: 40),
            FloatingActionButton.extended(
                backgroundColor: Colors.pink,
                label: Text(edit ? 'Update Data' : "Submit",
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    addData();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  });
                }),
          ],
        ),
      ),
    );
  }
}

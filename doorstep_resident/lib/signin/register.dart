import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authclass.dart';

class Register extends StatefulWidget {
  //final BaseAuth auth;
  // Signin({this.auth});

  @override
  _RegisterState createState() => _RegisterState();
}

class APIPath2 extends Register {
  static String regid(String email, String uniqueid) => '$email/$uniqueid';
  static String readdata(String email) => '/$email';
}

final _formKey = new GlobalKey<FormState>();
TextEditingController emailcontroller = new TextEditingController();
TextEditingController passswordcontroller = new TextEditingController();

String regblock;

class _RegisterState extends State<Register> {
  String get _email => emailcontroller.text.trim();
  String get _password => passswordcontroller.text;

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      child: new TextFormField(
        controller: emailcontroller,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      child: new TextFormField(
        controller: passswordcontroller,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        // onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  void loginbutton(BuildContext context) async {
    try {
      final auth = Provider.of<BaseAuth>(context, listen: false);

      await auth.signup(_email, _password);
      print('Successfully signed');
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          elevation: 20.0,
          title: Text("Successfully Signed"),
          content: Text(
              "Enter correct email and password should not be less than 6 characters"),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text("OK"))
          ],
        ),
      );
      Navigator.of(context).pop();
      emailcontroller.clear();
      passswordcontroller.clear();
    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          elevation: 20.0,
          title: Text("Failed"),
          content: Text(
              "Enter unique email and password should not be less than 6 characters"),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text("OK"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Register'),
          elevation: 20.0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(47.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              color: Theme.of(context).cardColor,
              elevation: 5.0,
              child: showForm(context),
            ),
          ),
        ));
  }

  Widget showForm(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              shrinkWrap: true,
              children: <Widget>[
                //showblockInput(),
                showEmailInput(),
                showPasswordInput(),
                FlatButton.icon(
                  icon: Icon(Icons.mail_outline),
                  onPressed: () => loginbutton(context),
                  label: Text('Register',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontSize: 20.0,
                        textBaseline: TextBaseline.alphabetic,
                        fontWeight: FontWeight.w800,
                      )),
                )
              ],
            )));
  }
}

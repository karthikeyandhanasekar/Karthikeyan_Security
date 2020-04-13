import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authclass.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

final _formKey = new GlobalKey<FormState>();
TextEditingController emailcontroller = new TextEditingController();
TextEditingController passswordcontroller = new TextEditingController();

class _RegisterState extends State<Register> {
  String get _email => emailcontroller.text.trim();
  String get _password => passswordcontroller.text.trim();

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new TextFormField(
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
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
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
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
      ),
    );
  }

  void registerbutton(BuildContext context) async {
    try {
      final auth = Provider.of<BaseAuth>(context, listen: false);

      await auth.signup(_email, _password);
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          elevation: 20.0,
          title: Text("Failed"),
          content: Text(
              "Register with unique  email and password \n Note: Password should not be less than 6 characters"),
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
            padding: const EdgeInsets.fromLTRB(40, 75, 41, 105),
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
              padding: EdgeInsets.fromLTRB(0.0, 10, 0.0, 10),
              shrinkWrap: true,
              children: <Widget>[
                showEmailInput(),
                SizedBox(
                  height: 10.0,
                ),
                showPasswordInput(),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 10.0,
                  child: FlatButton.icon(
                    onPressed: () => registerbutton(context),
                    icon: Icon(Icons.mail_outline),
                    label: Text('Register',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueGrey[600],
                          fontSize: 15.0,
                          textBaseline: TextBaseline.alphabetic,
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                )
              ],
            )));
  }
}

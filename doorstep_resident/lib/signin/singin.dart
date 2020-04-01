import 'package:doorstep_resident/signin/authclass.dart';
import 'package:doorstep_resident/signin/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

final _formKey = new GlobalKey<FormState>();
TextEditingController emailcontrollers = new TextEditingController();
TextEditingController passswordcontroller = new TextEditingController();

String id;
bool _isloading = false;

String get emailid => emailcontrollers.text.trim();
String get _password => passswordcontroller.text;

String mailid = emailid;

class _SigninState extends State<Signin> {
  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      child: new TextFormField(
        controller: emailcontrollers,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        enabled: _isloading == false,
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
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        controller: passswordcontroller,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        enabled: _isloading == false,
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
    setState(() {
      _isloading = true;
    });
    print('Login button Called');
    try {
      await Future.delayed(Duration(seconds: 1));
      if (emailid != null && _password != null) {
        var auth = Provider.of<BaseAuth>(context, listen: false);
        await auth.signin(emailid, _password);
        passswordcontroller.clear();
      }
    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          elevation: 20.0,
          title: Text("Login Failed"),
          content: Text(
              "Email or password is invalid\nNote : Kindly Check space after email  "),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text("OK"))
          ],
        ),
      );
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Resident'),
          elevation: 20.0,
        ),

        body:
            
            Center(
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
        padding: EdgeInsets.all(5.0),
        child: new Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(10.0),
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
                FlatButton.icon(
                  onPressed: () => loginbutton(context),
                  textColor: Colors.blueGrey,
                  hoverColor: Colors.deepPurple,
                  icon: Icon(Icons.mail_outline),
                  label: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.blueGrey[800],
                      fontSize: 20.0,
                    ),
                  ),
                ),
                FlatButton(
                    onPressed: () => register(),
                    child: Text(
                      'Or Create',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.blueGrey[800],
                      ),
                    ))
              ],
            )));
  }

  register() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Register()));
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.clear();
    passswordcontroller.clear();
  }
}

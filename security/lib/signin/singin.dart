import 'package:chatting/signin/authclass.dart';
import 'package:chatting/signin/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {             //Login Page
  @override
  _SigninState createState() => _SigninState();
}



final _formKey = new GlobalKey<FormState>();
TextEditingController emailcontroller = new TextEditingController();
TextEditingController passswordcontroller = new TextEditingController();

String id;
bool _isloading = false;

class _SigninState extends State<Signin> {
  String get _email => emailcontroller.text.trim();
  String get _password => passswordcontroller.text;

  //email input
  Widget showEmailInput() {                     
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
      child: new TextFormField(
        controller: emailcontroller,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
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
  
  //password input
  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
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
  
//login function which process when u click login button
  void login(BuildContext context) async {
    try {
      final auth = Provider.of<BaseAuth>(context, listen: false);   // get the abstract class BaseAuthh from authclass.dart by using provider package
      await auth.signin(_email, _password);    //get singin method

      passswordcontroller.clear();
    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          elevation: 20.0,
          title: Text("Login Failed"),
          content: Text("Email or password is invalid"),
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
          title: Text('Security'),
          elevation: 20.0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 75, 20, 130),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              color: Theme.of(context).cardColor,
              elevation: 5.0,
              child: showForm(context),    // initialze the showform function which contain form field
            ),
          ),
        ));
  }

  Widget showForm(BuildContext context) {
    return new Container(
        child: new Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.fromLTRB(0.0, 10, 35.0, 10),
              children: <Widget>[
                showEmailInput(),  //email 
                SizedBox(
                  height: 10.0,
                ),
                showPasswordInput(),  //password
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                  child: OutlineButton(
                    onPressed: () => login(context),
                    textColor: Colors.grey[800],
                    hoverColor: Colors.deepPurple,
                    color: Colors.indigo[800],
                    child: Text('Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueGrey[600],
                          fontSize: 20.0,
                          textBaseline: TextBaseline.alphabetic,
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                ),
                FlatButton(          //buttom to enter to register page  remove flatbutton if u didn't want register feature
                    onPressed: () => register(),
                    child: Text(
                      ' OR Create!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.blueGrey[600],
                        fontSize: 15.0,
                      ),
                    ))
              ],
            )));
  }

  register() {                   // it push to register page 
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Register()));
  }
}

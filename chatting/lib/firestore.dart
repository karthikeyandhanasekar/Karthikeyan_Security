import 'package:chatting/database/database.dart';
import 'package:chatting/database/model.dart';
import 'package:chatting/signin/authclass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class APIPath1 extends Details {
  static String senddata(String block, String jobid) => '/$block/$jobid';
  static String readdata(String uid) => '/$uid';
}

class Details extends StatefulWidget {
  final Database database;
  //final String  uid;
  const Details({Key key, @required this.database}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Details(
              database: database,
            )));
  }

  @override
  _DetailsState createState() => _DetailsState();
}

TextEditingController blockcontroller = new TextEditingController();
TextEditingController doorcoltroller = new TextEditingController();
TextEditingController customercontroller = new TextEditingController();
TextEditingController customernumcontroller = new TextEditingController();
TextEditingController purposecontroller = new TextEditingController();

final databaseReference = Firestore.instance;

final String blockno = blockcontroller.text;
String doorno = doorcoltroller.text;
String customername = customercontroller.text;
String customernumber = customernumcontroller.text;
String purpose = purposecontroller.text;
String date = DateFormat.yMMMMEEEEd().format(DateTime.now());
String time = DateFormat.jm().format(DateTime.now());
String documentid = '$blockno' + '$doorno';

String uniqueres = '$blockno' + '$doorno';

String block, door, customer, number, reason;
String message =
    'DoorStep Security System \n \n\n\n\n Visitor: $customer ,\Visitor number: $number,\n  \n Date  : $date, \nTime : $time ,\n Reason : $reason';

User user;

String userid = user.uid;

var token = IdTokenResult;

final _formkey = GlobalKey<FormState>();

class _DetailsState extends State<Details> {
  void whatsapp(BuildContext context) async {
    String blockver = blockcontroller.text;
    String phonenumber;
    String custname = customercontroller.text;
    String custnum = customernumcontroller.text;
    String purpose = purposecontroller.text;
    if (blockver == 'dkkarthik2000@gmail.com') {
      phonenumber = '9123565978';
    }
    if (blockver == 'aakaash146@gmail.com') {
      phonenumber = '7871035199';
    }
    if (blockver == 'navinraj@gmail.com') {
      phonenumber = '7871666571';
    }

    final String allforone =
        'DoorStep Security System \n \n\n\n\n Visitor: $custname ,\nVisitor number: $custnum,\n Date  : $date, \nTime : $time ,\nReason : $purpose';
    FlutterOpenWhatsapp.sendSingleMessage("+91$phonenumber", allforone);
    blockcontroller.clear();
    doorcoltroller.clear();
    customernumcontroller.clear();
    customercontroller.clear();
    purposecontroller.clear();
  }

  bool _validateandSaveForm() {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _submit() async {
    if (_validateandSaveForm()) {
      print('form saved : $reason and $number');
      final view = Senddata(
          blockid: block,
          Customername: customer,
          Customernumber: number,
          date: date,
          doorno: door,
          time: time,
          reason: reason,
          id: documentid);
      await widget.database.createviewer(view);
      Navigator.of(context).pop();
      String blockver = blockcontroller.text;
      String phonenumber;
      String custname = customercontroller.text;
      String custnum = customernumcontroller.text;
      String purpose = purposecontroller.text;
      if (blockver == 'dkkarthik2000@gmail.com') {
        phonenumber = '9123565978';
      }
      if (blockver == 'aakaash146@gmail.com') {
        phonenumber = '7871035199';
      }
      if (blockver == 'navinraj@gmail.com') {
        phonenumber = '7871666571';
      }

      final String allforone =
          'DoorStep Security System \n \n\n\n\n Visitor: $custname ,\nVisitor number: $custnum,\n Date  : $date, \nTime : $time ,\nReason : $purpose';
      FlutterOpenWhatsapp.sendSingleMessage("+91$phonenumber", allforone);
      blockcontroller.clear();
      doorcoltroller.clear();
      customernumcontroller.clear();
      customercontroller.clear();
      purposecontroller.clear();
    }
  }

  Future<FirebaseUser> firebaseUser() async {
    return await FirebaseAuth.instance
        .currentUser()
        .then((FirebaseUser user) async {
      userid = user.uid;
      print(userid);
    });
  }

  void share() async {
    final String share1 =
        'DoorStep Security System \n \n\n\n\n Visitor: ${customercontroller.text} ,\nVisitor number: ${customernumcontroller.text},\n Date  : $date, \nTime : $time ,\nReason : ${purposecontroller.text}';

    final RenderBox box = context.findRenderObject();
    Share.share(share1,
        subject: 'DoorStep Security Services',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void sendSMS() async {
    List<String> recipents = ["7871666571", "7871032199"];
    String _result =
        await FlutterSms.sendSMS(message: message, recipients: recipents)
            .catchError((onError) {
      print(onError);
    });

    print(_result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Viewer details'),
        elevation: 20.0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () => share())
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Theme.of(context).cardColor,
              child: form()),
        ),
      ),
    );
  }

  Widget form() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(45.0),
      child: Form(
        key: _formkey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildformchildren()),
      ),
    );
  }

  void save(BuildContext context) async {
    try {
      final view = Senddata(
          blockid: blockno,
          Customername: customername,
          Customernumber: customernumber,
          date: date,
          doorno: doorno,
          time: time,
          reason: purpose,
          id: documentid);
      await widget.database.createviewer(view);
      blockcontroller.clear();
      doorcoltroller.clear();
      customernumcontroller.clear();
      customercontroller.clear();
      purposecontroller.clear();

      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text("Enter correct details"),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text("OK"))
          ],
        ),
      );
    }
  }

  List<Widget> _buildformchildren() {
    return [
      TextFormField(
        autofocus: true,
        style: TextStyle(fontSize: 17.0, color: Colors.black),

        controller: blockcontroller,
        decoration: InputDecoration(
            labelText: 'Block  and DoorID',
            icon: Icon(Icons.domain),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
            )),
        onSaved: (value) => block = value.trim(), //remove trim
      ),
      TextFormField(
        style: TextStyle(fontSize: 17.0, color: Colors.black),
        controller: customercontroller,
        decoration: InputDecoration(
          labelText: 'Visitor',
          icon: Icon(Icons.people),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        onSaved: (value) => customer = value,
      ),
      TextFormField(
        style: TextStyle(fontSize: 17.0, color: Colors.black),
        autofocus: true,
        controller: customernumcontroller,
        decoration: InputDecoration(
          labelText: 'Visitor number',
          icon: Icon(Icons.add_call),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        onSaved: (value) => number = value,
        keyboardType: TextInputType.numberWithOptions(),
      ),
      TextFormField(
        style: TextStyle(fontSize: 17.0, color: Colors.black),
        autofocus: true,
        controller: purposecontroller,
        decoration: InputDecoration(
          labelText: 'Reason',
          icon: Icon(Icons.question_answer),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        onSaved: (value) => reason = value,
      ),
      SizedBox(
        height: 10.0,
      ),
      OutlineButton.icon(
        icon: Icon(Icons.save),
        onPressed: () => _submit(),
        label: Text(
          'Save',
          style: TextStyle(
            color: Colors.blueGrey[800],
            fontSize: 15.0,
          ),
        ),
      ),
    ];
  }
}

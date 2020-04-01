import 'package:doorstep_resident/database/database.dart';
import 'package:doorstep_resident/database/model.dart';
import 'package:doorstep_resident/signin/authclass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sms/flutter_sms_platform.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'show.dart';

class APIPath1 extends Details {
  static String senddata(String block, String jobid) => '/$block/$jobid';
  static String readdata(String block) => '/$block';
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

String block, door, customer, number, reason;
String message =
    'DoorStep Security System \n \n\n\n\n Customername: $customername ,\nCustomer number: $customernumber,\n Block ID : $blockno,\n  Door No  : $doorno, \n Date  : $date, \nTime : $time ';
String showmessage =
    ' Customername: $customername ,\n Customer number: $customernumber,\n Block ID : $blockno,\n  Door No  : $doorno, \n Date  : $date, \nTime : $time ';
//The variable 'Showmessage is must share to the file show.dart

//User user;

//String userid = user.uid;

var token = IdTokenResult;

final _formkey = GlobalKey<FormState>();

class _DetailsState extends State<Details> {
/*
  Future<void> createviewer(BuildContext context) async
  {
    final database = Provider.of<Database>(context, listen: false);
    await database.createviewer(
            Senddata(blockid: blockno, Customername: customername, Customernumber: customernumber, date: date, doorno: doorno, time: time, reason: purpose)
          
      
    
    );
  }*/
  bool _validateandSaveForm() {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // final FirebaseUser user = firebaseUser()

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
    }
  }

  /*Future<FirebaseUser> firebaseUser() async {
    return await FirebaseAuth.instance
        .currentUser()
        .then((FirebaseUser user) async {
      userid = user.uid;
      print(userid);
    });
  }
*/
  void share() async {
    final RenderBox box = context.findRenderObject();
    Share.share(message,
        subject: 'Hello',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void createRecord(String documentid) async {
    //print(user);

    await databaseReference
        .collection("$documentid")
        .document("Records")
        .setData({
      'Customername': '$customername ',
      'Customer number': '$customernumber',
      'Block ID': '$blockno',
      'Door No ': '$doorno',
      'Date ': '$date',
      'Time': '$time',
      'Reason': '$purpose'
    });

    DocumentReference ref =
        await databaseReference.collection("$documentid").add({
      'Customername': '$customername ',
      'Customer number': '$customernumber',
      'Block ID': '$blockno',
      'Door No ': '$doorno',
      'Date ': '$date',
      'Time': '$time',
      'Reason': '$purpose'
    });
    print(ref.documentID);
    print(token);
  }

  void getData(S) {
   // print(user);
    databaseReference
        .collection("books")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void updateData() {
    try {
      databaseReference
          .collection('books')
          .document('1')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      databaseReference.collection('books').document('1').delete();
    } catch (e) {
      print(e.toString());
    }
  }

  void sendSMS() async {
    List<String> recipents = ["7871666571", "7871032199"];
    String _result = await FlutterSmsPlatform.instance
        .sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });

    print(_result);
  }

  @override
  Widget build(BuildContext context) {
    //final database = Provider.of<Database>(context);

    User user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Viewer details'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () => share())
        ],
      ),
      body: form(),
    );
  }

  Expanded buildExpanded(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: ListView(children: <Widget>[
          ListTile(
            title: null,
            // items: null,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0),
            child: TextField(
              autocorrect: false,
              controller: blockcontroller,
              onChanged: (value) {
                print(value);
              },
              decoration: new InputDecoration(
                labelText: 'Block details',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: TextField(
              autocorrect: false,
              controller: doorcoltroller,
              onChanged: (value) {
                print(value);
              },
              decoration: new InputDecoration(
                labelText: 'Doorno',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: TextField(
              autocorrect: false,
              controller: customercontroller,
              onChanged: (value) {
                print(value);
              },
              decoration: new InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: TextField(
              autocorrect: false,
              controller: customernumcontroller,
              onChanged: (value) {
                print(value);
              },
              decoration: new InputDecoration(
                labelText: 'Customer number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: TextField(
              autocorrect: false,
              controller: purposecontroller,
              onChanged: (value) {
                print(value);
              },
              decoration: new InputDecoration(
                labelText: 'Why?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(children: <Widget>[
              Expanded(
                  child: RaisedButton(
                      child: Text("Save"),
                      onPressed: () => save(context) //createRecord(documentid),

                      )),
              SizedBox(width: 10.0),
              Expanded(
                  child: RaisedButton(
                child: Text("SMS"),
                onPressed: () => sendSMS(),
              )),
              Expanded(
                  child: RaisedButton(
                      child: Text("ShowList"),
                      onPressed: () {
                        //here
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Show()));
                      }))
            ]),
          )
        ]),
      ),
    );
  }

  Widget form() {
    return SingleChildScrollView(
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
    }
  }

  List<Widget> _buildformchildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Block name'),
        onSaved: (value) => block = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Door NO'),
        onSaved: (value) => door = value,
        keyboardType: TextInputType.numberWithOptions(),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Customer'),
        onSaved: (value) => customer = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Customer number'),
        onSaved: (value) => number = value,
        keyboardType: TextInputType.numberWithOptions(),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Reason'),
        onSaved: (value) => reason = value,
      ),
      RaisedButton(
        onPressed: () => _submit(),
        child: Text('Save'),
      )
    ];
  }
}

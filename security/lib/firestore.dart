import 'package:chatting/database/database.dart';
import 'package:chatting/database/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:chatting/platoformalertdialog.dart';
import 'package:chatting/signin/authclass.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

TextEditingController blockcontroller = new TextEditingController();
TextEditingController doorcontroller = new TextEditingController();
TextEditingController customercontroller = new TextEditingController();
TextEditingController customernumcontroller = new TextEditingController();
TextEditingController purposecontroller = new TextEditingController();
TextEditingController phoneNumcontroller = new TextEditingController();

final String blockno = blockcontroller.text;
String doorno = doorcontroller.text;
String customername = customercontroller.text;
String customernumber = customernumcontroller.text;
String purpose = purposecontroller.text;
String date = DateFormat.yMMMMEEEEd().format(DateTime.now());
String time = DateFormat.jm().format(DateTime.now());
String documentid;

String block, customer, number, reason; // the variable which used to pass the value to database it important

final _formkey = GlobalKey<FormState>();

class _DetailsState extends State<Details> {
  bool _validateandSaveForm() {                      //   it validate the form given below
    final form = _formkey.currentState;
    if (form.validate()) {         
      form.save();                     // it save the form with current value
      return true;
    }
    return false;
  }

  void _submit() async {
    if (_validateandSaveForm()) {                                    //check the  bool function
      final database = Provider.of<Database>(context, listen: false);  //get database abstract class from database folder and initalize to final database using provider package

      print('form saved : $reason and $number');    
      final view = Senddata(                                       //ths is the process where the data is stored
          blockid: block,
          Customername: customer,
          Customernumber: number,
          date: date,
          doorno: doorcontroller.text.trim(),
          time: time,
          reason: reason,
          id: documentid);

      await database.createviewer(view);
      Navigator.of(context).pop();

      String custname = customercontroller.text;
      String custnum = customernumcontroller.text;
      String purpose = purposecontroller.text;
      final String information =
          'DoorStep Security System \n \n\n\n\nBlock ID: ${blockcontroller.text.trim()} ,\nDoor ID: ${doorcontroller.text.trim()} Visitor: $custname ,\nVisitor number: $custnum,\n Date  : $date, \nTime : $time ,\nReason : $purpose';
      FlutterOpenWhatsapp.sendSingleMessage(
          "+91${phoneNumcontroller.text.trim()}", information);
      blockcontroller.clear();
      doorcontroller.clear();
      customernumcontroller.clear();
      customercontroller.clear();
      purposecontroller.clear();
      phoneNumcontroller.clear();
    }
  }

   //it is the share function used to share to any way
  void share() async {                 
    final String share1 =
        'DoorStep Security System \n \n\n\n\n Block ID: ${blockcontroller.text.trim()} ,\nDoor ID: ${doorcontroller.text.trim()} \nVisitor: ${customercontroller.text.trim()} ,\nVisitor number: ${customernumcontroller.text.trim()},\n Date  : $date, \nTime : $time ,\nReason : ${purposecontroller.text}';
    final RenderBox box = context.findRenderObject();
    Share.share(share1,
        subject: 'DoorStep Security Services',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
  
  //it is logout function
  Future<void> logout(BuildContext context) async {
    try {
      final auth = Provider.of<BaseAuth>(context, listen: false);
      auth.signout();
    } catch (e) {
      print(e.toString());
      showDialog(context: context,
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text("LogOut Failed"),
          content: Text("${e.toString()}"),
        ); 
      });
    }
  }

  Future<void> confirmsignout(BuildContext context) async {
    final didrequest = await PlatformAlertDialog(                                   // a platfrom alert dialog which get form platfrom file and it maunal
      title: 'Log out',
      content: 'Are you sure',
      cancelactiontext: 'Cancel',
      defaultactiontext: 'Logout',
    ).show(context);
    if (didrequest == true) logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Viewer details'),
        elevation: 20.0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () => share()),
          FlatButton(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => confirmsignout(context)),
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

  List<Widget> _buildformchildren() {                                                   //input field and button inside the card
    return [
      TextFormField(
        autofocus: true,
        style: TextStyle(fontSize: 17.0, color: Colors.black),
        controller: blockcontroller,
        decoration: InputDecoration(
            labelText: 'Block ID',
            icon: Icon(Icons.domain),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
            )),
        onSaved: (value) => block = value.trim(), //remove trim
      ),
      TextFormField(
        autofocus: true,
        style: TextStyle(fontSize: 17.0, color: Colors.black),
        controller: doorcontroller,
        decoration: InputDecoration(
            labelText: 'DoorID',
            icon: Icon(Icons.domain),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
            )),
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
        maxLength: 10,
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
      Text("To :",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.blueGrey[800],
            fontSize: 15.0,
            textBaseline: TextBaseline.alphabetic,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto',
          )),
      TextFormField(
        autofocus: true,
        style: TextStyle(fontSize: 17.0, color: Colors.black),
        maxLength: 10,
        controller: phoneNumcontroller,
        decoration: InputDecoration(
            labelText: 'Resident Number',
            icon: Icon(Icons.phone_forwarded),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
            )),
      ),
      OutlineButton.icon(
        icon: Icon(Icons.save),
        onPressed: () => _submit(),             // a button which  store and share the data through whatsapp
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

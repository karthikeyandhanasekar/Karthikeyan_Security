import 'package:chatting/Remainder/Cab.dart';
import 'package:chatting/Remainder/delivery.dart';
import 'package:chatting/Remainder/vistor.dart';
import 'package:chatting/database/database.dart';
import 'package:chatting/database/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:chatting/platoformalertdialog.dart';
import 'package:chatting/signin/authclass.dart';
import 'package:fab_menu/fab_menu.dart';

class Details extends StatefulWidget {
  /*final Database database;
  const Details({Key key, @required this.database}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Details(
              database: database,
            )));
  }*/
  @override
  _DetailsState createState() => _DetailsState();
}

TextEditingController blockcontroller = new TextEditingController();
TextEditingController doorcontroller = new TextEditingController();
TextEditingController customercontroller = new TextEditingController();
TextEditingController customernumcontroller = new TextEditingController();
TextEditingController purposecontroller = new TextEditingController();
TextEditingController phoneNumcontroller = new TextEditingController();
TextEditingController companycontroller = new TextEditingController();

final String blockno = blockcontroller.text;
String doorno = doorcontroller.text;
String customername = customercontroller.text;
String customernumber = customernumcontroller.text;
String purpose = purposecontroller.text;
String date = DateFormat.yMMMMEEEEd().format(DateTime.now());
String time = DateFormat.jm().format(DateTime.now());
String documentid;

String block, customer, number, reason;

final _formkey = GlobalKey<FormState>();
List<MenuData> menuDataList;

class _DetailsState extends State<Details> {
  void initState() {
    super.initState();
    menuDataList = [
      new MenuData(
        Icons.local_taxi,
        (context, menuData) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Cab()));
        },
        labelText: 'Cab',
      ),
      new MenuData(Icons.fastfood, (context, menuData) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Delivery()));
      }, labelText: 'Delivery'),
      new MenuData(Icons.people, (context, menuData) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Visitor()));
      }, labelText: 'Visitor'),
    ];
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
      final database = Provider.of<Database>(context, listen: false);

      print('form saved : $reason and $number');
      final view = Senddata(
          blockid: block,
          Customername: customer,
          Customernumber: number,
          date: date,
          doorno: doorcontroller.text.trim(),
          time: time,
          reason: reason,
          company: companycontroller.text.trim(),
          id: documentid);
      await database.createviewer(view);
      //Navigator.of(context).pop();

      final String information =
          'DoorStep Security System \n\n\n\n\nBlock ID: ${blockcontroller.text.trim()}\nDoor ID: ${doorcontroller.text.trim()}\nVisitor: ${customercontroller.text.trim()}\nVisitor number: ${customernumcontroller.text.trim()}\nDate  : $date\nTime : $time\nCompany:${companycontroller.text.trim()}\nReason : $purpose';
      FlutterOpenWhatsapp.sendSingleMessage(
          "+91${phoneNumcontroller.text.trim()}", information);
      blockcontroller.clear();
      doorcontroller.clear();
      customernumcontroller.clear();
      customercontroller.clear();
      purposecontroller.clear();
      phoneNumcontroller.clear();
      companycontroller.clear();
    }
  }

  void share() async {
    final String share1 =
        'DoorStep Security System \n\n\n\n\n Block ID: ${blockcontroller.text.trim()}\nDoor ID: ${doorcontroller.text.trim()}\nVisitor: ${customercontroller.text.trim()}\nVisitor number: ${customernumcontroller.text.trim()},\n Date  : $date, \nTime : $time\nCompany:${companycontroller.text.trim()}\nReason : ${purposecontroller.text}';
    final RenderBox box = context.findRenderObject();
    Share.share(share1,
        subject: 'DoorStep Security Services',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Future<void> logout(BuildContext context) async {
    try {
      final auth = Provider.of<BaseAuth>(context, listen: false);
      auth.signout();
    } catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("LogOut Failed"),
              content: Text("${e.toString()}"),
            );
          });
    }
  }

  Future<void> confirmsignout(BuildContext context) async {
    final didrequest = await PlatformAlertDialog(
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
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text('Details'),
        elevation: 20.0,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
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
      floatingActionButton: new FabMenu(
        menus: menuDataList,
        maskColor: null,
        mainIcon: Icons.menu,
        mainButtonColor: Colors.blueGrey,
        mainButtonBackgroundColor: Colors.tealAccent,
        menuButtonBackgroundColor: Colors.white,
        labelTextColor: Colors.blueAccent,
        labelBackgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: fabMenuLocation,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
              elevation: 5.0,
              color: Color.fromRGBO(64, 75, 96, .9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
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

  List<Widget> _buildformchildren() {
    return [
      TextFormField(
        style: TextStyle(fontSize: 17.0, color: Colors.grey[100]),
        controller: blockcontroller,
        decoration: InputDecoration(
            labelText: 'Block ID',
            icon: Icon(
              Icons.domain,
              color: Colors.grey[500],
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[500],
            )),
        onSaved: (value) => block = value.trim(), //remove trim
      ),
      TextFormField(
        style: TextStyle(fontSize: 17.0, color: Colors.grey[100]),
        controller: doorcontroller,
        decoration: InputDecoration(
            labelText: 'DoorID',
            icon: Icon(Icons.domain, color: Colors.grey[500]),
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.grey[500])),
      ),
      TextFormField(
        style: TextStyle(fontSize: 17.0, color: Colors.grey[100]),
        controller: customercontroller,
        decoration: InputDecoration(
          labelText: 'Visitor',
          icon: Icon(Icons.people, color: Colors.grey[500]),
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[500]),
        ),
        onSaved: (value) => customer = value,
      ),
      TextFormField(
        style: TextStyle(fontSize: 17.0, color: Colors.grey[100]),
        maxLength: 10,
        controller: customernumcontroller,
        decoration: InputDecoration(
          labelText: 'Visitor number',
          icon: Icon(Icons.add_call, color: Colors.grey[500]),
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[500]),
        ),
        onSaved: (value) => number = value,
        keyboardType: TextInputType.phone,
      ),
      TextFormField(
        style: TextStyle(fontSize: 17.0, color: Colors.grey[100]),
        controller: companycontroller,
        decoration: InputDecoration(
          labelText: 'Type',
          icon: Icon(Icons.question_answer, color: Colors.grey[500]),
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[500]),
        ),
        onSaved: (value) => reason = value,
      ),
      TextFormField(
        style: TextStyle(fontSize: 17.0, color: Colors.grey[100]),
        controller: purposecontroller,
        decoration: InputDecoration(
          labelText: 'Reason',
          icon: Icon(Icons.question_answer, color: Colors.grey[500]),
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[500]),
        ),
        onSaved: (value) => reason = value,
      ),
      SizedBox(
        height: 10.0,
      ),
      Text("To :",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 15.0,
            textBaseline: TextBaseline.alphabetic,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto',
          )),
      TextFormField(
        style: TextStyle(fontSize: 17.0, color: Colors.grey[100]),
        maxLength: 10,
        controller: phoneNumcontroller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            labelText: 'Resident Number',
            icon: Icon(Icons.phone_forwarded, color: Colors.grey[500]),
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.grey[500])),
      ),
      OutlineButton.icon(
        icon: Icon(Icons.save, color: Colors.grey[500]),
        onPressed: () => _submit(),
        label: Text(
          'Save',
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 15.0,
          ),
        ),
      ),
    ];
  }
}

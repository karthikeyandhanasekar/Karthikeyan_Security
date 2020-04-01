import 'package:chatting/database/database.dart';
import 'package:chatting/database/model.dart';
import 'package:chatting/platoformalertdialog.dart';
import 'package:chatting/signin/authclass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatting/firestore.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Show extends StatefulWidget {
  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  Future<void> logout(BuildContext context) async {
    try {
      final auth = Provider.of<BaseAuth>(context, listen: false);
      auth.signout();
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 100,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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

  Widget stream() {
    StreamBuilder(
        //
        stream: Firestore.instance
            .collection('Customers')
            .document('C30')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          String customername = userDocument['Customername'];
          String customernumber = userDocument['Customer number'];
          String blockid = userDocument['Block ID'];
          String ddate = userDocument['Date '];
          String ddoorno = userDocument['Door No '];
          String reason = userDocument['Reason'];
          String time = userDocument['Time'];

          String message =
              'DoorStep Security System \n  \nCustomername: $customername ,\nCustomer number: $customernumber,\n Block ID : $blockid,\n  Door No  : $ddoorno, \n Date  : $ddate, \nTime : $time \n Reason: $reason';

          return new Text(message);
        });
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    var count = 0;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Shows'),
          elevation: 20.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.backspace),
                onPressed: () => confirmsignout(context))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Details.show(context),
          child: Icon(Icons.add_alert),
          elevation: 10.0,
        ),
        body: Center(
          child: Text(
            'This space is for upcomming  features',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey[600],
            ),
          ),
        ));
  }

  Widget _buildcontext(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Senddata>>(
        stream: database.readview(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final viewer = snapshot.data;
            final children = viewer
                .map(
                  (datarev) => Card(
                    elevation: 20.0,
                    borderOnForeground: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    color: Colors.white70,
                    child: Text(
                        '   DoorStep Security Service\n\nVisitor: ${datarev.Customername} \nNumber: ${datarev.Customernumber} \nBlock ID: ${datarev.blockid},\nDoor No: ${datarev.doorno} \nDate: ${datarev.date}, \nTime: ${datarev.time},\n Reason: ${datarev.reason}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 15.0,
                          textBaseline: TextBaseline.alphabetic,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto',
                        )),
                  ),
                ).toList();
            return ListView(children: children);
          }
          return Center(child: Text('Loading'));
        });
  }
}

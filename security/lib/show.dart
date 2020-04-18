import 'package:chatting/database/database.dart';
import 'package:chatting/database/model.dart';
import 'package:chatting/platoformalertdialog.dart';
import 'package:chatting/signin/authclass.dart';
import 'package:flutter/material.dart';
import 'package:chatting/firestore.dart';
import 'package:provider/provider.dart';

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
        body: _buildcontext(context)
    );
  }

  Widget _buildcontext(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Senddata>>(                              //display the data
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

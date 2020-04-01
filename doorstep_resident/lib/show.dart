import 'package:doorstep_resident/database/database.dart';
import 'package:doorstep_resident/database/model.dart';
import 'package:doorstep_resident/payment.dart';
import 'package:doorstep_resident/platoformalertdialog.dart';
import 'package:doorstep_resident/signin/authclass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_animations/loading_animations.dart';

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
        title: Text('Visitor List'),
        elevation: 20.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.attach_money),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Payment()))),
          IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () => confirmsignout(context)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildcontext(context),
      ),
    );
  }

  Widget _buildcontext(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Senddata>>(
        stream: database.readview(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final viewer = snapshot.data;
            final children = viewer
                .map((datarev) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                          5.0,
                        )),
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '  DoorStep Security Services \n\n Visitor: ${datarev.Customername}\n Visitor number: ${datarev.Customernumber},\n Block ID: ${datarev.blockid},\n Door No: ${datarev.doorno},\n Date: ${datarev.date}\n Time: ${datarev.time}\n Reason: ${datarev.reason}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              textBaseline: TextBaseline.alphabetic,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList();
            return ListView(children: children);
          }
          return Center(
            child: LoadingBouncingGrid.circle(),
          );
        });
  }
}

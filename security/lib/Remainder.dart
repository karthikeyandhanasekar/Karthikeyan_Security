import 'package:chatting/database/database.dart';
import 'package:chatting/database/model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart'; 

class RemainderDisplay extends StatefulWidget {
  
  final Database database;
  const RemainderDisplay({Key key, @required this.database}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RemainderDisplay(
              database: database,
            )));
  }
  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<RemainderDisplay> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Remainder List'),
        elevation: 20.0,
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
                          child: Text(                                             //here the data retrive from firestore
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
          return Center(                          //Loading screen process
            child: Column(
              children: <Widget>[
                 LoadingBouncingGrid.circle(),             
               Text("Your session has expired, Please  login again",
               textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              textBaseline: TextBaseline.alphabetic,
                              fontWeight: FontWeight.w800,
                            ),
               )
              ],
            )
          );
        });
  }
}
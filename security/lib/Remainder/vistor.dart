import 'package:chatting/database/database.dart';
import 'package:chatting/database/model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class Visitor extends StatefulWidget {
  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Visitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text('Visitor'),
          elevation: 20.0,
        ),
        body: _buildcontext(context));
  }

  Widget _buildcontext(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Visitordata>>(
        //display the data
        stream: database.visitorview(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final viewer = snapshot.data;
            final children = viewer
                .map((datarev) => Card(
                      elevation: 20.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0,
                                            color: Colors.white24))),
                                child: Text(
                                  '${datarev.blockid}\n\n${datarev.doorno}',
                                  style: TextStyle(
                                      color: Colors.tealAccent,
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                              title: Text(
                                '${datarev.Customername} ',
                                style: TextStyle(
                                    color: Colors.grey[100],
                                    fontWeight: null,
                                    fontSize: 20),
                              ),
                              //subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                              subtitle: Row(
                                children: <Widget>[
                                  Icon(Icons.linear_scale,
                                      color: Colors.yellowAccent),
                                  Text('${datarev.uniquecode}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[100],
                                          fontWeight: FontWeight.w800))
                                ],
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.white, size: 30.0),
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                              dialogBackgroundColor:
                                                  Color.fromRGBO(
                                                      64, 75, 96, .9)),
                                          child: AlertDialog(
                                            title: Text(
                                              "Full Details",
                                              style: TextStyle(
                                                  color: Colors.blueGrey[50]),
                                            ),
                                            content: Text(
                                              'BlockID: ${datarev.blockid}\nDoor No: ${datarev.doorno}\n Visitor: ${datarev.Customername}\nArrival: ${datarev.arrival}\n Visitor Number: ${datarev.Customernumber}\n Unique Code: ${datarev.uniquecode}\n Date : ${datarev.date}\n Time : ${datarev.time}',
                                              style: TextStyle(
                                                color: Colors.blueGrey[50],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text("ok"),
                                              )
                                            ],
                                          ),
                                        );
                                      })))),
                    ))
                .toList();
            return ListView(children: children.reversed.toList());
          }
          return Scaffold(body: Center(child: LoadingBouncingGrid.circle()));
        });
  }
}

/*Widget real()
{
   Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: Card(
                      elevation: 5.0,
                      borderOnForeground: false,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.white70,
                      child: Text(
                          'DoorStep Security Service\n\nBlockID: ${datarev.blockid}\nDoor No: ${datarev.doorno}\nVisitor Number: ${datarev.Customernumber}\nVisitor Name: ${datarev.Customername}\nDate: ${datarev.date}\nTime: ${datarev.time}\n Arrival: ${datarev.arrival},\n Unique Code : ${datarev.uniquecode}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto',
                          )),
                    ),
                  ),
}*/

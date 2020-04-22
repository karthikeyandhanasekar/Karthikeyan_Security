import 'package:chatting/database/database.dart';
import 'package:chatting/database/model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';


class Delivery extends StatefulWidget {
  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text(
            "Delivery",
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: _buildcontext(context));
  }

  Widget _buildcontext(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Deliverydata>>(
        //display the data
        stream: database.deliveryview(),
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
                                '${datarev.company} ',
                                style: TextStyle(
                                    color: Colors.grey[100], fontWeight: null),
                              ),
                              //subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                              subtitle: Row(
                                children: <Widget>[
                                  Icon(Icons.linear_scale,
                                      color: Colors.yellowAccent),
                                  Text('${datarev.date}',
                                      style: TextStyle(
                                        fontSize: 12,
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
                                              'BlockID: ${datarev.blockid}\nDoor No: ${datarev.doorno}\nCompany: ${datarev.company}\nArrival: ${datarev.arrival}\nDate: ${datarev.date}\nTime: ${datarev.time}\n',
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
            return ListView(
              children: children.reversed.toList(),
            );
          }

          return Scaffold(body: Center(child: LoadingBouncingGrid.circle()));
        });
  }
}

/*Widget original()
{
  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      color: Colors.white70,
                      child: Text(
                          'DoorStep Security Service\n\nBlockID: ${datarev.blockid}\nDoor No: ${datarev.doorno}\nCompany: ${datarev.company}\nArrival: ${datarev.arrival}\nDate: ${datarev.date}\nTime: ${datarev.time}\n',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            wordSpacing: 2,
                            color: Colors.black,
                            fontSize: 16.0,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto',
                          )),
                    ),
                  ),
                )
                .toList();
            return ListView(children: children.reversed.toList());
}*/

import 'package:flutter/material.dart';

class sample extends StatefulWidget {
  @override
  _sampleState createState() => _sampleState();
}

class _sampleState extends State<sample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text("Sample"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    ),
        body: cardshow(context));
  }

 
Widget cardshow(BuildContext context)

{
  return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Text('Blockid\n\ndoorid', style: TextStyle(color: Colors.white),),
        ),
        title: Text(
          'Visitorname',
          style: TextStyle(color: Colors.white, fontWeight: null),
        ),
        //subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text('Uniquecode', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800))
          ],
        ),
        trailing:
            IconButton(icon : Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0), onPressed: () =>showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Extra Content"),
                    content: Text("Yedhukku!!!!"),
                    actions: <Widget>[
                      FlatButton(onPressed: () => Navigator.of(context).pop() , child: Text("ok"),)
                    ],
                  );
                })
                )
                )
      ),
    );
}
}
/*Widget makeListTile(context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Text('Blockid\n\ndoorid', style: TextStyle(color: Colors.white),),
        ),
        title: Text(
          'Visitorname',
          style: TextStyle(color: Colors.white, fontWeight: null),
        ),
        //subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text('Uniquecode', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800))
          ],
        ),
        trailing:
            IconButton(icon : Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0), onPressed: () =>showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Extra Content"),
                    content: Text("Yedhukku!!!!"),
                    actions: <Widget>[
                      FlatButton(onPressed: () => Navigator.of(context).pop() , child: Text("ok"),)
                    ],
                  );
                })
                )
                );

}*/
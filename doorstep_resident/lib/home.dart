
import 'package:flutter/material.dart';
import 'package:doorstep_resident/show.dart';
import 'package:doorstep_resident/signin/singin.dart';




class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void signinnavigate(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute(builder:(context) =>  Signin())
    );
  }

  void visitornavigate(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute(builder:(context) =>  Show())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],

      appBar: AppBar(
        title: Text('Home'),
        elevation: 20.0,
      ),
      

      body: Padding(
        padding: EdgeInsets.all(10.0),
        

       
        
        child : Center(
          child: Column(children: <Widget>[
            Text('Welcome To Our DoorStep Resident Services',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey[800],
                  fontSize: 24.0,
                  textBaseline: TextBaseline.alphabetic,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(height: 200.0,),



          
          
           SizedBox(
               height: 50,
               width: 125.0,
               child: OutlineButton.icon(onPressed:() =>  signinnavigate(context), icon: Icon(Icons.email), label: Text('Signin'))),
           SizedBox(height: 20.0),

      // OutlineButton.icon(onPressed: () =>  visitornavigate(context) , icon: Icon(Icons.show_chart), label: Text('Visitor'))
       ],),
        )
      
      ),
      
      
    );
  }
}

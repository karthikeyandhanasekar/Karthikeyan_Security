import 'package:flutter/material.dart';


class Senddata {

    Senddata({@required this.id,@required this.blockid,@required this.Customername,@required this.Customernumber,@required this.date,@required this.doorno,@required this.time,@required this.reason});
final String id;
 final String Customername;
 final String Customernumber;
 final String blockid;
 final String doorno;
 final String date;
 final String reason;
 final String time;
 
 // while using factory keyboard constructor doesn't always create a new instance of class

 factory Senddata.fromMap(Map<String, dynamic> data,documentid)
 {
   if(data == null)
   {
     return null;
   }
   final String name = data['Customername'];
   final String  customerno = data['Customer number'];
   final String block = data['Block ID'];
   final String door = data['Door No'];
   final String date= data['Date'];
   final String time = data['Time'];
   final String reason = data['Reason'];

   return Senddata(blockid: block,
   id: documentid, 
   
   Customername: name,
    Customernumber: customerno, 
    date: date,
     doorno: door, 
    time: time,
     reason: reason);
 }

     

 Map<String,dynamic>  toMap() {
   return {
    'Customername': Customername ,
        'Customer number': Customernumber,
        'Block ID' : blockid,
        'Door No' : doorno,
        'Date' : date,
        'Time' : time,
        'Reason' : reason,
   };
 }
 
  

}




/*


    */
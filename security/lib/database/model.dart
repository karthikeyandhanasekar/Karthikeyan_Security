import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Senddata {
  Senddata(
      {@required this.id,
      @required this.blockid,
      @required this.Customername,
      @required this.Customernumber,
      @required this.date,
      @required this.doorno,
      @required this.time,
      @required this.reason});
  final String id;
  final String Customername;
  final String Customernumber;
  final String blockid;
  final String doorno;
  final String date;
  final String reason;
  final String time;

  // while using factory keyboard constructor doesn't always create a new instance of class

  factory Senddata.fromMap(Map<String, dynamic> data, documentid) {
    if (data == null) {
      return null;
    }
    final String name = data['Customername'];
    final String customerno = data['Customer number'];
    final String block = data['Block ID'];
    final String door = data['Door No'];
    final String date = data['Date'];
    final String time = data['Time'];
    final String reason = data['Reason'];

    return Senddata(
        blockid: block,
        id: documentid,
        Customername: name,
        Customernumber: customerno,
        date: date,
        doorno: door,
        time: time,
        reason: reason);
  }

  Map<String, dynamic> toMap() {
    return {
      'Customername': Customername,
      'Customer number': Customernumber,
      'Block ID': blockid,
      'Door No': doorno,
      'Date': date,
      'Time': time,
      'Reason': reason,
    };
  }
}

class Cabdata {
  Cabdata(
      {@required this.id,
      @required this.blockid,
      @required this.drivername,
      @required this.vehicleno,
      @required this.doorno,
      @required this.type,
      @required this.arrival});
  final String id;
  final String drivername;
  final String vehicleno;
  final String blockid;
  final String doorno;
  final String arrival;
  final String type;

  // while using factory keyboard constructor doesn't always create a new instance of class

  factory Cabdata.fromMap(Map<String, dynamic> data, documentid) {
    if (data == null) {
      return null;
    }
    final String name = data['Driver Name'];
    final String vehicleno = data['Vehicle number'];
    final String block = data['Block ID'];
    final String door = data['Door No'];

    final String arrival = data['Excepted Arrival'];
    final String type = data['Company'];

    return Cabdata(
      blockid: block,
      id: documentid,
      drivername : name,
      vehicleno:  vehicleno,
      doorno: door,
      arrival: arrival,
      type: type,
    );
  }
}

class Deliverydata {
  Deliverydata({
    @required this.id,
    @required this.blockid,
    @required this.company,
    @required this.arrival,
    @required this.date,
    @required this.doorno,
    @required this.time,
  });
  final String id;
  final String company;
  final String blockid;
  final String doorno;
  final String date;
  final String arrival;
  final String time;

  // while using factory keyboard constructor doesn't always create a new instance of class

  factory Deliverydata.fromMap(Map<String, dynamic> data, documentid) {
    if (data == null) {
      return null;
    }
    final String company = data['Company'];
    final String block = data['Block ID'];
    final String door = data['Door No'];
    final String date = data['Received Date'];
    final String time = data['Received Time'];
    final String arrival = data['Excepted Arrival'];

    return Deliverydata(
      blockid: block,
      id: documentid,
      company: company,
      arrival: arrival,
      date: date,
      doorno: door,
      time: time,
    );
  }
}

class Visitordata {
  Visitordata(
      {@required this.id,
      @required this.blockid,
      @required this.Customername,
      @required this.Customernumber,
      @required this.date,
      @required this.doorno,
      @required this.time,
      @required this.arrival,
      @required this.uniquecode});
  final String id;
  final String Customername;
  final String Customernumber;
  final String blockid;
  final String doorno;
  final String date;
  final String arrival;
  final String time;
  final String uniquecode;

  // while using factory keyboard constructor doesn't always create a new instance of class

  factory Visitordata.fromMap(Map<String, dynamic> data, documentid) {
    if (data == null) {
      return null;
    }
    final String name = data['Visitor'];
    final String customerno = data['Visitor Number'];
    final String block = data['Block ID'];
    final String door = data['Door No'];
    final String date = data['Received Date'];
    final String time = data['Received Time'];
    final String arrival = data['Excepted Arrival'];
    final String uniquecode = data['Unique code'];

    return Visitordata(
        blockid: block,
        id: documentid,
        Customername: name,
        Customernumber: customerno,
        date: date,
        doorno: door,
        time: time,
        uniquecode: uniquecode,
        arrival: arrival);
  }
}

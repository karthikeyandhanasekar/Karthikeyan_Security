import 'package:upi_india/upi_india.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  GlobalKey bottomNavigationKey = GlobalKey();
  Future _transaction;

  Future<String> initiateTransaction(String app) async {
    UpiIndia upi = new UpiIndia(
      app: app,
      receiverUpiId: 'dkkarthik2000@okaxis',
      receiverName: 'DoorStep',
      transactionRefId: 'TestingId',
      transactionNote: 'DoorStep Maintenance',
      amount: 2.00,
    );

    String response = await upi.startTransaction();

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Payment"),
        elevation: 20.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: StadiumBorder(),
              elevation: 15.0,
              child: Text("GOOGLE PAY",
                  style: TextStyle(
                    color: Colors.blueGrey[100],
                    fontSize: 15.0,
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  )),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _transaction = initiateTransaction(
                  UpiIndiaApps.GooglePay,
                );
                setState(() {});
              },
            ),
            RaisedButton(
              shape: StadiumBorder(),
              elevation: 15.0,
              child: Text("      PAYTM     ",
                  style: TextStyle(
                    color: Colors.blueGrey[100],
                    fontSize: 15.0,
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  )),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _transaction = initiateTransaction(
                  UpiIndiaApps.PayTM,
                );
                setState(() {});
              },
            ),
            RaisedButton(
              shape: StadiumBorder(),
              elevation: 15.0,
              focusColor: Colors.blue,
              child: Text("AMAZON PAY",
                  style: TextStyle(
                    color: Colors.blueGrey[100],
                    fontSize: 15.0,
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  )),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _transaction = initiateTransaction(
                  UpiIndiaApps.AmazonPay,
                );
                setState(() {});
              },
            ),
            FutureBuilder(
                future: _transaction,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null)
                    return Text('');
                  else {
                    switch (snapshot.data.toString()) {
                      case UpiIndiaResponseError.APP_NOT_INSTALLED:
                        return Text('App not installed.',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontSize: 30.0,
                              textBaseline: TextBaseline.alphabetic,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                            ));
                        break;
                      case UpiIndiaResponseError.INVALID_PARAMETERS:
                        return Text(
                          'App is unable to handle request.',
                        );
                        break;
                      case UpiIndiaResponseError.USER_CANCELLED:
                        return Text(
                            'It seems like you cancelled the transaction.',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontSize: 30.0,
                              textBaseline: TextBaseline.alphabetic,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                            ));
                        break;
                      case UpiIndiaResponseError.NULL_RESPONSE:
                        return Text('No data received',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontSize: 30.0,
                              textBaseline: TextBaseline.alphabetic,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                            ));
                        break;
                      default:
                        UpiIndiaResponse _upiResponse;
                        _upiResponse = UpiIndiaResponse(snapshot.data);
                        String status = _upiResponse.status;
                        return Column(
                          children: <Widget>[
                            Text(
                              'Status: $status',
                              style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: 30.0,
                                textBaseline: TextBaseline.alphabetic,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        );
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}

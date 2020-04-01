import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'plattformwidget.dart';

class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog(
      {@required this.cancelactiontext,
      @required this.title,
      @required this.content,
      @required this.defaultactiontext})
      : assert(title != null),
        assert(content != null),
        assert(defaultactiontext != null);

  final String title;
  final String content;
  final String defaultactiontext;
  final String cancelactiontext;

  Future<bool> show(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => this,
      barrierDismissible: true,
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    // TODO: implement buildCupertinoWidget
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildaction(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildaction(context),
    );
  }

  List<Widget> _buildaction(BuildContext context) {
    final action = <Widget>[];
    if (cancelactiontext != null) {
      action.add(PlatformAlertDialogAction(
        child: Text(cancelactiontext),
        onPressed: () => Navigator.of(context).pop(false),
      ));
    }
    action.add(PlatformAlertDialogAction(
      onPressed: () => Navigator.of(context).pop(true),
      child: Text(defaultactiontext),
    ));
    return action;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({this.child, this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}

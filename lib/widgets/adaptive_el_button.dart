import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveElButton extends StatelessWidget {
  final Function handler;
  AdaptiveElButton(this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              'Add Transaction',
              style: TextStyle(
                fontFamily: 'OpenSans',
              ),
            ),
            onPressed: handler,
          )
        : ElevatedButton(
            onPressed: () => handler,
            child: Text(
              'Add Transaction',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          );
  }
}

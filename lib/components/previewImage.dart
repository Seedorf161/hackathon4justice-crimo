import 'dart:io';
import 'package:crimo/misc/functions.dart';
import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  final String attachmentLocalPath;
  final int date;
  ViewImage({
    @required this.attachmentLocalPath,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Platform.isIOS
                            ? Icons.arrow_back_ios
                            : Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Container(
                      child: Text(
                        Functions().timeAgo(
                          DateTime.fromMillisecondsSinceEpoch(
                            date,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.center,
                  child: File(attachmentLocalPath).existsSync()
                      ? Image.file(
                          File(attachmentLocalPath),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/logo.gif",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

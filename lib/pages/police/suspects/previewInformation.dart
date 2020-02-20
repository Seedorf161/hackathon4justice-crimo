import 'package:crimo/components/suspectDetailsWidget.dart';
import 'package:crimo/misc/color.dart';
import 'package:crimo/model/user/suspectAccount.dart';
import 'package:crimo/pages/police/suspects/submitCase.dart';
import 'package:flutter/material.dart';

class PreviewInformation extends StatelessWidget {
  final SuspectAccount suspectAccount;
  final String currentUserID;
  PreviewInformation({@required this.suspectAccount, @required this.currentUserID});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Preview case #${suspectAccount.caseNumber}",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: <Widget>[
          SuspectDetailsWidget(
            suspectAccount: suspectAccount,
          ),
          GestureDetector(
            onTap: () => print("Hey"),
            child: Container(
              width: screenSize.width * 50,
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                "Edit",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  letterSpacing: -0.141,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SubmitCase(
                  suspectAccount: suspectAccount,
                  currentUserID: currentUserID,
                ),
              ),
            ),
            child: Container(
              width: screenSize.width * 50,
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              margin: EdgeInsets.only(bottom: 40, left: 10, right: 10),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                "Proceed",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  letterSpacing: -0.141,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:crimo/components/suspectDetailsWidget.dart';
import 'package:crimo/misc/color.dart';
import 'package:crimo/misc/data.dart';
import 'package:crimo/model/user/suspectAccount.dart';
import 'package:flutter/material.dart';

class CaseInformation extends StatelessWidget {
  final SuspectAccount suspectAccount;
  CaseInformation({@required this.suspectAccount});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Map<String, String> thisCaseCourt = Data()
        .courtHouses
        .firstWhere((each) => each["id"] == suspectAccount.courtHouseID);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Case #${suspectAccount.caseNumber}",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: <Widget>[
          SuspectDetailsWidget(
            suspectAccount: suspectAccount,
          ),
          Container(
            child: Text(
              "CHARGED TO:   ",
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              thisCaseCourt["name"].toUpperCase(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Judge Assigned:   ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: suspectAccount.assignedJudge ?? "Not assigned yet",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Lato",
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Trial Date:   ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: suspectAccount.trialDate ?? "Not assigned yet",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Lato",
                ),
              ),
            ),
          ),
          if (suspectAccount.assignedJudge == null &&
              suspectAccount.trialDate == null)
            GestureDetector(
              onTap: () => print("Hey"),
              child: Container(
                width: screenSize.width * 50,
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  "Send Reminder",
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

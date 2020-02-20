import 'package:crimo/components/assignLawyerBS.dart';
import 'package:crimo/components/suspectDetailsWidget.dart';
import 'package:crimo/misc/color.dart';
import 'package:crimo/misc/data.dart';
import 'package:crimo/model/user/suspectAccount.dart';
import 'package:flutter/material.dart';

class CourtCaseInformation extends StatefulWidget {
  final SuspectAccount suspectAccount;
  CourtCaseInformation({@required this.suspectAccount});
  @override
  _CourtCaseInformationState createState() => _CourtCaseInformationState();
}

class _CourtCaseInformationState extends State<CourtCaseInformation> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isBSShown = false;

  Future<bool> _willPop() async {
    bool res = true;
    if (isBSShown) {
      res = false;
      Navigator.of(context).pop();
      setState(() {
        isBSShown = false;
      });
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Map<String, String> thisCaseStation = Data()
        .policeStations
        .firstWhere((each) => each["id"] == widget.suspectAccount.stationID);
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Case #${widget.suspectAccount.caseNumber}",
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
              suspectAccount: widget.suspectAccount,
            ),
            Container(
              child: Text(
                "SUBMITTED BY:   ",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                thisCaseStation["name"].toUpperCase(),
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
                      text: widget.suspectAccount.assignedJudge ??
                          "Not assigned yet",
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
                      text:
                          widget.suspectAccount.trialDate ?? "Not assigned yet",
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
            if (widget.suspectAccount.assignedJudge == null &&
                widget.suspectAccount.trialDate == null)
              GestureDetector(
                onTap: () => _scaffoldKey.currentState
                    .showBottomSheet(
                      (BuildContext context) {
                        return UpdateCaseBottomSheet(
                          suspectAccount: widget.suspectAccount,
                        ); 
                      },
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                    )
                    .closed
                    .whenComplete(() => setState(() => isBSShown = false)),
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
                    "Update Case",
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
      ),
    );
  }
}

import 'dart:convert';

import 'package:crimo/misc/color.dart';
import 'package:crimo/misc/data.dart';
import 'package:crimo/misc/strings.dart';
import 'package:crimo/model/user/suspectAccount.dart';
import 'package:crimo/pages/police/suspects/allCases.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmitCase extends StatefulWidget {
  final SuspectAccount suspectAccount;
  final String currentUserID;
  SubmitCase({@required this.suspectAccount, @required this.currentUserID});
  @override
  _SubmitCaseState createState() => _SubmitCaseState();
}

class _SubmitCaseState extends State<SubmitCase> {
  _handleSubmitted() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      var listOfCases =
          jsonDecode(prefs.getString(Strings.caseSP) ?? '{"data": []}');
      widget.suspectAccount.caseSubmittedOn =
          DateTime.now().millisecondsSinceEpoch;

      List listOfData = listOfCases["data"];

      String encodeData = jsonEncode(widget.suspectAccount.toJson());
      // print(encodeData);

      listOfData.add(encodeData);

      prefs.setString(Strings.caseSP, jsonEncode({"data": listOfData}));
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AllCases(
            type: "Pending Cases",
            which: 1,
            currentUserID: widget.currentUserID,
          ),
        ),
      );
    } catch (e) {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Submit case #${widget.suspectAccount.caseNumber}",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: <Widget>[
          SizedBox(
            height: screenSize.height * 0.30,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            width: screenSize.width,
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.primaryColor, width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onChanged: (dynamic val) {
                    setState(() {
                      widget.suspectAccount.courtHouseID = val.toString();
                    });
                  },
                  value: widget.suspectAccount.courtHouseID,
                  hint: Text(
                    "Select Nearest Court",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  items: Data().courtHouses.map((Map<String, String> value) {
                    return DropdownMenuItem<String>(
                      value: value["id"],
                      child: Text(
                        value["name"],
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _handleSubmitted,
            child: Container(
              width: screenSize.width * 50,
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              margin: EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                "Charge to court",
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

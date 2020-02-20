import 'dart:convert';

import 'package:crimo/components/caseWidget.dart';
import 'package:crimo/misc/color.dart';
import 'package:crimo/misc/strings.dart';
import 'package:crimo/model/user/suspectAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllCases extends StatefulWidget {
  final String type;
  final int which;
  final String currentUserID;
  AllCases({@required this.type, @required this.which, @required this.currentUserID});

  @override
  _AllCasesState createState() => _AllCasesState();
}

class _AllCasesState extends State<AllCases> {
  List<SuspectAccount> allCases = [];
  bool isLoading = true; 

  @override
  void initState() {
    fetchCases();
    super.initState();
  }

  fetchCases() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String listOfCases = prefs.getString(Strings.caseSP) ?? '{"data": []}';
      var listOfCasesToMap = jsonDecode(listOfCases);

      List<SuspectAccount> tempList = [];
      List.from(listOfCasesToMap["data"]).forEach((each) {
        var eachData = jsonDecode(each);
        SuspectAccount eachDataObject = SuspectAccount.fromJSON(eachData);
        print("${eachDataObject.isCaseCompleted} == ${widget.which}");
        print("${eachDataObject.stationID} == ${widget.currentUserID}");
        if (eachDataObject.stationID == widget.currentUserID && eachDataObject.isCaseCompleted == widget.which) {
          tempList.add(eachDataObject);
        }
      });
      setState(() {
        allCases = tempList.reversed.toList();
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.type,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
          ),
        ),
      ), 
      body: isLoading
          ? Center(
              child: SpinKitFadingCircle(
                color: MyColors.primaryColor,
                size: 50.0,
              ),
            )
          : allCases.length > 0 ? ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: allCases
                  .map(
                    (each) => CaseWidget(
                      suspectAccount: each,
                    ),
                  )
                  .toList(),
            ) : Center(
              child: Text("No ${widget.type}"),
            ),
    );
  }
}

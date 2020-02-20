import 'package:crimo/misc/color.dart';
import 'package:crimo/misc/data.dart';
import 'package:crimo/model/user/suspectAccount.dart';
import 'package:crimo/pages/account/loginPage.dart';
import 'package:crimo/pages/police/suspects/profileSuspects.dart';
import 'package:crimo/pages/police/suspects/submittedCases.dart';
import 'package:flutter/material.dart';

class PoliceDashboard extends StatelessWidget {
  final String id;
  PoliceDashboard({@required this.id});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String stationName = Data().policeStations.firstWhere(
        (each) => each["id"] == id,
        orElse: () => {"name": null})["name"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            tooltip: "Log out",
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => LoginPage(),
              ),
              (Route route) => false,
            ),
          )
        ],
        title: Text(
          stationName ?? "Police Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileSuspect(
                  currentUserID: id,
                  preSuspectAccount: SuspectAccount(
                    fullName: "Mari Mad",
                    address: "Block 3D, Allen Ave, Ikeja, Lagos",
                    caseSection: "Anti-Robbery",
                    caseNumber: "AR-35526BSG",
                  ),
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: screenSize.width * 80,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0, 0),
                    blurRadius: 13,
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: screenSize.width * 80,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                        child: Image.asset(
                          "assets/images/profile.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "PROFILE A SUSPECT",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SubmittedCases(
                  id: id,
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: screenSize.width * 80,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0, 0),
                    blurRadius: 13,
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: screenSize.width * 80,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                        child: Image.asset(
                          "assets/images/tra.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "MANAGE FILED CASES",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

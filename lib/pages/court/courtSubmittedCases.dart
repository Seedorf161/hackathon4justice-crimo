import 'package:crimo/pages/court/allCases.dart';
import 'package:flutter/material.dart';

class CourtSubmittedCases extends StatelessWidget {
  final String id;
  CourtSubmittedCases({@required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cases Submitted",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20),
          children: <Widget>[
            ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CourtCases(
                    type: "Pending Cases",
                    which: 1,
                    currentUserID: id,
                  ),
                ),
              ),
              title: Text(
                "Pending Cases",
                style: TextStyle(
                  color: Color.fromARGB(255, 75, 74, 75),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CourtCases(
                    type: "Approved Cases",
                    currentUserID: id,
                    which: 2,
                  ),
                ),
              ),
              title: Text(
                "Approved Cases",
                style: TextStyle(
                  color: Color.fromARGB(255, 75, 74, 75),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CourtCases(
                    type: "Completed Cases",
                    currentUserID: id,
                    which: 3,
                  ),
                ),
              ),
              title: Text(
                "Completed Cases",
                style: TextStyle(
                  color: Color.fromARGB(255, 75, 74, 75),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:crimo/pages/police/suspects/allCases.dart';
import 'package:flutter/material.dart';

class SubmittedCases extends StatelessWidget {
  final String id;
  SubmittedCases({@required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cases Filed",
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
                  builder: (context) => AllCases(
                    type: "Pending Cases",
                    currentUserID: id,
                    which: 1,
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
                  builder: (context) => AllCases(
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
                  builder: (context) => AllCases(
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
            ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AllCases(
                    type: "Transferred Cases",
                    currentUserID: id,
                    which: 0,
                  ),
                ),
              ),
              title: Text(
                "Transferred Cases",
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

import 'dart:io';

import 'package:crimo/components/previewImage.dart';
import 'package:crimo/model/user/suspectAccount.dart';
import 'package:flutter/material.dart';

class SuspectDetailsWidget extends StatelessWidget {
  final SuspectAccount suspectAccount;
  SuspectDetailsWidget({@required this.suspectAccount});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 40),
              height: 160,
              width: 160,
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(100),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    suspectAccount.mugshot != null
                        ? Container(
                            child: Image.file(
                              File(suspectAccount.mugshot),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 60,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 13,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Suspect's Full name:",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
                Text(
                  suspectAccount.fullName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 13,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Address:",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
                Text(
                  suspectAccount.address,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 13,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Date of Birth:",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
                Text(
                  "${suspectAccount.birthdayDay}/${suspectAccount.birthdayMonth}/${suspectAccount.birthdayYear}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 13,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Arrested On:",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
                Text(
                  "${suspectAccount.arrestedDay}/${suspectAccount.arrestedMonth}/${suspectAccount.arrestedYear}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 13,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Case Section:",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
                Text(
                  suspectAccount.caseSection,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 13,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Case Number:",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
                Text(
                  suspectAccount.caseNumber,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 13,
              bottom: 5,
            ),
            child: Text(
              "Officers in Charge:",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),
          ),
          for (int i = 0; i < suspectAccount.officersInCharge.length; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Lato",
                  ),
                  children: [
                    TextSpan(
                      text: "${i + 1}.   ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: suspectAccount.officersInCharge[i],
                    ),
                  ],
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.only(
              top: 13,
              bottom: 5,
            ),
            child: Text(
              "Offenses:",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),
          ),
          for (int i = 0; i < suspectAccount.offences.length; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Lato",
                  ),
                  children: [
                    TextSpan(
                      text: "${i + 1}.   ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: suspectAccount.offences[i],
                    ),
                  ],
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.only(
              top: 13,
              bottom: 5,
            ),
            child: Text(
              "Proofs:",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 10,
                    children: <Widget>[
                      for (int i = 0; i < suspectAccount.proofs.length; i++)
                        GestureDetector(
                          onTap: () async {},
                          child: !File(suspectAccount.proofs[i]).existsSync()
                              ? Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: Icon(
                                      Icons.account_circle,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey[400],
                                      width: 1.5,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewImage(
                                        attachmentLocalPath:
                                            suspectAccount.proofs[i],
                                        date: suspectAccount.caseSubmittedOn,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          File(
                                            suspectAccount.proofs[i],
                                          ),
                                        ),
                                      ),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey[400],
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:crimo/misc/functions.dart';
import 'package:crimo/model/user/suspectAccount.dart';
import 'package:crimo/pages/police/suspects/caseInformation.dart';
import 'package:flutter/material.dart';

class CaseWidget extends StatelessWidget {
  final SuspectAccount suspectAccount;
  CaseWidget({@required this.suspectAccount});

  @override
  Widget build(BuildContext context) {
    // print(suspectAccount.toJson());
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CaseInformation(
            suspectAccount: suspectAccount,
          ),
        ),
      ),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(
                                  suspectAccount.mugshot,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: Text(
                                  suspectAccount.fullName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: "Lato",
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "#" + suspectAccount.caseNumber,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "   ||   ",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${suspectAccount.arrestedDay}/${suspectAccount.arrestedMonth}/${suspectAccount.arrestedYear}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
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
                  ),
                  Container(
                    child: Text(
                      Functions().timeAgoShort(
                        DateTime.fromMillisecondsSinceEpoch(
                            suspectAccount.caseSubmittedOn),
                      ),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

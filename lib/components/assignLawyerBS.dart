import 'package:crimo/components/input/inputBox.dart';
import 'package:crimo/misc/color.dart';
import 'package:crimo/misc/data.dart';
import 'package:crimo/model/user/suspectAccount.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateCaseBottomSheet extends StatefulWidget {
  final SuspectAccount suspectAccount;
  UpdateCaseBottomSheet({@required this.suspectAccount});

  @override
  _UpdateCaseBottomSheetState createState() => _UpdateCaseBottomSheetState();
}

class _UpdateCaseBottomSheetState extends State<UpdateCaseBottomSheet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  DateTime pickedDateTime;

  String selectedChoice;
  String selectedHighCourt;

  _handleSubmitted() async {}

  _pickDateTime() async {
    try {
      DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(DateTime.now().year + 20),
      );
      TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
      );
      if (pickedDate != null && pickedTime != null) {
        setState(() {
          pickedDateTime = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, pickedTime.hour, pickedTime.minute);
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<String> judgesInThisCourt = Data().judges.firstWhere((each) =>
        each["courtHouse"] == widget.suspectAccount.courtHouseID)["judges"];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      height: 380,
      child: Form(
        autovalidate: autoValidate,
        key: formKey,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyColors.primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              padding: EdgeInsets.all(8),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: MyColors.primaryColor,
                      size: 30,
                    ),
                    onChanged: (String val) {
                      setState(() {
                        selectedChoice = val;
                      });
                    },
                    value: selectedChoice,
                    hint: Text(
                      "Update Case",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    items:
                        ["Assign Judge", "Transfer Case"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
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
            if (selectedChoice == "Assign Judge")
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: MyColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: MyColors.primaryColor,
                            size: 30,
                          ),
                          onChanged: (String val) {
                            setState(() {
                              widget.suspectAccount.assignedJudge = val;
                            });
                          },
                          value: widget.suspectAccount.assignedJudge,
                          hint: Text(
                            "Select Judge",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          items: judgesInThisCourt.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
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
                    onTap: _pickDateTime,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      width: screenSize.width,
                      child: Text(
                        pickedDateTime == null
                            ? "Pick Trial Date"
                            : "${DateFormat.yMMMd("en_US").add_jms().format(pickedDateTime)}",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (selectedChoice == "Transfer Case")
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.all(8),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: MyColors.primaryColor,
                        size: 30,
                      ),
                      onChanged: (String val) {
                        setState(() {
                          selectedHighCourt = val;
                        });
                      },
                      value: selectedHighCourt,
                      hint: Text(
                        "Select High Court",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      items: Data()
                          .highCourtHouses
                          .map((Map<String, String> value) {
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
                width: screenSize.width,
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  "Update",
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

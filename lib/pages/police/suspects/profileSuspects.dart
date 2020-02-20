import 'dart:io';
import 'package:crimo/components/imagePickerOptionsWidget.dart';
import 'package:crimo/components/input/inputBox.dart';
import 'package:crimo/misc/color.dart';
import 'package:crimo/model/user/suspectAccount.dart';
import 'package:crimo/pages/police/suspects/previewInformation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSuspect extends StatefulWidget {
  final String currentUserID;
  final SuspectAccount preSuspectAccount;
  ProfileSuspect({@required this.currentUserID, this.preSuspectAccount}); 

  @override
  _ProfileSuspectState createState() => _ProfileSuspectState();
}

class _ProfileSuspectState extends State<ProfileSuspect> {
  List<String> pickedProofImages = ["null"];
  bool isBSShown = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SuspectAccount suspectAccount = SuspectAccount();

  List<String> days = [];
  List<Map<String, String>> months = [
    {
      "name": "January",
      "num": "01",
    },
    {
      "name": "February",
      "num": "02",
    },
    {
      "name": "March",
      "num": "03",
    },
    {
      "name": "April",
      "num": "04",
    },
    {
      "name": "May",
      "num": "05",
    },
    {
      "name": "June",
      "num": "06",
    },
    {
      "name": "July",
      "num": "07",
    },
    {
      "name": "August",
      "num": "08",
    },
    {
      "name": "September",
      "num": "09",
    },
    {
      "name": "October",
      "num": "10",
    },
    {
      "name": "November",
      "num": "11",
    },
    {
      "name": "December",
      "num": "12",
    }
  ];
  List<String> years = [];

  FocusNode nameFN = FocusNode();
  FocusNode addressFN = FocusNode();
  FocusNode dobFN = FocusNode();

  FocusNode caseSectionFN = FocusNode();
  FocusNode dateArrestedFN = FocusNode();

  List<FocusNode> offencesFN = <FocusNode>[];
  List<TextEditingController> offencesTEC = <TextEditingController>[];

  List<FocusNode> officersInChargeFN = <FocusNode>[];
  List<TextEditingController> officersInChargeTEC = <TextEditingController>[];

  List<FocusNode> proofsFN = <FocusNode>[];
  List<TextEditingController> proofsTEC = <TextEditingController>[];

  FocusNode caseNoFN = FocusNode();

  File _image;

  bool autoValidate = false;
  bool isImageUploading = false;

  @override
  void initState() {
    offencesTEC.add(TextEditingController());
    suspectAccount.offences = ["null"];
    offencesFN.add(FocusNode());

    officersInChargeTEC.add(TextEditingController());
    suspectAccount.officersInCharge = ["null"];
    officersInChargeFN.add(FocusNode());

    loadDate();
    loadYear();
    super.initState();
  }

  @override
  void dispose() {
    for (TextEditingController imageTEC in offencesTEC) {
      imageTEC.dispose();
    }
    for (FocusNode imageFN in offencesFN) {
      imageFN.dispose();
    }

    for (TextEditingController officerInChargeTEC in officersInChargeTEC) {
      officerInChargeTEC.dispose();
    }
    for (FocusNode officerInChargeFN in officersInChargeFN) {
      officerInChargeFN.dispose();
    }
    super.dispose();
  }

  loadDate() {
    for (int i = 1; i < 32; i++) {
      if (i < 10) {
        days.add("0$i");
      } else {
        days.add("$i");
      }
    }
  }

  loadYear() {
    for (int i = 1950; i < DateTime.now().year + 1; i++) {
      years.add("$i");
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future<String> selectImage() async {
    String imagePath;
    File pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imagePath = pickedImage.path;
    }
    return imagePath;
  }

  _handleSubmitted() async {
    FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true;
      Navigator.pop(context);
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      pickedProofImages.removeWhere((val) => val == "null");
      suspectAccount.proofs = pickedProofImages;

      suspectAccount.birthdayDay = suspectAccount.birthdayDay ?? "01";
      suspectAccount.birthdayMonth = suspectAccount.birthdayMonth ?? "01";
      suspectAccount.birthdayYear =
          suspectAccount.birthdayYear ?? (DateTime.now().year - 10).toString();

      suspectAccount.arrestedDay = suspectAccount.arrestedDay ?? "01";
      suspectAccount.arrestedMonth = suspectAccount.arrestedMonth ?? "01";
      suspectAccount.arrestedYear =
          suspectAccount.arrestedYear ?? (DateTime.now().year - 10).toString();
          
      suspectAccount.stationID = widget.currentUserID;

      suspectAccount.isCaseCompleted = 1;

      suspectAccount.caseSubmittedOn = DateTime.now().millisecondsSinceEpoch;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PreviewInformation(
            suspectAccount: suspectAccount,
            currentUserID: widget.currentUserID,
          ),
        ),
      );
    }
  } 

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

    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Profile A Suspect",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 17,
            ),
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Form(
              key: formKey,
              autovalidate: autoValidate,
              child: Column(
                children: [
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
                            _image != null
                                ? Container(
                                    child: Image.file(
                                      _image,
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
                            if (isImageUploading)
                              CircularProgressIndicator(
                                strokeWidth: 8,
                              ),
                            if (!isImageUploading)
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  color:
                                      MyColors.primaryColor.withOpacity(0.80),
                                  width: 160,
                                  height: 50,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => _scaffoldKey.currentState
                                        .showBottomSheet(
                                          (BuildContext context) {
                                            return ImagePickerOptionsWidget(
                                              onCameraClick: () => print("Hey"),
                                              onGalleryClick: () async {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  isBSShown = false;
                                                });
                                                try {
                                                  String pickedImagePath =
                                                      await selectImage();
                                                  if (pickedImagePath != null) {
                                                    setState(() {
                                                      _image =
                                                          File(pickedImagePath);
                                                      suspectAccount.mugshot =
                                                          pickedImagePath;
                                                    });
                                                  }
                                                } catch (e) {
                                                  print(e.message);
                                                }
                                              },
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
                                        .whenComplete(() =>
                                            setState(() => isBSShown = false)),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: InputBox(
                      bottomMargin: 15,
                      labelText: "Full Name",
                      initialValue: widget.preSuspectAccount != null ? widget.preSuspectAccount.fullName : '',
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: nameFN,
                      nextFocusNode: addressFN,
                      onSaved: (String val) {
                        suspectAccount.fullName = val;
                      },
                    ),
                  ),
                  Container(
                    child: InputBox(
                      bottomMargin: 15,
                      labelText: "Address",
                      textInputType: TextInputType.text,
                      initialValue: widget.preSuspectAccount != null ? widget.preSuspectAccount.address : '',
                      textInputAction: TextInputAction.next,
                      focusNode: addressFN,
                      nextFocusNode: offencesFN.first,
                      onSaved: (String val) {
                        suspectAccount.address = val;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 8,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text("Date of Birth"),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 10,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyColors.primaryColor, width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                padding: EdgeInsets.all(6),
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
                                          suspectAccount.birthdayDay = val;
                                        });
                                      },
                                      value: suspectAccount.birthdayDay == null
                                          ? "01"
                                          : suspectAccount.birthdayDay,
                                      items: days.map((String value) {
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
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyColors.primaryColor, width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                padding: EdgeInsets.all(6),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: MyColors.primaryColor,
                                      size: 30,
                                    ),
                                    onChanged: (String val) {
                                      setState(() {
                                        suspectAccount.birthdayMonth = val;
                                      });
                                    },
                                    value: suspectAccount.birthdayMonth == null
                                        ? "01"
                                        : suspectAccount.birthdayMonth,
                                    items: months.map((Map value) {
                                      return DropdownMenuItem<String>(
                                        value: value["num"],
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
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyColors.primaryColor, width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                padding: EdgeInsets.all(6),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: MyColors.primaryColor,
                                      size: 30,
                                    ),
                                    onChanged: (String val) {
                                      setState(() {
                                        suspectAccount.birthdayYear = val;
                                      });
                                    },
                                    value: suspectAccount.birthdayYear == null
                                        ? DateTime.now().year.toString()
                                        : suspectAccount.birthdayYear,
                                    items: years.map((String value) {
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (int i = 0; i < offencesTEC.length; i++)
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              child: InputBox(
                                controller: offencesTEC[i],
                                bottomMargin:
                                    i == offencesTEC.length - 1 ? 30 : 15,
                                focusNode: offencesFN[i],
                                nextFocusNode: i == offencesFN.length - 1
                                    ? caseSectionFN
                                    : offencesFN[i + 1],
                                labelText: "Offence ${i + 1}",
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onSaved: (String val) {
                                  suspectAccount.offences[i] = val;
                                },
                              ),
                            ),
                          ),
                          i == 0
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: IconButton(
                                    onPressed: () {
                                      List<String> tempList = List<String>.from(
                                          suspectAccount.offences);
                                      tempList.add("null");
                                      setState(
                                        () {
                                          suspectAccount.offences = tempList;
                                          offencesTEC
                                              .add(TextEditingController());
                                          offencesFN.add(FocusNode());
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      size: 30,
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: IconButton(
                                    onPressed: () {
                                      List<String> tempList = List<String>.from(
                                          suspectAccount.offences);
                                      tempList.removeAt(i);
                                      setState(() {
                                        suspectAccount.offences = tempList;
                                        offencesTEC.remove(
                                          offencesTEC[i],
                                        );
                                        offencesFN.remove(
                                          offencesFN[i],
                                        );
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      size: 30,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 8,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text("Date Arrested"),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 10,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyColors.primaryColor, width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                padding: EdgeInsets.all(6),
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
                                          suspectAccount.arrestedDay = val;
                                        });
                                      },
                                      value: suspectAccount.arrestedDay == null
                                          ? "01"
                                          : suspectAccount.arrestedDay,
                                      items: days.map((String value) {
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
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyColors.primaryColor, width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                padding: EdgeInsets.all(6),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: MyColors.primaryColor,
                                      size: 30,
                                    ),
                                    onChanged: (String val) {
                                      setState(() {
                                        suspectAccount.arrestedMonth = val;
                                      });
                                    },
                                    value: suspectAccount.arrestedMonth == null
                                        ? "01"
                                        : suspectAccount.arrestedMonth,
                                    items: months.map((Map value) {
                                      return DropdownMenuItem<String>(
                                        value: value["num"],
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
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyColors.primaryColor, width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                padding: EdgeInsets.all(6),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: MyColors.primaryColor,
                                      size: 30,
                                    ),
                                    onChanged: (String val) {
                                      setState(() {
                                        suspectAccount.arrestedYear = val;
                                      });
                                    },
                                    value: suspectAccount.arrestedYear == null
                                        ? DateTime.now().year.toString()
                                        : suspectAccount.arrestedYear,
                                    items: years.map((String value) {
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: InputBox(
                      bottomMargin: 15,
                      labelText: "Case Section",
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      initialValue: widget.preSuspectAccount != null ? widget.preSuspectAccount.caseSection : '',
                      focusNode: caseSectionFN,
                      nextFocusNode: caseNoFN,
                      onSaved: (String val) {
                        suspectAccount.caseSection = val;
                      },
                    ),
                  ),
                  Container(
                    child: InputBox(
                      bottomMargin: 15,
                      labelText: "Case Number",
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      initialValue: widget.preSuspectAccount != null ? widget.preSuspectAccount.caseNumber : '',
                      focusNode: caseNoFN,
                      nextFocusNode: officersInChargeFN.first,
                      onSaved: (String val) {
                        suspectAccount.caseNumber = val;
                      },
                    ),
                  ),
                  for (int i = 0; i < officersInChargeTEC.length; i++)
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              child: InputBox(
                                controller: officersInChargeTEC[i],
                                bottomMargin:
                                    i == officersInChargeTEC.length - 1
                                        ? 30
                                        : 15,
                                focusNode: officersInChargeFN[i],
                                nextFocusNode:
                                    i == officersInChargeFN.length - 1
                                        ? caseSectionFN
                                        : officersInChargeFN[i + 1],
                                labelText: "Officer in Charge - ${i + 1}",
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onSaved: (String val) {
                                  suspectAccount.officersInCharge[i] = val;
                                },
                              ),
                            ),
                          ),
                          i == 0
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: IconButton(
                                    onPressed: () {
                                      List<String> tempList = List<String>.from(
                                          suspectAccount.officersInCharge);
                                      tempList.add("null");
                                      setState(
                                        () {
                                          suspectAccount.officersInCharge =
                                              tempList;
                                          officersInChargeTEC
                                              .add(TextEditingController());
                                          officersInChargeFN.add(FocusNode());
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      size: 30,
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: IconButton(
                                    onPressed: () {
                                      List<String> tempList = List<String>.from(
                                          suspectAccount.officersInCharge);
                                      tempList.removeAt(i);
                                      setState(() {
                                        suspectAccount.officersInCharge =
                                            tempList;
                                        officersInChargeTEC.remove(
                                          officersInChargeTEC[i],
                                        );
                                        officersInChargeFN.remove(
                                          officersInChargeFN[i],
                                        );
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      size: 30,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 8,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text("Proofs"),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            runSpacing: 10,
                            children: <Widget>[
                              for (int i = 0; i < pickedProofImages.length; i++)
                                GestureDetector(
                                  onTap: () => _scaffoldKey.currentState
                                      .showBottomSheet(
                                        (BuildContext context) {
                                          return ImagePickerOptionsWidget(
                                            onCameraClick: () => print("Hey"),
                                            onGalleryClick: () async {
                                              try {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  isBSShown = false;
                                                });
                                                String pickedImagePath =
                                                    await selectImage();
                                                if (pickedImagePath != null) {
                                                  setState(() {
                                                    pickedProofImages[i] =
                                                        pickedImagePath;
                                                    pickedProofImages
                                                        .add("null");
                                                  });
                                                }
                                              } catch (e) {
                                                print(e.message);
                                              }
                                            },
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
                                      .whenComplete(() =>
                                          setState(() => isBSShown = false)),
                                  child: pickedProofImages[i] == "null"
                                      ? Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: 100,
                                          width: 100,
                                          child: Center(
                                            child: Icon(
                                              Icons.camera_alt,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.grey[400],
                                              width: 1.5,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(
                                                  pickedProofImages[i],
                                                ),
                                              ),
                                            ),
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.grey[400],
                                              width: 1.5,
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
                  GestureDetector(
                    onTap: _handleSubmitted,
                    child: Container(
                      width: screenSize.width * 80,
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        "Preview",
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
          ),
        ),
      ),
    );
  }
}

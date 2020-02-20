import 'package:crimo/components/input/inputBox.dart';
import 'package:crimo/misc/color.dart';
import 'package:crimo/misc/strings.dart';
import 'package:crimo/model/user/adminAccount.dart';
import 'package:crimo/pages/court/dashboard.dart';
import 'package:crimo/pages/police/dashboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  final String from;
  LoginPage({this.from});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool autoValidate = false;
  bool obscureText = true;

  List<String> loginOptions = ["Law Enforcement", "Courthouse"];

  FocusNode stationFN = FocusNode();
  FocusNode passFN = FocusNode();

  AdminAccount adminAccount = AdminAccount();

  @override
  void initState() {
    super.initState();
  }

  showGeneralDialog(String text) {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.done,
                  color: MyColors.primaryColor,
                  size: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 75, 74, 75),
                      fontSize: 17,
                    ),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: MyColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "OKAY",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 10,
                        letterSpacing: 0.875,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  _handleSubmitted() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          height: 80,
          child: Container(
            width: 5,
            child: Center(
              child: SpinKitFadingCircle(
                color: MyColors.primaryColor,
                size: 50.0,
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true;
      Navigator.pop(context);
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      if (adminAccount.logInAs == Strings.lawEnforcement) {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => PoliceDashboard(
              id: adminAccount.identificationNumber,
            ),
          ),
          (Route route) => false,
        );
      } else if (adminAccount.logInAs == Strings.court) {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => CourtDashboard(
              id: adminAccount.identificationNumber,
            ),
          ),
          (Route route) => false,
        );
      } else {
        Navigator.of(context).pop();
        showInSnackBar('Please select the platform you are signing on to');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(right: 30, left: 30, top: 120),
          child: Form(
            key: formKey,
            autovalidate: autoValidate,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 60,
                  ),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: InputBox(
                    bottomMargin: 10,
                    labelText: "Identification Number",
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    focusNode: stationFN,
                    nextFocusNode: passFN,
                    onSaved: (String val) {
                      adminAccount.identificationNumber = val;
                    },
                  ),
                ),
                Container(
                  child: InputBox(
                    bottomMargin: 10,
                    labelText: "Password",
                    textInputType: TextInputType.text,
                    submitAction: _handleSubmitted,
                    textInputAction: TextInputAction.done,
                    obscureText: obscureText,
                    focusNode: passFN,
                    suffixIcon: IconButton(
                      onPressed: () => setState(
                        () => obscureText = !obscureText,
                      ),
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
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
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
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
                            adminAccount.logInAs = val.toString();
                          });
                        },
                        value: adminAccount.logInAs,
                        hint: Text(
                          "Login As",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        items: loginOptions.map((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 40),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "FORGOT PASSWORD?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 75, 74, 75),
                        fontSize: 10,
                        letterSpacing: 1,
                        fontFamily: "Lato",
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => print("Hey"),
                    ),
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
                      "Log in",
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
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "DON’T HAVE AN ACCOUNT?  SIGN UP",
                      style: TextStyle(
                        color: Color.fromARGB(255, 75, 74, 75),
                        fontSize: 10,
                        letterSpacing: 1,
                        fontFamily: "Lato",
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => print("Hello"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

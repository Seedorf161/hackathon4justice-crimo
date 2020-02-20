import 'package:crimo/misc/color.dart';
import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final IconData icon;
  final Widget prefix;
  final double boxWidth, boxHeight;
  final String hintText, labelText, initialValue;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final FocusNode focusNode, nextFocusNode;
  final VoidCallback submitAction;
  final Widget suffixIcon;
  final Color iconColor;
  final bool obscureText;
  final double bottomMargin;
  final TextStyle textStyle;
  final FormFieldValidator<String> validateFunction;
  final void Function(String) onSaved, onChange;
  final Key key;

  //passing props in the Constructor.
  InputBox({
    this.key,
    this.prefix,
    this.boxHeight,
    this.boxWidth,
    this.controller,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.obscureText = false,
    this.textInputType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.suffixIcon,
    this.icon,
    this.iconColor,
    this.bottomMargin,
    this.textStyle,
    this.validateFunction,
    this.onChange,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: bottomMargin < 15 ? 15 : bottomMargin,
      ),
      width: boxWidth,
      height: boxHeight,
      child: TextFormField(
        onChanged: onChange,
        style: TextStyle(
          fontSize: 16,
        ),
        key: key,
        initialValue: initialValue,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        validator: validateFunction,
        onSaved: onSaved,
        cursorColor: Colors.grey,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onFieldSubmitted: (String term) {
          if (nextFocusNode != null) {
            focusNode.unfocus();
            FocusScope.of(context).requestFocus(nextFocusNode);
          } else {
            submitAction();
          }
        },
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.primaryColor),
          labelStyle: TextStyle(
            fontSize: 16,
          ),
          hintText: hintText,
          prefix: prefix,
          labelText: labelText,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: MyColors.primaryColor, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: MyColors.primaryColor, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: MyColors.primaryColor, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}

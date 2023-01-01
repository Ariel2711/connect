// ignore_for_file: unnecessary_null_in_if_null_operators, prefer_typing_uninitialized_variables, must_be_immutable, use_key_in_widget_constructors
import 'package:connect_app/app/utils/colors.dart';
import 'package:connect_app/app/utils/constants.dart';
import 'package:connect_app/app/utils/images.dart';
import 'package:connect_app/app/utils/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

Widget text(
  String? text, {
  var fontSize = textSizeLargeMedium,
  FontWeight? fontWeight,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  TextDecoration decoration = TextDecoration.none,
  TextAlign? textAlign,
  bool isItalic = false,
}) {
  return Text(
    (textAllCaps ? text?.toUpperCase() : text) ?? "",
    textAlign: textAlign ?? (isCentered ? TextAlign.center : TextAlign.start),
    maxLines: isLongText ? null : maxLine,
    overflow: isLongText ? TextOverflow.clip : TextOverflow.ellipsis,
    style: TextStyle(
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? null,
      fontSize: fontSize,
      fontStyle: isItalic ? FontStyle.italic : null,
      color: textColor ?? textSecondaryColor,
      height: 1.5,
      letterSpacing: latterSpacing,
      decorationColor: textColor ?? textSecondaryColor,
      decoration: decoration,
    ),
  );
}

inputText(
    {TextFieldType textFieldType = TextFieldType.NAME,
    TextEditingController? controller,
    bool? isValidationRequired,
    bool? isEnabled,
    bool? isReadOnly,
    Icon? icon,
    String? label,
    String? initValue,
    String? hint,
    Widget? suffix,
    Color? suffixColor,
    Function(String)? onFieldSubmitted,
    String? Function(String?)? validator}) {
  return AppTextField(
    controller: controller,
    isValidationRequired: isValidationRequired,
    textFieldType: textFieldType,
    onFieldSubmitted: onFieldSubmitted,
    decoration: InputDecoration(
      prefixIcon: icon,
      labelText: label,
      suffixIcon: suffix,
      hintText: hint,
      suffixIconColor: suffixColor,
    ),
    enabled: isEnabled,
    readOnly: isReadOnly,
    validator: validator,
    initialValue: initValue,
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? shadowColor,
    Color? bgColor,
    double? shadowRadius,
    double? shadowBlurRadius,
    Offset? shadowOffset,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? colorScaffold,
    boxShadow: showShadow
        ? defaultBoxShadow(
            shadowColor: shadowColor ?? shadowColorGlobal,
            offset: shadowOffset ?? Offset(0.0, 0.0),
            blurRadius: shadowBlurRadius,
            spreadRadius: shadowRadius,
          )
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

// Widget appBarTitleWidget(context, String title,
//     {Color? color, Color? textColor}) {
//   return Container(
//     width: MediaQuery.of(context).size.width,
//     height: 60,
//     color: color ?? colorLight,
//     child: Row(
//       children: <Widget>[
//         Text(
//           title,
//           style: boldTextStyle(color: color ?? textPrimaryColor, size: 20),
//           maxLines: 1,
//         ).expand(),
//       ],
//     ),
//   );
// }

// AppBar appBar(BuildContext context, String title,
//     {List<Widget>? actions,
//     bool showBack = true,
//     Color? color,
//     Color? iconColor,
//     Color? textColor}) {
//   return AppBar(
//     automaticallyImplyLeading: false,
//     backgroundColor: color ?? colorLight,
//     leading: showBack
//         ? IconButton(
//             onPressed: () {
//               finish(context);
//             },
//             icon: Icon(Icons.arrow_back, color: black),
//           )
//         : null,
//     title:
//         appBarTitleWidget(context, title, textColor: textColor, color: color),
//     actions: actions,
//   );
// }

Widget boxContainer(
        {required List<Widget> widgets,
        EdgeInsetsGeometry? padding,
        EdgeInsetsGeometry? margin,
        double? elevation,
        Alignment? align,
        double? height,
        MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
        CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
        double? width}) =>
    Card(
      elevation: elevation,
      shadowColor: shadowColorGlobal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        alignment: align,
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: widgets,
        ),
      ),
    );

mkInputDecoration({
  Icon? icon,
  Icon? suffix,
  bool isBordered = false,
  String? hint,
  String? label,
  double? padding,
}) =>
    InputDecoration(
      icon: icon,
      suffixIcon: suffix,
      contentPadding: padding != null
          ? EdgeInsets.all(padding)
          : isBordered
              ? EdgeInsets.all(12)
              : null,
      hintText: hint,
      hintStyle: secondaryTextStyle(color: textColorSecondary),
      labelText: label,
      labelStyle: secondaryTextStyle(color: textColorSecondary),
      enabledBorder: isBordered
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: colorView, width: 0.0),
            )
          : null,
      errorBorder: isBordered
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: colorView, width: 0.0),
            )
          : null,
      focusedBorder: isBordered
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: colorView, width: 0.0),
            )
          : null,
    );

class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var isEnabled;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var hint;
  var label;
  var maxLine;
  var isBordered;
  var isReadOnly;
  String? Function(String?)? validator;
  TextEditingController? mController;
  AutovalidateMode? autovalidateMode;
  List<TextInputFormatter>? inputFormatters;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  Icon? icon;
  FocusNode? focus;
  TextAlign textAlign;
  String? initValue;
  Widget? suffix;
  // VoidCallback? onPressed;
  void Function()? onTap;

  EditText({
    var this.fontSize = textSizeNormal,
    var this.textColor = textColorSecondary,
    var this.fontFamily = fontRegular,
    var this.isPassword = false,
    var this.hint = "",
    var this.isSecure = false,
    var this.isEnabled = true,
    var this.text = "",
    var this.mController,
    var this.initValue,
    var this.maxLine = 1,
    var this.validator,
    var this.icon,
    var this.suffix,
    var this.focus,
    var this.textAlign = TextAlign.start,
    var this.label,
    var this.inputFormatters,
    var this.keyboardType,
    var this.onTap,
    var this.autovalidateMode = AutovalidateMode.onUserInteraction,
    var this.isBordered = false,
    var this.textInputAction = TextInputAction.next,
    var this.isReadOnly = false,
  });

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
      icon: widget.icon,
      suffixIcon: widget.isSecure
          ? GestureDetector(
              onTap: () {
                setState(() {
                  widget.isPassword = !widget.isPassword;
                });
              },
              child: Icon(
                widget.isPassword ? Icons.visibility : Icons.visibility_off,
                color: colorPrimary,
              ),
            )
          : widget.suffix,
      contentPadding: widget.isBordered ? EdgeInsets.all(12) : null,
      hintText: widget.hint,
      hintStyle: secondaryTextStyle(color: textColorPrimary),
      labelText: widget.label,
      labelStyle: secondaryTextStyle(color: textColorPrimary),
      enabledBorder: widget.isBordered
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: colorView, width: 0.0),
            )
          : null,
      errorBorder: widget.isBordered
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: colorView, width: 0.0),
            )
          : null,
      focusedBorder: widget.isBordered
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: colorView, width: 0.0),
            )
          : null,
    );
    return TextFormField(
      onTap: widget.onTap,
      initialValue: widget.initValue,
      focusNode: widget.focus,
      textAlign: widget.textAlign,
      readOnly: widget.isReadOnly,
      enabled: widget.isEnabled,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      controller: widget.mController,
      obscureText: widget.isPassword,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLine,
      style: TextStyle(
          color: textPrimaryColor,
          fontSize: textSizeMedium,
          fontFamily: fontRegular),
      decoration: inputDecoration,
    );
  }
}

TextFormField editTextStyle(var hintText, {isPassword = true}) {
  return TextFormField(
    obscureText: isPassword,
    inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
    style: primaryTextStyle(color: textPrimaryColor),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      hintText: hintText,
      hintStyle: TextStyle(color: textColorThird),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: colorView, width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: colorView, width: 0.0),
      ),
    ),
  );
}

class TopBar extends StatefulWidget {
  var titleName;

  TopBar({var this.titleName = ""});

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: colorLight,
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left, size: 45),
              onPressed: () {
                finish(context);
              },
            ),
            Center(
                child: text(widget.titleName,
                    textColor: textPrimaryColor,
                    fontSize: textSizeNormal,
                    fontFamily: fontBold))
          ],
        ),
      ),
    );
  }
}

Widget? Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() => Shimmer.fromColors(
    baseColor: Colors.grey[400],
    highlightColor: Colors.grey[100],
    child: Image.asset(image_grey, fit: BoxFit.cover));

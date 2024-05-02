import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchbar extends StatelessWidget {
  final bool? enabled;
  final TextEditingController controller;
  final String hintText;
  final  Function(String)? onChanged;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final Color borderColor;
  final Color? textcolor;
  final double verticalPadding;
  final double? height;
  final double borderradius;
  final String? prefixIcon;
  final String? suffixIcon;

  final TextAlign textAlign;
  final Function()? onTap;
  final Function()? suffixAction;

  CustomSearchbar({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border,
    this.maxLines,
    this.horizontalPadding = false,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = Colors.white,
    this.borderColor = const Color(0xFFF7F8F8),
    this.textcolor,
    this.verticalPadding = 4,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.left,
    this.enabled,
    this.borderradius = 12,
    this.onTap,
    this.onChanged,
    this.suffixAction,
    this.height = 54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalPadding ? 16 : 0, vertical: verticalPadding),
      decoration: BoxDecoration(
          color: bgColor,
          //  border: Border.all(color: borderColor),
          // border: Border,
          borderRadius: BorderRadius.circular(borderradius!)),
      padding: EdgeInsets.only(left: 10, top: 4),
      child: TextField(
        // focusNode: FocusNode,

        enabled: enabled,
        maxLines: maxLines ?? 1,
        controller: controller,
        obscureText: obscureText,
        textAlign: textAlign,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          // focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //     borderSide: BorderSide(color: Colors.orange)),


          border: InputBorder.none,
          prefixIcon: prefixIcon == null
              ? null
              : Padding(
            padding: const EdgeInsets.all(14.0),
            child: Image.asset(
              prefixIcon!,
              width: 2,
              color: Colors.black,

            ),
          ),
          suffixIcon: suffixIcon == null
              ? null
              : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: suffixAction,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image.asset(
                suffixIcon!,
                color: Colors.white,
                width: 2,
                // height: 10,
                // fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

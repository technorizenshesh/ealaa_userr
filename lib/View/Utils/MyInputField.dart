import 'package:flutter/services.dart';

import '../../import_ealaa_user.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final String labelfontfamily;
  final BoxBorder? border;
  final double horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final Color inputbordercolor;
  final Color hintcolor;
  final Color labelcolor;
  final Color bordercolor;
  final double fontsize;
  final double labelfont;
  final double left;
  final double suffixheight;
  final double prefixheight;
  final double? height;
  final double borderradius;
  final double verticalPadding;
  final String? prefixIcon;
  final String? suffixIcon;
  final TextAlign textAlign;
  final double paddingsuffix;
  final bool boxshadow;
  final bool showlabel;
  final bool isBorder;
  final Function()? onTapsuffix;
  final bool isflag;
  final TextInputType? keyboardtype;
  final bool enable;
  final Function(String?)? onSubmitted;

  CustomTextFieldWithLabel({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.label = 'label',
    this.border,
    this.isBorder = true,
    this.labelfontfamily = 'regular',
    this.maxLines,
    this.horizontalPadding = 0,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = MyColors.textcolor,
    this.inputbordercolor = Colors.transparent,
    this.bordercolor = Colors.white,
    this.labelcolor = MyColors.secondarycolor,
    this.verticalPadding = 0,
    this.fontsize = 16,
    this.labelfont = 14,
    this.left = 16,
    this.suffixheight = 10,
    this.prefixheight = 10,
    this.height = 57,
    this.borderradius = 30,
    this.suffixIcon,
    this.textAlign = TextAlign.left,
    this.paddingsuffix = 12,
    this.boxshadow = false,
    this.showlabel = false,
    this.onTapsuffix,
    this.isflag = false,
    this.keyboardtype = TextInputType.text,
    this.enable = true,
    this.onSubmitted,
    required this.hintcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showlabel)
          ParagraphText(
            text: label,
            fontSize: labelfont,
            color: labelcolor,
          ),
        if (showlabel) SizedBox(height: 7),
        Container(
          height: maxLines == 1 ? 60 : height,
          margin: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
              color: MyColors.primaryColor,
              // color: bgColor,
              // border: isBorder ? border ?? Border.all(color: bordercolor) : null,
              // border: Border,
              borderRadius: BorderRadius.circular(borderradius),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          padding: EdgeInsets.only(left: prefixIcon != null ? 0 : left),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3,
              ),
              // if(showlabel)
              ParagraphText(
                text: label,
                fontSize: labelfont,
                color: labelcolor,
              ),
              // if(showlabel)
              SizedBox(height: 2),
              Center(
                child: TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontsize,
                      fontFamily: 'regular'),
                  maxLines: maxLines ?? 1,
                  controller: controller,
                  obscureText: obscureText,
                  textAlign: textAlign,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: keyboardtype,
                  enabled: enable,
                  onSubmitted: onSubmitted,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontSize: fontsize,
                        color: MyColors.greycolor,
                        fontFamily: 'regular'),
                    isDense: true,

                    border: InputBorder.none,
                    // focusedBorder: UnderlineInputBorder(
                    //  borderSide: BorderSide(color: inputbordercolor)
                    // ),
                    // enabledBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: inputbordercolor),
                    // ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: inputbordercolor),
                    // ),
                    // border: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: inputbordercolor),
                    // ),
                    prefixIcon: prefixIcon == null
                        ? null
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 8.0, bottom: 08.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  prefixIcon!,
                                  // width: 10,
                                  // height: 10,
                                  fit: BoxFit.fitHeight,
                                  height: prefixheight,
                                ),
                              ],
                            ),
                          ),
                    suffixIcon: suffixIcon == null
                        ? null
                        : GestureDetector(
                            onTap: onTapsuffix,
                            child: Padding(
                              padding: EdgeInsets.all(paddingsuffix),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    suffixIcon!,
                                    // color: Colors.black,
                                    // width: 10,
                                    height: suffixheight,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final String labelfontfamily;
  final BoxBorder? border;
  final double horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final Color inputbordercolor;
  final Color hintcolor;
  final Color labelcolor;
  final Color bordercolor;
  final double fontsize;
  final double labelfont;
  final double left;
  final double suffixheight;
  final double prefixheight;
  final double? height;
  final double borderradius;
  final double verticalPadding;
  final String? prefixIcon;
  final String? suffixIcon;
  final TextAlign textAlign;
  final double paddingsuffix;
  final bool boxshadow;
  final bool showlabel;
  final bool isBorder;
  final Function()? onTapsuffix;
  final bool isflag;
  final TextInputType? keyboardtype;
  final bool enable;
  final Function(String?)? onSubmitted;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.label = '',
    this.border,
    this.isBorder = true,
    this.labelfontfamily = 'regular',
    this.maxLines,
    this.horizontalPadding = 0,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = Colors.white,
    this.inputbordercolor = Colors.transparent,
    this.bordercolor = Colors.white,
    this.hintcolor = MyColors.greycolor,
    this.labelcolor = MyColors.greycolor,
    this.verticalPadding = 0,
    this.fontsize = 16,
    this.labelfont = 14,
    this.left = 16,
    this.suffixheight = 10,
    this.prefixheight = 10,
    this.height = 57,
    this.borderradius = 15,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.left,
    this.paddingsuffix = 12,
    this.boxshadow = false,
    this.showlabel = false,
    this.onTapsuffix,
    this.isflag = false,
    this.keyboardtype = TextInputType.text,
    this.enable = true,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showlabel)
          ParagraphText(
            text: label,
            fontSize: labelfont,
            color: labelcolor,
          ),
        if (showlabel) SizedBox(height: 7),
        Container(
          height: maxLines == 1 ? 57 : height,
          margin: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
              color: bgColor,
              border:
                  isBorder ? border ?? Border.all(color: bordercolor) : null,
              // border: Border,
              borderRadius: BorderRadius.circular(borderradius),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          padding: EdgeInsets.only(left: prefixIcon != null ? 0 : left),
          child: Center(
            child: TextField(
              style: TextStyle(
                  color: Colors.black,
                  fontSize: fontsize,
                  fontFamily: 'regular'),
              maxLines: maxLines ?? 1,
              controller: controller,
              obscureText: obscureText,
              textAlign: textAlign,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: keyboardtype,
              enabled: enable,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: labelcolor,
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                    fontSize: fontsize,
                    color: hintcolor,
                    fontFamily: 'regular'),
                isDense: true,
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: inputbordercolor)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: inputbordercolor),
                ),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: inputbordercolor),
                // ),
                // border: UnderlineInputBorder(
                //   borderSide: BorderSide(color: inputbordercolor),
                // ),
                prefixIcon: prefixIcon == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, right: 0.0, top: 8.0, bottom: 08.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              prefixIcon!,
                              // width: 10,
                              // height: 10,
                              fit: BoxFit.fitHeight,
                              height: prefixheight,
                            ),
                          ],
                        ),
                      ),
                suffixIcon: suffixIcon == null
                    ? null
                    : GestureDetector(
                        onTap: onTapsuffix,
                        child: Padding(
                          padding: EdgeInsets.all(paddingsuffix),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                suffixIcon!,
                                // color: Colors.black,
                                // width: 10,
                                height: suffixheight,
                                fit: BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class CustomTextFieldwithoutshadow extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final Color inputbordercolor;
  final Color hintcolor;
  final double fontsize;
  final double left;
  final double borderradius;
  final double verticalPadding;
  final String? prefixIcon;
  final String? suffixIcon;
  final TextAlign textAlign;
  final double? paddingsuffix;
  final TextInputType keyBoardType;
  final bool readonly;
  final Function()? onTap;
  final Function()? onTapsuffix;
  final double? width;

  CustomTextFieldwithoutshadow({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border,
    this.maxLines,
    this.horizontalPadding = false,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = MyColors.lightgreycolor1,
    this.inputbordercolor = Colors.transparent,
    this.hintcolor = MyColors.greycolor,
    this.verticalPadding = 0,
    this.fontsize = 16,
    this.left = 16,
    this.borderradius = 30,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.left,
    this.paddingsuffix = 16,
    required this.labelText,
    this.keyBoardType = TextInputType.text,
    this.readonly = false,
    this.onTapsuffix, this.width, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      // Text(labelText,style: TextStyle(color: Color(0xff344054),fontWeight: FontWeight.w600,fontSize: 14),),
      // SizedBox(height: 8,),
     Container(width: width,
     child:  TextFormField(
       onTap: onTap,
       style: TextStyle(
         color: Colors.black,
         fontSize: fontsize,
       ),
       controller: controller,
       readOnly: readonly,
       obscureText: obscureText,
       textAlign: textAlign,
       keyboardType: keyBoardType,
       decoration: InputDecoration(
         fillColor: Color(0xffF7F8F8),
         filled: true,

         contentPadding: EdgeInsets.symmetric(horizontal: 16),
         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.primaryColor),
             borderRadius: BorderRadius
             .circular(10)),
         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: 
         Colors.grey.withOpacity(0.2)),
             borderRadius: BorderRadius
             .circular(10)),
         border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffF7F8F8)),
             borderRadius:
             BorderRadius.circular(10)),

         prefixIcon: prefixIcon != null
             ? Padding(
           padding: const EdgeInsets.all(13),
           child: Image.asset(
             prefixIcon!,
             height: 10,
           ),
         )
             : null,
         suffixIcon: suffixIcon != null
             ? InkWell(
           onTap: onTapsuffix,
           child: Padding(
             padding: EdgeInsets.all(paddingsuffix??16),
             child: Image.asset(
               suffixIcon!,
               height: 10,
             ),
           ),
         )
             : null,
         // suffixIcon: IconButton(
         //
         //   icon: Icon(
         //     _isObscure
         //         ? Icons.visibility_off

         hintText: hintText,
         hintStyle: TextStyle(color: Colors.grey),
       ),
     ));

  }
}



class CommonWidgets {
  static Widget commonTextFieldForLoginSignUP(
      {double? elevation,
        String? hintText,
        String? labelText,
        String? errorText,
        String? title,
        TextStyle? titleStyle,
        EdgeInsetsGeometry? contentPadding,
        TextEditingController? controller,
        int? maxLines,
        double? cursorHeight,
        bool wantBorder = false,
        ValueChanged<String>? onChanged,
        FormFieldValidator<String>? validator,
        Color? fillColor,
        Color? initialBorderColor,
        double? initialBorderWidth,
        TextInputType? keyboardType,
        double? borderRadius,
        double? maxHeight,
        TextStyle? hintStyle,
        TextStyle? style,
        TextStyle? labelStyle,
        TextStyle? errorStyle,
        List<TextInputFormatter>? inputFormatters,
        TextCapitalization textCapitalization = TextCapitalization.none,
        bool autofocus = false,
        bool readOnly = false,
        bool hintTextColor = false,
        Widget? suffixIcon,
        Widget? prefixIcon,
        AutovalidateMode? autoValidateMode,
        int? maxLength,
        GestureTapCallback? onTap,
        bool obscureText = false,
        FocusNode? focusNode,
        bool? filled,
        bool isCard = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: GoogleFonts.poppins(
              color: isCard ? MyColors.primaryColor : Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: isCard ? MyColors.primaryColor : Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(borderRadius ?? 40),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                prefixIcon != null
                    ? Row(children: [
                  prefixIcon,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Container(
                      width: 1.4,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isCard ? MyColors.primaryColor : Colors.grey,
                      ),
                    ),
                  ),
                ])
                    : const SizedBox(),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // CommonMethods.textViewLinearGradient(
                            //     text: title, value: isCard),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                          child: TextFormField(
                            focusNode: focusNode,
                            obscureText: obscureText,
                            onTap: onTap,
                            maxLength: maxLength,
                            cursorHeight: cursorHeight,
                            cursorColor: MyColors.primaryColor,
                            autovalidateMode: autoValidateMode,
                            controller: controller,
                            onChanged: onChanged ??
                                    (value) {
                                  value = value.trim();
                                  if (value.isEmpty ||
                                      value.replaceAll(" ", "").isEmpty) {
                                    controller?.text = "";
                                  }
                                },
                            validator: validator,
                            keyboardType:
                            keyboardType ?? TextInputType.streetAddress,
                            readOnly: readOnly,
                            autofocus: autofocus,
                            inputFormatters: inputFormatters,
                            textCapitalization: textCapitalization,
                            style: GoogleFonts.poppins(),
                            // style: style ??
                            //     Theme.of(Get.context!)
                            //         .textTheme
                            //         .headlineMedium
                            //         ?.copyWith(fontSize: 14.px),
                            decoration: InputDecoration(
                              errorText: errorText,
                              counterText: '',
                              // errorStyle: errorStyle ??
                              //     Theme.of(Get.context!)
                              //         .textTheme
                              //         .titleMedium
                              //         ?.copyWith(
                              //         color: Theme.of(Get.context!)
                              //             .colorScheme
                              //             .error),
                              suffixIcon: suffixIcon,
                              //    prefixIcon: prefixIcon,
                              hintText: hintText,
                              labelText: labelText,
                              labelStyle: labelStyle,
                              fillColor: fillColor ?? MyColors.primaryColor,
                              filled: filled ?? false,
                              contentPadding:
                              contentPadding ?? EdgeInsets.only(bottom: 10),
                              // hintStyle: hintStyle ??
                              //     Theme.of(Get.context!).textTheme.titleMedium,
                              disabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


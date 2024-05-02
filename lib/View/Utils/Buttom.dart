


import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final bool loading;
  final String title;
  final VoidCallback onTap ;
  final double borderRadius;
  final double fontsize;
  final double? width;
  final double height;
  final double padding;
  final Color btnColor;
  final Color loaderColor;
  final Color textColor;
  final FontWeight fontweight;
  const RoundButton({Key? key,
    required this.title,
    required this.onTap,
    this.loading= false,
    this.borderRadius=30,
    this.padding=0,
    this.fontsize=20,
    this.width,
    this.height=60,
    this.btnColor=MyColors.primaryColor,
    this.fontweight=FontWeight.w800,
    this.textColor= Colors.white,
    this.loaderColor= Colors.white,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      radius: 50,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient:  LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomRight,
                  colors: [
                    btnColor,
                    btnColor
                  ])),
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Padding(
            padding:  EdgeInsets.all(padding??0),
            child: Center(child : loading ?  CircularProgressIndicator(strokeWidth: 2,color: loaderColor,): Text(title, style: TextStyle(fontFamily: "OpenSans",
              color: textColor, fontSize: fontsize, fontWeight:fontweight,),),
            ),)
      ),
    );

    InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          decoration: BoxDecoration(color: Colors.deepPurple,borderRadius: BorderRadius.circular(10),),
          child: Center(child : loading ?  CircularProgressIndicator(strokeWidth: 3,):
          Text(title,style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}
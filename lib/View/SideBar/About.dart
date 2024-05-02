import 'package:ealaa_userr/View/Utils/ApiConstants.dart';
import 'package:ealaa_userr/View/Utils/MyColors.dart';
import 'package:ealaa_userr/View/Utils/MyImages.dart';
import 'package:ealaa_userr/View/Utils/webService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var data ;
  String name='About' ;
  bool loader =false;
  getData()async{
    setState(() {
      loader =true;
    });
    var res = await Webservices.getMap(aboutUs);
    print("res -------$res");
    data=res['result'][0]['about_us_text'];
    name=res['name']??'About Us';
    setState(() {
      loader =false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      // drawer: DData(),
      appBar:
      AppBar(
          toolbarHeight: 80,
          scrolledUnderElevation:0.0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset("assets/images/backButton.svg")),
          ),
          centerTitle: true,
          title: Text("$name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
      body: loader?Center(child: CircularProgressIndicator(color: MyColors.primaryColor,),)
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [


              // Image.asset("assets/images/Rectangle 41887.png",),
              // sizeBox_mq(context, width: 0, height: 0.05),
              Html(data: data)
            ],
          ),
        ),
      ),
    );
  }
}

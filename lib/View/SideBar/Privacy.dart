
import 'package:ealaa_userr/View/Utils/ApiConstants.dart';
import 'package:ealaa_userr/View/Utils/webService.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter_html/flutter_html.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  var data ;
  bool loader =false;
  String name='Privacy Notice' ;
  getData()async{
    setState(() {
      loader =true;
    });
    var res = await Webservices.getMap(privacyPolicy);
    print("res -------$res");
    data=res['result'][0]['policy_text'];
    name=res['name']??'Privacy Policy';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
              ))
      ),
      body: loader?Center(child: CircularProgressIndicator(color: MyColors.primaryColor,),)
          :Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              // Image.asset("assets/images/Rectangle 41887.png",),
              // sizeBox_mq(context, width: 0, height: 0.01),
              Html(data: data)
            ],
          ),
        ),
      ),
    );
  }
}

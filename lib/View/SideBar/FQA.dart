
import 'package:ealaa_userr/import_ealaa_user.dart';



class Faq_screen extends StatefulWidget {
  const Faq_screen({super.key});
  @override
  State<Faq_screen> createState() => _Faq_screenState();
}
class _Faq_screenState extends State<Faq_screen> {
  TextEditingController searchController=TextEditingController();
  var  _isLoading=false;
  var width;
  var height;
  var loginid;

  // List<faq_data>? getfaqdata=[];
  // Future<void> getfaqapi() async {
  //
  //   setState(() {_isLoading=true;});
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   loginid = prefs.getString("user_id");
  //   setState(() {_isLoading=true;});
  //
  //   var user={
  //     'user_id':loginid.toString(),
  //   };
  //   print("getpostrequest ${jsonEncode(user)}");
  //   final getfaqRes = await Providers().getfaq(user);
  //
  //   if (getfaqRes.status.toString().contains("1")) {
  //
  //     getfaqdata=getfaqRes.result!;
  //
  //     print("getfaqdata $getfaqRes");
  //     setState(() {
  //       getfaqdata=getfaqRes.result!;
  //       filteredTask=getfaqdata!;
  //       print("getfaqdata $getfaqdata");
  //     });
  //
  //
  //
  //
  //     print("getemp_data-----------------${getfaqdata}");
  //
  //
  //     print("getemp_data$getfaqdata");
  //
  //   }else{
  //     print(getfaqRes.message);
  //   }
  //   setState(() {_isLoading=false;});
  //
  //
  //
  // }
  //
  //
  //
  // List<String?> extractUrls(String text) {
  //   RegExp urlRegExp = RegExp(
  //     r"(https?:\/\/[^\s]+)",
  //     caseSensitive: false,
  //     multiLine: true,
  //   );
  //   List<String?> urls = urlRegExp.allMatches(text).map((match) => match.group(0)).toList();
  //   return urls;
  // }
  // Future<void> _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  @override
  void initState() {
    // getfaqapi();
    super.initState();
  }

  // List<faq_data>? filteredTask = [];

  // void filterTask() {
  //   filteredTask = [];
  //   //  completedFilteredTask = [];
  //
  //   setState(() {
  //     for (int index = 0; index < getfaqdata!.length; index++) {
  //       if (getfaqdata![index].question
  //           .toString()
  //           .toLowerCase()
  //           .contains(searchController.text.toLowerCase()) ||
  //           getfaqdata![index].answer
  //               .toString()
  //               .toLowerCase()
  //               .contains(searchController.text.toLowerCase())) {
  //         filteredTask!.add(getfaqdata![index]);
  //       }
  //
  //     }
  //
  //
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    width= MediaQuery.of(context).size.width;
    height= MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: customAppBar(context: context,title: "FAQ".tr),

      backgroundColor:AppColors.whiteColor,
      body:  SingleChildScrollView(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(height: height*0.15,),
            Center(child: Image.asset("assets/images/FAQ-1.png",width: 151,)),
            SizedBox(height: height*0.04,),
            ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                //reverse: true,
                physics: NeverScrollableScrollPhysics(),

                itemBuilder: (context, index) {

                  return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: ExpansionTile(

                        initiallyExpanded: false,

                        iconColor: MyColors.primaryColor,
                        collapsedIconColor: MyColors.primaryColor,
                        title:
                        // Html(data:"${filteredTask![index].question.toString()}",),
                        Text(
                          "What is Perkz Dollar?",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        children: [

                          Padding(
                            padding: EdgeInsets.only(left: 15, top: 5, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [


                                // Html(data:"${filteredTask![index].answer.toString()}",
                                // ),
                                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", maxLines: 4,
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,



                                  ),),

                                InkWell(
                                  onTap:(){
                                    // List<String?> url = extractUrls("${filteredTask![index].url.toString()}",);;
                                    //  print("url-------------${url}");
                                    // _launchURL("${filteredTask![index].url.toString()}");
                                  },
                                  child: Text(" ", maxLines: 4,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue


                                    ),),
                                ),
                              ],
                            ),
                          ),

                        ],
                      )
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}



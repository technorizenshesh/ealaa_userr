import 'package:ealaa_userr/Model/CompanyListModel.dart';
import 'package:ealaa_userr/View/Screens/CompanyDetails.dart';
import 'package:ealaa_userr/View/Screens/ShipmentDetailScreen.dart';
import 'package:ealaa_userr/View/Utils/CustomSnackBar.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/webService.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({Key? key}) : super(key: key);

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {

  List<CompanyListResult> companyList = [];

  getCompaniesList() async {
    var res = await Webservices.getMap("$baseUrl$get_companies_list");
    print("status from api ${res}");
    final resdata = CompanyListModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      companyList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
getCompaniesList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset("assets/images/backButton.svg")),

        ),
        title: MainHeadingText(text: "Company",
          textAlign: TextAlign.center,fontSize: 20,fontWeight: FontWeight.w500,),
        centerTitle: true,
        // actions: [
        //   TextButton(onPressed: (){}, child: Text("Next",style: TextStyle(color: MyColors.primaryColor,fontSize: 16,fontWeight: FontWeight.bold),))
        // ],
        backgroundColor: Colors.white,
      ),
      body:

      companyList==null?Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Column(
          children: [
            for(int i=0;i<companyList.length;i++)
              Padding(
                padding: EdgeInsets.only(bottom: 20),
         child: ListTile(
           onTap: (){
             // Navigator.push(
             //     context,
             //     CupertinoPageRoute(
             //         builder: (context) =>
             //             ShipmentDetailScreen()));
             Navigator.push(
                 context,
                 CupertinoPageRoute(
                     builder: (context) =>
                         CompanyDetails(cId: companyList[i].cmId,)));
           },
           leading:
           Container(
               padding: EdgeInsets.all(2),
               width: width * 0.14,
               height: height * 0.06,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: MyColors.primaryColor),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(10),
                 child: CachedNetworkImage(
                   imageUrl:
                   companyList[i].cmCompanyImage,
                   // width: width * 0.1,
                   // height: height * 0.05,
                   fit: BoxFit.cover,
                   placeholder: (context, url) => Center(
                       child: CircularProgressIndicator()),
                   errorWidget: (context, url, error) =>
                       Icon(Icons.error),
                 ),
               )),
           horizontalTitleGap: 5,
           title: Text(companyList[i].cmCompanyName,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 17 ),),
           subtitle: Text(companyList[i].cmCompanyAddress,style: TextStyle(fontSize: 14,color: Colors.grey ),overflow: TextOverflow.ellipsis,),
         ),
              )
          ],
        ),
      ),
    );
  }
}

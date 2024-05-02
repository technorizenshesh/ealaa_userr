import 'package:ealaa_userr/View/Screens/CompanyDetailFinalScreen.dart';
import 'package:ealaa_userr/View/Screens/ShipmentDetailScreen.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Model/CompanyDetailModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class CompanyDetails extends StatefulWidget {
  final String cId;

  const CompanyDetails({Key? key, required this.cId}) : super(key: key);

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  CompanyDetailResult? companyDetailResult;
  String countries = '';
  String cities = '';

  getCompanyDetail() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_company_by_id?company_id=${widget.cId}");
    print("status from api ${res}");
    final resdata = CompanyDetailModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      companyDetailResult = resdata.result;

      for (int i = 0; i < companyDetailResult!.range.country.length; i++) {
        countries = companyDetailResult!.range.country.map((country) => country.name).join(', ');
      }
      for (int i = 0; i < companyDetailResult!.range.city.length; i++) {
        cities = companyDetailResult!.range.city.map((city) => city.name).join(',');
      }
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
    getCompanyDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset("assets/images/backButton.svg")),
        ),
        title: MainHeadingText(
          text: "Company Details",
          textAlign: TextAlign.center,
          fontSize: 20,
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: Image.asset("assets/images/roundedSearch.png"),
        //   )
        // ],
        backgroundColor: Colors.white,
      ),
      body: companyDetailResult == null
          ? Container()
          : Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: height * 0.9,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Container(
                                  padding: EdgeInsets.all(2),
                                  width: width * 0.14,
                                  height: height * 0.08,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColors.primaryColor),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          companyDetailResult!.cmCompanyImage,
                                      width: width * 0.14,
                                      height: height * 0.08,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  )),
                              title: Text(
                                companyDetailResult!.cmCompanyName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              subtitle: Text(companyDetailResult!.cmCompanyMail,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey)),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            MainHeadingText(
                              text: "Description",
                              textAlign: TextAlign.center,
                              fontSize: 20,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              companyDetailResult!.cmCompanyDescription,
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            MainHeadingText(
                              text: "Service Range",
                              textAlign: TextAlign.center,
                              fontSize: 20,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Within Country - ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  countries,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Within City - ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  cities,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MainHeadingText(
                                  text: "Reviews",
                                  textAlign: TextAlign.center,
                                  fontSize: 20,
                                ),
                                Text(
                                  "See All",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: MyColors.primaryColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            if (companyDetailResult!.review.isEmpty)
                              Text("No Reviews found")
                            else
                              for (int i = 0;
                                  i < companyDetailResult!.review.length;
                                  i++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      leading: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: MyColors.primaryColor) ,),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: companyDetailResult!
                                                .review[i].image,
                                            width: width * 0.1,
                                            height: height * 0.05,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        companyDetailResult!.review[i].userName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      trailing: Container(
                                        width: width * 0.13,
                                        height: height * 0.03,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: MyColors.primaryColor,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              companyDetailResult!.review[i]
                                                  .reviewCompanyRating,
                                              style: TextStyle(
                                                  color: MyColors.primaryColor),
                                            ),
                                            SvgPicture.asset(
                                                "assets/images/Vector.svg")
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      companyDetailResult!
                                          .review[i].reviewCompanyComment,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     InkWell(
                            //         // onTap: (){
                            //         //   Navigator.push(
                            //         //       context, MaterialPageRoute(builder: (context) => ShipmentDetailScreen()));
                            //         // },
                            //         child: Image.asset("assets/images/rightIcon.png")),
                            //     SizedBox(width: width*0.15,),
                            //     Image.asset("assets/images/crossIcon.png")
                            //
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                          width: width - 40,
                          child: Center(
                              child: RoundButton(
                                  title: "Next",
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                ShipmentDetailScreen(selectedCompanyData: companyDetailResult!,)));
                                  }))))
                ],
              ),
            ),
    );
  }
}

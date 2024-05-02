import 'package:ealaa_userr/View/Screens/CancelledOrder.dart';
import 'package:ealaa_userr/View/Screens/OngoingOrder.dart';
import 'package:ealaa_userr/View/Screens/PastOrder.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../Model/BannerModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';
import 'PendingOrder.dart';

class Myorder extends StatefulWidget {
  const Myorder({super.key});

  @override
  State<Myorder> createState() => _MyorderState();
}

class _MyorderState extends State<Myorder> {    int activeIndex = 0;
  List image = [
    "assets/images/Frame 27@3x.png",
    "assets/images/bike1.png",
  ];

  List name = [
    "Miracle Westervelt",
    "Tiana Kenter",
  ];

  List Slider = [
    MyImages.slider,
    MyImages.slider,
    MyImages.slider,
  ];
  TextEditingController search = TextEditingController();

  getBanner() async {
    var res = await Webservices.getMap("$baseUrl$get_banner");
    print("status from api ${res}");
    final resdata = BannerModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      bannerList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
    if(bannerList.isEmpty){
      getBanner();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        centerTitle: true,
        title: Text("My Order"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: height*0.02,),
              bannerList.isEmpty?CircularProgressIndicator():
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 150,
                  //height: MediaQuery.of(context).size.height / 6,
                  aspectRatio: 10.5 / 9,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
                itemCount: bannerList.length,
                itemBuilder: (context, int index, int realIndex) {
                  return Container(
                    margin: EdgeInsets.only(right: 16),
                    width: width,
                    height: height * 0.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        bannerList[index].image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
              tabbar()
              // ListView.builder(
              //     itemCount: image.length,
              //     shrinkWrap: true,
              //     physics: ScrollPhysics(),
              //     itemBuilder: (BuildContext ctx, index) {
              //       return Padding(
              //         padding:  EdgeInsets.only(left: 8,right: 8,top: 20),
              //         child: Container(
              //           padding: EdgeInsets.all(20),
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(16),
              //             color: Color(0xfff6f7fc)
              //           ),
              //           child: Column(
              //             children: [
              //               Row(children: [
              //                 Image.asset(image[index],height: 45,),
              //                SizedBox(width: 15,),
              //                 Text(name[index],style: GoogleFonts.beVietnamPro(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w700,
              //                   color: MyColors.blackcolor
              //                 ),)
              //
              //               ],),
              //               SizedBox(height: 12,),
              //               Row(children: [
              //                Text('Destination :',style: GoogleFonts.beVietnamPro(
              //                    fontSize: 12,
              //                    fontWeight: FontWeight.w700,
              //                    color: MyColors.greycolor
              //                ),),
              //                 SizedBox(width: 15,),
              //                 Text("Vijay Nagar to Sapphire House",style: GoogleFonts.beVietnamPro(
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.w500,
              //                     color: MyColors.greycolor
              //                 ),)
              //
              //               ],),
              //               SizedBox(height: 12,),
              //               Row(children: [
              //                 Text('Payment :',style: GoogleFonts.beVietnamPro(
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.w700,
              //                     color: MyColors.greycolor
              //                 ),),
              //                 SizedBox(width: 35,),
              //                 Text("Master Card",style: GoogleFonts.beVietnamPro(
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.w500,
              //                     color: MyColors.greycolor
              //                 ),)
              //
              //               ],),
              //               SizedBox(height: 12,),
              //               Row(children: [
              //                 Text('Order Date :',style: GoogleFonts.beVietnamPro(
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.w700,
              //                     color: MyColors.greycolor
              //                 ),),
              //                 SizedBox(width: 20,),
              //                 Text("08 Sep. 2024",style: GoogleFonts.beVietnamPro(
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.w500,
              //                     color: MyColors.greycolor
              //                 ),)
              //
              //               ],)
              //             ],),
              //         ),
              //       );
              //     }),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabbar() {
    return DefaultTabController(
      length: 4, // length of tabs
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TabBar(
            physics: NeverScrollableScrollPhysics(),
            labelPadding: EdgeInsets.only(left: 5, right: 0),
            labelColor: MyColors.primaryColor,
            ///555
            unselectedLabelColor: Color(0xff000000),
            isScrollable: false,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3,
                color: MyColors.primaryColor,
              ),
            ),
            // duration: 0,
            labelStyle: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
              letterSpacing: 0.2,
              fontFamily: "Poppins",
            ),
            unselectedLabelStyle: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
              letterSpacing: 0.2,
              fontFamily: "Poppins",
            ),
            tabs: [
              Tab(text: 'Pending',),
              Tab(text: 'Ongoing'),
              Tab(text: 'Completed'),
              Tab(text: "Cancelled",)
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical:5),
            child: Container(
              //  color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.9, //height of TabBarView
              child: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  PendingOrder(),
                  OngoingOrder(),
                  PastOrder(),
                  CancelledOrder()
                  // CancelledAppointment()
                ],
                // children: <Widget>[Container(), Container(), Container()],
                // controller: _tabController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

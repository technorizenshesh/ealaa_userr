import 'package:ealaa_userr/Model/GetShipmentStatusListModel.dart';
import 'package:ealaa_userr/View/Screens/ChatRoom.dart';
import 'package:ealaa_userr/View/Screens/OrderDetailScreen.dart';
import 'package:ealaa_userr/View/Screens/ShowQR.dart';
import 'package:ealaa_userr/View/Utils/ApiConstants.dart';
import 'package:ealaa_userr/View/Utils/CustomSnackBar.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/View/Utils/webService.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:intl/intl.dart';

class OngoingOrder extends StatefulWidget {
  const OngoingOrder({Key? key}) : super(key: key);

  @override
  State<OngoingOrder> createState() => _OngoingOrderState();
}

class _OngoingOrderState extends State<OngoingOrder> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<GetShipmentStatusListResult> ongoingList = [];
  bool showLoader = true;
  getOngoingList() async {
    setState(() {});
    var res = await Webservices.getMap(
        "$get_shipment_ongoing_start?driver_id=$userId&status=Approve&type"
            "=USER");
    showLoader = false;
    print("status from api ${res}");
    final resdata = GetShipmentStatusListModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {;
      ongoingList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

     @override
  void initState() {
       Timer.periodic(Duration(seconds: 5), (timer) {
         print("my ongoing notification....0")  ;
         if(ongoingNotification!=0){
           getOngoingList();
           print("my ongoing notification")  ;
           ongoingNotification=0;
         }
       });
       getOngoingList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
          RefreshIndicator( key: _refreshIndicatorKey,  color: Colors.white,
            backgroundColor: MyColors.primaryColor ,
            strokeWidth: 2,onRefresh: ()async{
            getOngoingList();
            setState(() {
            });
          },
            child:          showLoader?
            Container(height:100,child:
            Center(child:  CircularProgressIndicator(color:
            MyColors
                .primaryColor,))
            )
                :ongoingList.isEmpty?
            Image
                .asset("assets/images/NoDataFound.png")
                :
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                width: width,
                height: height,
                child:ListView.builder(
                    itemCount: ongoingList.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: (){
                          push(context: context,screen:OrderDetailScreen(shipmentId:
                          ongoingList[index].shipmentDetailsId, qr:
                          ongoingList[index].qrImage,));

                        },
                        child: Padding(
                          padding:  EdgeInsets.only(left: 8,right: 8,top: 20),
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Color(0xfff6f7fc)
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          InkWell(
                                              onTap: (){
                                                // Navigator.pop(context);
                                                MyGlobalKeys.tabBarKey.currentState!.onTap(2) ;
                                              },
                                              highlightColor: Colors.cyan,
                                              hoverColor: Colors.red,
                                              splashColor: Colors.pink,

                                              child:
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                // Adjust the border radius as needed
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: MyColors.primaryColor, // Border color
                                                        width: 3.0, // Border width
                                                      ),
                                                    ),
                                                    child:  ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                      child: CachedNetworkImage(
                                                        imageUrl:ongoingList[index].shipmentDetailsPhoto,
                                                        width: 50,
                                                        height: 50,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ),
                                                    )
                                                  // Image.asset(
                                                  //   MyImages.user,
                                                  //   width: 53,
                                                  // ),
                                                ),
                                              ),
                                              // Image.network(ongoingList[index].shipmentDetailsPhoto,
                                              //   height: 45,)

                                          ),
                                          SizedBox(width: 15,),
                                          Text(ongoingList[index].shipmentDetailsReceiverName,style: GoogleFonts
                                              .beVietnamPro(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: MyColors.blackcolor
                                          ),)

                                        ],),
                                        SizedBox(height: 15,),
                                        Container(
                                          child: Row(children: [
                                            Text('Shipment Id :',style: GoogleFonts.beVietnamPro(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: MyColors.greycolor
                                            ),),
                                            SizedBox(width: 15,),
                                            Text(ongoingList[index].shipmentDetailsId,style:
                                            GoogleFonts.beVietnamPro(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: MyColors.greycolor
                                            ),overflow: TextOverflow.ellipsis,)

                                          ],),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        // InkWell(
                                        //   onTap: (){
                                        //     push(context: context, screen: ShowQR(qr:
                                        //     ongoingList[index].qrImage,));
                                        //   },
                                        //   child: Text("QR code",style: TextStyle
                                        //     (color:MyColors.primaryColor,fontWeight:
                                        //   FontWeight.bold),),
                                        // ),
                                        // SizedBox(height: 10)  ,
                                        InkWell(
                                            onTap: (){
                                              setState(() {
                                                BookingStatus = ongoingList[index].status.toString();
                                                BookingTime = ongoingList[index].dateTime.toString();
                                                BookingPickLocation = ongoingList[index].shipmentDetailsPickLocation.toString();
                                                BookingPickLocationTime = ongoingList[index].startTime.toString();
                                                BookingDropLocation = ongoingList[index].shipmentDetailsDropLocation.toString();
                                                BookingDropLocationTime = ongoingList[index].completeTime.toString();
                                                DriverId = ongoingList[index].driversId.toString();
                                                BookingPickLat = ongoingList[index].shipmentPickLat.toString();
                                                BookingPickLong = ongoingList[index].shipmentPickLon.toString();
                                                BookingDropLat = ongoingList[index].shipmentDropLan.toString();
                                                BookingDropLong = ongoingList[index].shipmentDropLon.toString();

                                              });

                                              MyGlobalKeys.tabBarKey.currentState!.onTap(2);
                                            },
                                            child:  Container(
                                              padding: EdgeInsets.symmetric(horizontal:
                                              12,vertical: 5),
                                              decoration: BoxDecoration(
                                                  color:MyColors.primaryColor,
                                                  borderRadius: BorderRadius.circular(25)
                                              ),
                                              child: Text("Track",style: TextStyle(color: Colors.white),),)
                                          // Image.asset("assets/images/google-maps.png",
                                          //   height: 25,width: 25,)
                                        ) ,
                                        SizedBox(height: 10,) ,
                                        InkWell(onTap: (){
                                          push(context: context, screen:
                                          ChatRoom(id: ongoingList[index]
                                              .driversId)) ;
                                        },child:   SvgPicture.asset("assets/images/ChatIcon"
                                            ".svg",  height: 50),)

                                      ],
                                    )

                                  ],
                                ),
                                SizedBox(height: 12,),
                                Container(
                                  child: Row(children: [
                                    Text('Destination :',style: GoogleFonts.beVietnamPro(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: MyColors.greycolor
                                    ),),
                                    SizedBox(width: 15,),
                                    Container(width: 150,
                                      child: Text(ongoingList[index].shipmentDetailsDropLocation,style:
                                      GoogleFonts.beVietnamPro(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.greycolor
                                      ),overflow: TextOverflow.ellipsis,),
                                    )

                                  ],),
                                ),
                                // SizedBox(height: 12,),
                                // Row(children: [
                                //   Text('Payment :',style: GoogleFonts.beVietnamPro(
                                //       fontSize: 12,
                                //       fontWeight: FontWeight.w700,
                                //       color: MyColors.greycolor
                                //   ),),
                                //   SizedBox(width: 35,),
                                //   Text("Master Card",style: GoogleFonts.beVietnamPro(
                                //       fontSize: 12,
                                //       fontWeight: FontWeight.w500,
                                //       color: MyColors.greycolor
                                //   ),)
                                //
                                // ],),
                                SizedBox(height: 12,),
                                Row(children: [
                                  Text('Order Date :',style: GoogleFonts.beVietnamPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: MyColors.greycolor
                                  ),),
                                  SizedBox(width: 20,),
                                  Text(DateFormat('dd MMM yyyy').format
                                    (ongoingList[index].dateTime),style: GoogleFonts.beVietnamPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.greycolor
                                  ),)

                                ],),
                                SizedBox(height: 12,),
                                Row(children: [
                                  Text('Status :',style: GoogleFonts.beVietnamPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: MyColors.greycolor
                                  ),),
                                  SizedBox(width: 20,),
                                  Text("Your shipment has been ${ongoingList[index].status}",style: GoogleFonts.beVietnamPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.greycolor
                                  ),)

                                ],),
                              ],),
                          ),
                        ),
                      );
                    })
            ),
          ),)

    );
  }
}

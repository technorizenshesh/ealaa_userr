import 'package:ealaa_userr/Model/GetShipmentStatusListModel.dart';
import 'package:ealaa_userr/View/Utils/ApiConstants.dart';
import 'package:ealaa_userr/View/Utils/CustomSnackBar.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/View/Utils/webService.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:intl/intl.dart';

import 'OrderDetailScreen.dart';

class PastOrder extends StatefulWidget {
  const PastOrder({Key? key}) : super(key: key);

  @override
  State<PastOrder> createState() => _PastOrderState();
}

class _PastOrderState extends State<PastOrder> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool showLoader = true;
  List<GetShipmentStatusListResult> completedList = [];
  getPastList() async {
    var res = await Webservices.getMap(
        "$get_shipment_list?driver_id=$userId&status=Complete&type=USER");
    print("status from api ${res}");
    showLoader=false;
    final resdata = GetShipmentStatusListModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      completedList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getPastList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
          RefreshIndicator(key:_refreshIndicatorKey,color: Colors.white,
              backgroundColor: MyColors.primaryColor ,
              strokeWidth: 2,onRefresh: ()async{
            getPastList();
            setState(() {
            });
          },
          child:         showLoader?
          Container(height:100,child:
          Center(child:  CircularProgressIndicator(color:
          MyColors
              .primaryColor,))
          )
              :completedList.isEmpty?
          Image
              .asset("assets/images/NoDataFound.png")
              : SingleChildScrollView(
            child: Container(
              width: width,
              height: height,
              child: ListView.builder(
                  itemCount: completedList.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: ()async {
                        push(context: context,screen:OrderDetailScreen
                          (shipmentId: completedList[index].shipmentDetailsId, qr:
                        completedList[index].qrImage,amount:completedList[index].companyAmount,name: completedList[index].shipmentDetailsSenderName,paymentStatus: completedList[index].paymentStatus,));
                        await getPastList();
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(left: 8,right: 8,top: 20),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xfff6f7fc)
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Row(children: [
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
                                                imageUrl:completedList[index].shipmentDetailsPhoto,
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
                                      SizedBox(width: 15,),
                                      Text(completedList[index].shipmentDetailsReceiverName,style: GoogleFonts
                                          .beVietnamPro(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: MyColors.blackcolor
                                      ),),
                                    ],),
                                  ),
                                  Text(completedList[index].paymentStatus,style: GoogleFonts
                                      .beVietnamPro(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: MyColors.primaryColor
                                  ),)

                                ],
                              ),
                              SizedBox(height: 12,),
                              Row(children: [
                                Text('Destination :',style: GoogleFonts.beVietnamPro(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: MyColors.greycolor
                                ),),
                                SizedBox(width: 15,),
                                Container(
                                  width: 150,
                                  child: Text(completedList[index].shipmentDetailsDropLocation,style:
                                  GoogleFonts.beVietnamPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.greycolor
                                  ),
                                      overflow: TextOverflow.ellipsis),
                                )

                              ],),
                              SizedBox(height: 12,),
                              Row(children: [
                                Text('Order Date :',style: GoogleFonts.beVietnamPro(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: MyColors.greycolor
                                ),),
                                SizedBox(width: 20,),
                                Text(DateFormat('dd MMM yyyy').format
                                  (completedList[index].dateTime)
                                  ,style:
                                  GoogleFonts
                                      .beVietnamPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.greycolor
                                  ),)

                              ],)
                            ],),
                        ),
                      ),
                    );
                  }),
            ),
          ))

      //     :
      // Center(child: CircularProgressIndicator(color: AppColors.primeryColor,),),
    );
  }
}

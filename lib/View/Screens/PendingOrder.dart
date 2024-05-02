import 'package:ealaa_userr/View/Screens/DriverDetailFinalScreen.dart';
import 'package:ealaa_userr/View/Screens/IndividualOffersScreen.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../Model/GetShipmentStatusListModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';

class PendingOrder extends StatefulWidget {
  const PendingOrder({Key? key}) : super(key: key);

  @override
  State<PendingOrder> createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<GetShipmentStatusListResult> pendingList = [];
  bool showLoader = true;

  getPendingList() async {
    var res = await Webservices.getMap(
        "$get_shipment_list?driver_id=$userId&status=Pending&type=USER");
    showLoader=false;
    print("status from api ${res}");
    final resdata = GetShipmentStatusListModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      pendingList = resdata.result;

    } else {
      showSnackbar(context, resdata.message);
    }
    setState(() {});
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      print("my notification....0")  ;
      if(pendingNotification!=0){
        getPendingList();
        print("my notification")  ;
        pendingNotification=0;
      }
    });
    getPendingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:RefreshIndicator(  key: _refreshIndicatorKey,
          color: Colors.white,
          backgroundColor: MyColors.primaryColor ,
          strokeWidth: 2,
          onRefresh: ()async{
            getPendingList();
            setState(() {
            });
          },child:          showLoader?
        Container(height:100,child:
            Center(child:  CircularProgressIndicator(color:
            MyColors
                .primaryColor,))
       )
            :pendingList.isEmpty?
        Image
            .asset("assets/images/NoDataFound.png")
              : Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: width,
                    height: height,
                    child:
                    ListView.builder(
                        itemCount: pendingList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                              onTap: () async {
                                String dimension =
                                    "${pendingList[index].shipmentDetailsLength}${pendingList[index].shipmentDetailsSizeUnit} * ${pendingList[index].shipmentDetailsWidth}${pendingList[index].shipmentDetailsSizeUnit} * ${pendingList[index].shipmentDetailsHeight}${pendingList[index].shipmentDetailsSizeUnit}";

                                await push(
                                    context: context,
                                    screen: IndividualOffersScreen(
                                      shipmentId: pendingList[index]
                                          .shipmentDetailsId,
                                      name: pendingList[index]
                                          .shipmentDetailsSenderName,
                                      recieverName: pendingList[index]
                                          .shipmentDetailsReceiverName,
                                      postalcode: pendingList[index]
                                          .shipmentDetailsReceiverPostalCode,
                                      recieverNumber: pendingList[index]
                                          .shipmentDetailsReceiverPhoneNumber,
                                      dimension: dimension,
                                      weight:
                                      "${pendingList[index].shipmentDetailsWeight}${pendingList[index].shipmentDetailsWeightUnit} ",
                                      address: pendingList[index]
                                          .shipmentDetailsDropLocation,
                                      proImage: pendingList[index]
                                          .shipmentDetailsPhoto, amount: pendingList[index].companyAmount,
                                    ));
                                getPendingList();
                              },
                              child: Column(
                                children: [
                                  // pendingList[index].shipmentType=="Individual"&&pendingList[index].paymentStatus=="unpaid"?Container():
                                  Container(
                                    width: width,
                                    height: height * 0.18,
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 0.5,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 8,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                  20,
                                                  10,
                                                  0,
                                                  10,
                                                ),
                                                child:
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .spaceBetween,
                                                    //   children: [
                                                    //     Text(
                                                    //       allList[index]
                                                    //           .dateTime
                                                    //           .toString(),
                                                    //       style: TextStyle(
                                                    //           fontSize: 12),
                                                    //     ),
                                                    //     Padding(
                                                    //       padding:
                                                    //           const EdgeInsets
                                                    //               .only(
                                                    //               right: 8.0),
                                                    //       child: Text("\$${allList[index].companyAmount}",
                                                    //         style: TextStyle(
                                                    //             color: MyColors
                                                    //                 .primaryColor,
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold,
                                                    //             fontSize: 15),
                                                    //       ),
                                                    //     )
                                                    //   ],
                                                    // ),
                                                    // SizedBox(
                                                    //   height: height * 0.02,
                                                    // ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 8.0),
                                                      child: Row(
                                                        children: [Text("Shipment id: ",style: TextStyle(fontWeight: FontWeight.w500),),
                                                          Text(pendingList[index].shipmentDetailsId,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w500),),

                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(children: [
                                                          Icon(
                                                            Icons
                                                                .circle_outlined,
                                                            color: Colors.grey,
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: width*0.52,
                                                            child: Text(pendingList[index]
                                                                .shipmentDetailsPickLocation,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w500),),
                                                          ),
                                                        ],),
                                                        // Text("\$${pendingList[index].companyAmount}",
                                                        //   style: TextStyle(
                                                        //       color: Colors.black,
                                                        //       fontWeight:
                                                        //       FontWeight.w500,
                                                        //       fontSize: 15),
                                                        // ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 10,
                                                          top: 1,
                                                          bottom: 1),
                                                      child: Container(
                                                        width: 1,
                                                        height: 28,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              color: Colors.grey,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              width: width*0.52,
                                                              child: Text(pendingList[index]
                                                                  .shipmentDetailsDropLocation,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w500)),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Color(0xffFFC700).withOpacity(0.3)),
                                                          child: Text(pendingList[index].status,style: TextStyle(color: Color(0xffFFC700),fontSize: 12),),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          // Expanded(
                                          //     flex: 1,
                                          //     child: Container(
                                          //       height: height,
                                          //       decoration: BoxDecoration(
                                          //         borderRadius:
                                          //             BorderRadius.all(
                                          //                 Radius.circular(
                                          //                     12)),
                                          //         color: allList[index]
                                          //                     .status ==
                                          //                 "Pending"
                                          //             ? MyColors.primaryColor
                                          //             : allList[index].status ==
                                          //                         "Start" ||
                                          //                     allList[index]
                                          //                             .status ==
                                          //                         "Accept"
                                          //                 ? Colors.blue
                                          //                 : allList[index]
                                          //                             .status ==
                                          //                         "Complete"
                                          //                     ? Colors.green
                                          //                     : allList[index]
                                          //                                 .status ==
                                          //                             "Cancel"
                                          //                         ? Colors.red
                                          //                         : Colors
                                          //                             .grey,
                                          //       ),
                                          //       child: RotatedBox(
                                          //         quarterTurns: 3,
                                          //         child: Center(
                                          //           child: Text(
                                          //             allList[index].status,
                                          //             style: TextStyle(
                                          //                 color:
                                          //                     Colors.white),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        }),
                  ),
                ),
              ),
            ],
          ),)

    );
  }
}

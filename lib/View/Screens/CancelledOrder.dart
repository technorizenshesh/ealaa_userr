import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../Model/GetShipmentStatusListModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';

class CancelledOrder extends StatefulWidget {
  const CancelledOrder({super.key});

  @override
  State<CancelledOrder> createState() => _CancelledOrderState();
}

class _CancelledOrderState extends State<CancelledOrder> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  List<GetShipmentStatusListResult> cancelledList = [];
  bool showLoader = true;

  getCancelledList() async {
    var res = await Webservices.getMap(
        "$get_shipment_list?driver_id=$userId&status=Cancel&type=USER");
    print("status from api ${res}");
    showLoader = false;
    final resdata = GetShipmentStatusListModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      cancelledList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if(cancelNotification!=0){
        getCancelledList();
        print("my cancel notification")  ;
        cancelNotification=0;
      }
    });
    getCancelledList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body:
        RefreshIndicator(key: _refreshIndicatorKey,color:MyColors.primaryColor,onRefresh: ()async{
          getCancelledList();
          setState(() {

          });
        },
          child:   showLoader
              ? Container(
              height: 100,
              child: Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  )))
              :  cancelledList.isEmpty
              ? Image.asset("assets/images/NoDataFound.png")
              :Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: width,
                    //height: height,
                    child: ListView.builder(
                        itemCount: cancelledList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                              onTap: () async{
                                // await push(
                                //     context: context,
                                //     screen: DetailsScreen(
                                //       pendingShipmentData: cancelledList[index],
                                //     ));
                                // getCancelledList();
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: width,
                                    height: height * 0.15,
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
                                                child: Column(
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
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .circle_outlined,
                                                              color:
                                                              Colors.grey,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              width: width *
                                                                  0.52,
                                                              child: Text(
                                                                cancelledList[
                                                                index]
                                                                    .shipmentDetailsPickLocation,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "\$${cancelledList[index].companyAmount}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize: 15),
                                                        ),
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
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              color:
                                                              Colors.grey,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              width: width *
                                                                  0.52,
                                                              child: Text(
                                                                  cancelledList[
                                                                  index]
                                                                      .shipmentDetailsDropLocation,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.w500)),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              8,
                                                              vertical:
                                                              5),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  10)),
                                                              color: Colors.red.withOpacity(0.3)
                                                                  .withOpacity(
                                                                  0.3)),
                                                          child: Text(
                                                            cancelledList[
                                                            index]
                                                                .status,
                                                            style: TextStyle(
                                                                color: Colors.red,
                                                                fontSize: 12),
                                                          ),
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

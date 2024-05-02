import 'package:ealaa_userr/View/Store/OrderDetailScreen.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../Model/StoreModel/GetStoreOngoingModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';

class OngoingStoreOrder extends StatefulWidget {
  const OngoingStoreOrder({Key? key}) : super(key: key);

  @override
  State<OngoingStoreOrder> createState() => _OngoingStoreOrderState();
}

class _OngoingStoreOrderState extends State<OngoingStoreOrder> {
  @override
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<GetStoreOngoingResult> ongoingList = [];
  bool showLoader = true;

  getAllOrderList() async {
    var res = await Webservices.getMap(
        "$get_user_order_details?user_id=$userId&status=Accept");
    print("status from api ${res}");
    final resdata = GetStoreOngoingModel.fromJson(res);
    print(resdata);
    showLoader = false;
    if (resdata.status == '1') {
      ongoingList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message!);
    }
  }

  @override
  void initState() {
    getAllOrderList();
    super.initState();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: RefreshIndicator(
      key: _refreshIndicatorKey,
      color: MyColors.primaryColor,
      onRefresh: () async {
        getAllOrderList();
        setState(() {});
      },
      child: showLoader
          ? Container(
              height: 100,
              child: Center(
                  child: CircularProgressIndicator(
                color: MyColors.primaryColor,
              )))
          : ongoingList.isEmpty
              ? Image.asset("assets/images/NoDataFound.png")
              : Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            itemCount: ongoingList.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      push(
                                          context: context,
                                          screen: OrderDetailScreen(
                                            orderDetails: ongoingList[index],
                                          ));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: MyColors.primaryColor
                                                    .withOpacity(0.5),
                                                width: 1.5)),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Order Id",
                                                  style: TextStyle(
                                                      color: MyColors
                                                          .primaryColor,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "Items",
                                                  style: TextStyle(
                                                      color: MyColors
                                                          .primaryColor,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "Total Amount",
                                                  style: TextStyle(
                                                      color: MyColors
                                                          .primaryColor,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "Order Date",
                                                  style: TextStyle(
                                                      color: MyColors
                                                          .primaryColor,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "Order Time",
                                                  style: TextStyle(
                                                      color: MyColors
                                                          .primaryColor,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color:
                                                          MyColors.primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color:
                                                          MyColors.primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color:
                                                          MyColors.primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color:
                                                          MyColors.primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color:
                                                          MyColors.primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ongoingList[index].id!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  ongoingList[index]
                                                      .productDetails!
                                                      .length
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "\$ ${ongoingList[index].amount!}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  ongoingList[index]
                                                      .orderDate!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  ongoingList[index]
                                                      .orderTime!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                        // ListTile(leading: Container(
                                        //   decoration: BoxDecoration(
                                        //     shape: BoxShape.circle,
                                        //     border: Border.all(
                                        //       color: MyColors.primaryColor.withOpacity(0.5), // Border
                                        //       // color
                                        //       width: 2.0, // Border width
                                        //     ),
                                        //   ),
                                        //   child: ClipRRect(
                                        //     borderRadius: BorderRadius.circular(50),
                                        //     child: CachedNetworkImage(
                                        //       imageUrl: ongoingList[index].productImage!,
                                        //       width: 50,
                                        //       height: 50,
                                        //       fit: BoxFit.cover,
                                        //       placeholder: (context, url) =>
                                        //           Center(child: CircularProgressIndicator
                                        //             (color: MyColors.primaryColor,strokeWidth:
                                        //           2,)),
                                        //       errorWidget: (context, url, error) =>
                                        //           Icon(Icons.error),
                                        //     ),
                                        //   ),
                                        // ),
                                        //     title: Text(ongoingList[index].productName!,
                                        //       style: TextStyle(fontWeight: FontWeight
                                        //           .bold,fontSize: 20),),subtitle: Text
                                        //       ("\$ ${ongoingList[index].productPrice!}",style:
                                        //     TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                        //     trailing:
                                        //     Padding(padding: EdgeInsets.only(top: 5),child:
                                        //     Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                        //       Text("Total Amount",style:  TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                        //       Text
                                        //         ("\$ ${ongoingList[index].amount!}",style:
                                        //       TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),],),)
                                        // ),
                                        ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ),
    ));
  }
}

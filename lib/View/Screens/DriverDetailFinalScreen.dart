import 'package:ealaa_userr/Model/DriverApproveModel.dart';
import 'package:ealaa_userr/Model/DriverDetailModel.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class DriverDetailFinalScreen extends StatefulWidget {
  final String dId, driverAmount, shipmentId;

  const DriverDetailFinalScreen(
      {Key? key, required this.dId, required this.driverAmount, required this.shipmentId})
      : super(key: key);

  @override
  State<DriverDetailFinalScreen> createState() =>
      _DriverDetailFinalScreenState();
}

class _DriverDetailFinalScreenState extends State<DriverDetailFinalScreen> {
  DriverDetailResult? driverDetailResult;

  getDriverDetail() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_driver_by_id?driver_id=${widget.dId}");
    print("status from api ${res}");
    final resdata = DriverDetailModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      driverDetailResult = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  orderPlace() async {
    Map<String, dynamic> data = {
      "shipment_id": widget.shipmentId,
      'driver_id': widget.dId,
      'amount': widget.driverAmount
    };

    print("data..........$data");
    var res = await Webservices.postData(
        apiUrl: "$add_driver_approve", body: data, context: context);
    print("status from api ${res}");
    final resdata = DriverApproveModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Success(orderId:resdata.result.shipmentOrderId,)));
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
    getDriverDetail();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset("assets/images/backButton.svg")),
        ),
        title: MainHeadingText(
          text: "Driver Details",
          textAlign: TextAlign.center,
          fontSize: 20,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset("assets/images/roundedSearch.png"),
          )
        ],
        backgroundColor: Colors.white,
      ),
      // bottomNavigationBar:  (widget.shipmentBids=="true")?
      //   Padding(
      //     padding: EdgeInsets.only(bottom: 20),
      //     child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       InkWell(
      //           onTap: () {
      //             orderPlace();
      //           },
      //           child: Image.asset(
      //               "assets/images/rightIcon.png")),
      //       SizedBox(
      //         width: width * 0.15,
      //       ),
      //       InkWell(
      //           onTap: () {
      //             Navigator.pop(context);
      //           },
      //           child: Image.asset(
      //               "assets/images/crossIcon.png"))
      //     ],
      // ),
      //   ):Container(width: 10,
      // height: 10,),
      body: driverDetailResult == null
          ? Container()
          :
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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
                          driverDetailResult!.drImage,
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
                    driverDetailResult!.drFullName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(driverDetailResult!.drEmail,
                      style: TextStyle(
                          fontSize: 15, color: Colors.grey)),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                MainHeadingText(
                  text: "Vehicle type",
                  textAlign: TextAlign.center,
                  fontSize: 20,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  driverDetailResult!.drVehicalType,
                  style: TextStyle(fontSize: 16),
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
                      driverDetailResult!.range.country,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                Row(
                  children: [
                    Text(
                      "Within City - ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      driverDetailResult!.range.city,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03
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
                          fontSize: 15,
                          color: MyColors.primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                if (driverDetailResult!.review.isEmpty)
                  Text("No Reviews found")
                else
                  for (int i = 0;
                  i < driverDetailResult!.review.length;
                  i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(50),
                              border: Border.all(
                                  color: MyColors.primaryColor),
                            ),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: driverDetailResult!
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
                            driverDetailResult!.review[i].userName,
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
                                  driverDetailResult!.review[i].reviewDriverRating,
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
                          driverDetailResult!
                              .review[i].reviewDriverComment,
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
    );
  }
}

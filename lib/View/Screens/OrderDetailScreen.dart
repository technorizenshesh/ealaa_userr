import 'package:ealaa_userr/Model/ApproveShipmentDetailModel.dart';
import 'package:ealaa_userr/Model/QRImageModel.dart';
import 'package:ealaa_userr/View/Screens/web_view_screen.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';
import 'DriverDetailScreen.dart';

class OrderDetailScreen extends StatefulWidget {
  final String shipmentId, qr;
  final String? amount, name, paymentStatus;

  const OrderDetailScreen(
      {Key? key,
      required this.shipmentId,
      required this.qr,
      this.amount,
      this.name,
      this.paymentStatus})
      : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  ApproveShipmentDetailResult? dataResult;
  String qrImage = "";
  String message = "";
  WebViewController webController = WebViewController();

  getDetail() async {
    print("shhss.....${widget.shipmentId}");
    var res = await Webservices.getMap(
        "$baseUrl$get_approve_shipment_details?shipment_details_id=${widget.shipmentId}");
    print("status from api ${res}");
    final resdata = ApproveShipmentDetailModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      dataResult = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  getQR() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_nearbuy_shipment?shipment_details_id=${widget.shipmentId}&user_id=$userId");
    print("status from api is nearby ${res}");
    final resdata = QRImageModel.fromJson(res);
    if (resdata.status== '1') {
      qrImage = resdata.result.qrImage;
      message = resdata.result.qr1;
      print("qr image is....$qrImage");
      setState(() {});
    } else {}
  }

  // payment() async {
  //   String url = 'https://11way.solutions/EalaaDarbik/webservice/payment?amount=${widget.amount}&user_id=$userId&shipment_id=${widget.shipmentId}&name=${widget.name}';
  //   print("url is....$url");
  //   final uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  payment() async {
    String url =
        '${baseUrl}payment?amount=${widget.amount}&user_id=$userId&shipment_id=${widget.shipmentId}&name=${widget.name}';
    /* print("url is....$url");
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }*/
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WebViewScreen(url: url, shipmentId: widget.shipmentId, type: 'Individual',),
        ));
  }

  @override
  void initState() {
    getDetail();
    getQR();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset("assets/images/backButton.svg")),
            ),
            centerTitle: true,
            title: Text("Order",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ))),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          color: Colors.white,
          backgroundColor: MyColors.primaryColor,
          strokeWidth: 2,
          onRefresh: () async {
            getQR();
            setState(() {});
          },
          child: dataResult == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(onTap: (){
                            push(context: context, screen: DriverDetail());
                          },
                          child:      ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            // Adjust the border radius as needed
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.transparent, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    imageUrl: dataResult!.cmDrImage,
                                    width: 53,
                                    height: 53,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )
                              // Image.asset(
                              //   MyImages.user,
                              //   width: 53,
                              // ),
                            ),
                          ),) ,

                          // Image.network(dataResult!.cmDrImage,height: 45,),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            dataResult!.cmDrName,
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: MyColors.blackcolor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Center( child:ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:dataResult!.shipmentDetailsPhoto,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(child:
                          CircularProgressIndicator(color: MyColors.primaryColor,)),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipment Id :',
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: MyColors.greycolor),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 200,
                            child: Text(dataResult!.shipmentDetailsId,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.greycolor,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pick Location :',
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: MyColors.greycolor),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 200,
                            child: Text(dataResult!.shipmentDetailsPickLocation,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.greycolor,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Drop Location :',
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: MyColors.greycolor),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 200,
                            child: Text(dataResult!.shipmentDetailsDropLocation,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.greycolor,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Shipment Status :',
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: MyColors.greycolor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            dataResult!.status,
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: MyColors.greycolor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            'Amount :',
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: MyColors.greycolor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            dataResult!.companyAmount,
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: MyColors.greycolor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Order Date :',
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: MyColors.greycolor),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            dataResult!.dateTime.toString(),
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: MyColors.greycolor),
                          )
                        ],
                      ),
                      // SizedBox(
                      //     height:
                      //         dataResult!.shipmentType == "Company" ? 200 : 50),
                      // dataResult!.shipmentType == "Company"
                      //     ? widget.paymentStatus == "unpaid"
                      //         ? RoundButton(
                      //             title: "Pay",
                      //             onTap: () async {
                      //               String url =
                      //                   'https://11way.solutions/webservice/payment?amount=100&user_id=$userId&shipment_id=${widget.shipmentId}&name=${widget.name}';
                      //               print("url::::::::::::::::::::::$url");
                      //               Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                     builder: (context) => WebViewScreen(
                      //                         url: url,
                      //                         shipmentId: widget.shipmentId, type: "Company",),
                      //                   ));
                      //               //await payment();
                      //               //Navigator.pop(context);
                      //             })
                      //         : Container()
                      //     : Column(
                      //         children: [
                      //           CachedNetworkImage(
                      //               imageUrl: qrImage,
                      //               fit: BoxFit.cover,
                      //               placeholder: (context, url) => Center(
                      //                   child: CircularProgressIndicator()),
                      //               errorWidget: (context, url, error) => Row(
                      //                     children: [
                      //                       Text("*",
                      //                           style: TextStyle(
                      //                               color:
                      //                                   MyColors.primaryColor)),
                      //                       SizedBox(
                      //                         width: 10,
                      //                       ),
                      //                       Flexible(
                      //                         child: Text(
                      //                             "QR"
                      //                             " will be "
                      //                             "visible when driver reached your location",
                      //                             style: TextStyle(
                      //                                 color: MyColors
                      //                                     .primaryColor)),
                      //                       ),
                      //                     ],
                      //                   )),
                      //           //   Image.network(widget.qr),
                      //           qrImage == "" || qrImage == null
                      //               ? Text("")
                      //               : GestureDetector(
                      //                   onTap: () {
                      //                     //  _shareQRImage();
                      //                     share();
                      //                   },
                      //                   child: Text(
                      //                     message,
                      //                     style: TextStyle(
                      //                         color: MyColors.primaryColor),
                      //                   ),
                      //                 )
                      //         ],
                      //       )      //this is code for show qr code
                    ],
                  ),
                ),
        ));
  }

  Future _shareQRImage() async {
    final image = await QrPainter(
      data: widget.qr,
      version: QrVersions.auto,
      gapless: false,
      color: Colors.black,
      emptyColor: Colors.white,
    ).toImageData(200.0);
    print('image::::::${image}');
  }

 Future<void> share() async {
   try {
     Uri uri = Uri.parse(qrImage);
      Share.shareUri(uri);
   } catch (e) {
     print('Share Error: $e');
   }
 }


}

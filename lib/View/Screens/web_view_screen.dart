import 'package:ealaa_userr/Model/GeneralModel.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Model/ShipmentDetailDriverModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';
import 'IndividualOffersScreen.dart';

class WebViewScreen extends StatefulWidget {
  String url = '';
  final String shipmentId;
  final String type;
  final ShipmentDetailDriverResult? shipmentDetailResult;

  WebViewScreen({Key? key, required this.url, required this.shipmentId, required this.type, this.shipmentDetailResult})
      : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController webController = WebViewController();

  updatePaymentStatus(String status) async {
    var res = await Webservices.getMap(
        "$baseUrl$update_payment_status?shipment_id=${widget.shipmentId}&payment_status=$status");
    print("status from apiiii ${res}");
    final resdata = GeneralModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      if(widget.type=="Company"){
        Navigator.pop(context);
      }
      else if(widget.type=="Individual"){
        if(status=="paid"){
          String dimension =
              "${widget.shipmentDetailResult!.shipmentDetailsLength}${widget.shipmentDetailResult!.shipmentDetailsSizeUnit} * ${widget.shipmentDetailResult!.shipmentDetailsWidth}${widget.shipmentDetailResult!.shipmentDetailsSizeUnit} * ${widget.shipmentDetailResult!.shipmentDetailsHeight}${widget.shipmentDetailResult!.shipmentDetailsSizeUnit}";
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>IndividualOffersScreen(shipmentId: widget.shipmentDetailResult!.shipmentDetailsId, name:widget.shipmentDetailResult!.shipmentDetailsSenderName, recieverName:widget.shipmentDetailResult!.shipmentDetailsReceiverName, postalcode: widget.shipmentDetailResult!.shipmentDetailsReceiverPostalCode, recieverNumber:widget.shipmentDetailResult!.shipmentDetailsReceiverPhoneNumber, dimension: dimension, weight:"${widget.shipmentDetailResult!.shipmentDetailsWeight}${widget.shipmentDetailResult!.shipmentDetailsWeightUnit}", address: widget.shipmentDetailResult!.shipmentDetailsDropLocation, proImage: widget.shipmentDetailResult!.shipmentDetailsPhoto, amount: widget.shipmentDetailResult!.companyAmount,),
              ),
                  (route) => false);
        }
        else{
          Navigator.pop(context);
        }

      }
    } else {
      showSnackbar(context, resdata.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: webController),
    );
  }

  @override
  void initState() {
    print("widget url is..........${widget.url}");
    super.initState();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) async {
            print("url::::::::::::::::::::::::::::${url}");
           print("successsss url is....${baseUrl}success");
            print("successsss url is....${baseUrl}");
            print('...............${url.contains(
                '${baseUrl}success')}')   ;
            if (url.contains(
                '${baseUrl}success')) {
              print("successsss url is....${baseUrl}success");
              updatePaymentStatus("paid");
              showSnackbar(context, "payment successful");
            } else if (url.contains(
                '${baseUrl}cancel')) {
              print("cancelll url is....${baseUrl}cancel");
              updatePaymentStatus("unpaid");
              showSnackbar(context, "You cancelled the payment");
              print("cancel");
            } else {
              showSnackbar(context, "not supporting data");
              print("Other");
            }
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              print("launch url is....${widget.url}") ;
              return NavigationDecision.prevent;
            }
            print("launch url1 is....${widget.url}") ;
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
}

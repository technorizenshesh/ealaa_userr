import 'package:ealaa_userr/Model/GetNearbyCompanyModel.dart';
import 'package:ealaa_userr/Model/ShipmentDetailModel.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../Model/ShipmentBooking.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class CompanyOffersScreen extends StatefulWidget {
  final ShipmentDetailResult shipmentDetailResult;

  const CompanyOffersScreen({Key? key, required this.shipmentDetailResult})
      : super(key: key);

  @override
  State<CompanyOffersScreen> createState() => _CompanyOffersScreenState();
}

class _CompanyOffersScreenState extends State<CompanyOffersScreen> {
  List<GetNearbyCompanyResult> nearbyCompaniesList=[];
  bool loader = false;

  getNearbyCompanies() async {
    Map<String, dynamic> data = {"shipment_details_id":widget.shipmentDetailResult.shipmentDetailsId};

    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_nearbuy_company", body: data, context: context);
    print("status from api ${res}");
    final resdata = GetNearbyCompanyModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      nearbyCompaniesList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }
  orderPlace() async {
    Map<String, dynamic> data = {
      "company_id": nearbyCompaniesList[0].cmId,
      'company_amount': nearbyCompaniesList[0].vehiclesAmount,
      'shipment_details_id': widget.shipmentDetailResult.shipmentDetailsId
    };

    var res = await Webservices.postData(
        apiUrl: "$baseUrl$shipment_booking", body: data, context: context);
    print("status from api ${res}");
    final resdata = ShipmentBookingModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Success(orderId:resdata.shipmentOrderId,)));
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
    getNearbyCompanies();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          text: "Company Offers",
          textAlign: TextAlign.center,
          fontSize: 20,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
     bottomNavigationBar: Padding(
       padding: EdgeInsets.symmetric(horizontal: 20),
       child: RoundButton(
         loading: loader,
         title: "Save",
         onTap: (){
           orderPlace();
         },
       ),
     ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width:200,height:150,child: Image.network(widget.shipmentDetailResult.shipmentDetailsPhoto,fit: BoxFit.contain,))),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingText(
                          text: 'Sender Name',
                          fontWeight: FontWeight.bold,
                          maxlines: 1,
                        ),
                        ParagraphText(
                          text: widget
                              .shipmentDetailResult.shipmentDetailsSenderName,
                          maxlines: 1,
                          fontSize: 16,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        headingText(
                          text: 'Postal Code',
                          fontWeight: FontWeight.bold,
                          maxlines: 1,
                          fontSize: 16,
                        ),
                        ParagraphText(
                          text:widget.shipmentDetailResult.shipmentDetailsReceiverPostalCode,
                          maxlines: 1,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        headingText(
                          text: 'Size',
                          fontWeight: FontWeight.bold,
                          maxlines: 1,
                        ),
                        ParagraphText(
                          text:
                              '${widget.shipmentDetailResult.shipmentDetailsLength}${widget.shipmentDetailResult.shipmentDetailsSizeUnit} * ${widget.shipmentDetailResult.shipmentDetailsWidth}${widget.shipmentDetailResult.shipmentDetailsSizeUnit} * ${widget.shipmentDetailResult.shipmentDetailsHeight}${widget.shipmentDetailResult.shipmentDetailsSizeUnit}',
                          maxlines: 1,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingText(
                          text: 'Reciever Name',
                          fontWeight: FontWeight.bold,
                          maxlines: 1,
                        ),
                        ParagraphText(
                          text: widget
                              .shipmentDetailResult.shipmentDetailsReceiverName,
                          maxlines: 1,
                          fontSize: 16,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        headingText(
                          text: 'Reciever Phone Number',
                          fontWeight: FontWeight.bold,
                          maxlines: 1,
                        ),
                        ParagraphText(
                          text: widget.shipmentDetailResult
                              .shipmentDetailsReceiverPhoneNumber,
                          maxlines: 1,
                          fontSize: 16,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        headingText(
                          text: 'Weight',
                          fontWeight: FontWeight.bold,
                          maxlines: 1,
                        ),
                        ParagraphText(
                          text:
                              "${widget.shipmentDetailResult.shipmentDetailsWeight} ${widget.shipmentDetailResult.shipmentDetailsWeightUnit}",
                          maxlines: 1,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              headingText(
                text: 'Drop Location',
                fontWeight: FontWeight.bold,
              ),
              ParagraphText(
                text: widget.shipmentDetailResult.shipmentDetailsDropLocation,
                fontSize: 16,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingText(
                    text: 'Company Submitted Offers',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  IconButton(onPressed: (){
                    push(context: context, screen: MapList(markerList: nearbyCompaniesList, isCompany: true,));
                  }, icon: Image.asset("assets/images/google-maps.png",height: 25,width: 25,))
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              if(nearbyCompaniesList.isEmpty)
                Center(child: CircularProgressIndicator())
              else
              for (int index = 0; index <1; index++)
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading:
                  Container(
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
                          nearbyCompaniesList[index].cmCompanyImage,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )),
                  //  horizontalTitleGap: 2,
                  title: Text(
                    nearbyCompaniesList[index].cmCompanyName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text("\$${nearbyCompaniesList[index].vehiclesAmount}",
                      style: TextStyle(
                          fontSize: 16,
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.bold)),
                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       CupertinoPageRoute(
                  //           builder: (context) => CompanyDetailFinalScreen(cId: nearbyCompaniesList[index].cmId, companyAmount: nearbyCompaniesList[index].vehiclesAmount, shipmentId:widget.shipmentDetailResult.shipmentDetailsId,)));
                  // },
                )
            ],
          ),
        ),
      ),
    );
  }
}

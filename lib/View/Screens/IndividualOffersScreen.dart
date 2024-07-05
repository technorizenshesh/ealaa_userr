import 'package:ealaa_userr/Model/IndividualOffersModel.dart';
import 'package:ealaa_userr/View/Utils/bottom_bar.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';
import 'DriverDetailFinalScreen.dart';

class IndividualOffersScreen extends StatefulWidget {
  final String shipmentId,name, recieverName, postalcode,recieverNumber,dimension,weight,address,proImage, amount;
  const IndividualOffersScreen({Key? key, required this.shipmentId, required this.name, required this.recieverName, required this.postalcode, required this.recieverNumber, required this.dimension, required this.weight, required this.address, required this.proImage, required this.amount,}) : super(key: key);

  @override
  State<IndividualOffersScreen> createState() => _IndividualOffersScreenState();
}

class _IndividualOffersScreenState extends State<IndividualOffersScreen> {
  IndividualOffersResult? result;
  List<Driver> nearestDriverList = [];

  getNearByDrivers() async {
    print("shipment_details_id...${widget.shipmentId}");
    Map<String, dynamic> data = {"shipment_details_id":widget.shipmentId};
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_shipment_driver", body: data, context: context);
    print("status from api1 ${res}");
    final resdata = IndividualOffersModel.fromJson(res);
    print("status is .....${resdata.status}");
    if (resdata.status == '1') {
      result = resdata.result;
      nearestDriverList = result!.driver;
      setState(() {

      });
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
    getNearByDrivers();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Bottom_bar(key: MyGlobalKeys.tabBarKey)),
        );
        // Return true to prevent the default back button behavior
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          toolbarHeight: 70,
          leading: InkWell(
            onTap: () {
              pushReplacement(context: context, screen: Bottom_bar(key: MyGlobalKeys.tabBarKey,));          },
            child: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset("assets/images/backButton.svg")),
          ),
          title: MainHeadingText(
            text: "Individual Offers",
            textAlign: TextAlign.center,
            fontSize: 20,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width:width,height:200,child:
                CachedNetworkImage(
                  imageUrl:widget.proImage,
             fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child:     Shimmer.fromColors(
                    baseColor: MyColors.onSecondary
                        .withOpacity(0.4),
                    highlightColor: Theme.of(context).colorScheme.onSecondary,
                    child: Container(       width: width,
                      height: 200, decoration: BoxDecoration
                        (borderRadius:
                      BorderRadius.circular(16),  color: MyColors.onSecondary
                          .withOpacity(0.4),),

                    ),
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                )
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headingText(
                            text: 'Sender Name',
                            fontWeight: FontWeight.bold,
                            maxlines: 1,
                          ),
                          ParagraphText(
                            text: widget.name,
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
                          ),
                          ParagraphText(
                            text:widget.postalcode,
                            maxlines: 1,
                            fontSize: 16,
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
                            text: widget.dimension,
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
                            text: widget.recieverName,
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
                            text: widget.recieverNumber,
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
                            text: widget.weight,maxlines: 1,
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
                  text: 'Amount',
                  fontWeight: FontWeight.bold,
                ),
                ParagraphText(
                  text: widget.amount,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                headingText(
                  text: 'Drop Location',
                  fontWeight: FontWeight.bold,
                ),
                ParagraphText(
                  text: widget.address,
                  fontSize: 16,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    headingText(
                      text: 'Individual Submitted Offers',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    IconButton(onPressed: (){
                    //  push(context: context,screen: VehicleMapScreen());
                      push(context: context, screen: MapList(markerList: nearestDriverList, isCompany: false,));
                    }, icon: Image.asset("assets/images/google-maps.png",height: 25,width: 25,))
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                if(nearestDriverList.isEmpty)
                  Text('No driver available for this location')
                else
                  for (int index = 0; index < nearestDriverList.length; index++)
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading:
                      Container(
                          padding: EdgeInsets.all(2),
                          width: width * 0.14,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.primaryColor),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl:
                              nearestDriverList[index].drImage,
                              // width: width * 0.1,
                              // height: height * 0.05,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )),
                      //  horizontalTitleGap: 2,
                      title: Text(
                        nearestDriverList[index].drFullName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text("Request sent",
                      //nearestDriverList[index].shipmentBids=="false"?Text("Calculating...."):Text("\$${nearestDriverList[index].vehiclesAmount}",
                          style: TextStyle(
                              fontSize: 14,
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => DriverDetailFinalScreen(dId:nearestDriverList[index].drId , driverAmount: "100", shipmentId:widget.shipmentId)));
                      },
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

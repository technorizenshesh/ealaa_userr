import 'package:ealaa_userr/View/Screens/MapTracking.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:intl/intl.dart';
class Tracking extends StatefulWidget {

  
  const Tracking({super.key,});

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  TextEditingController name= TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // openBottomSheet1();
  //  Open the bottom sheet as soon as the screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {

      openTrackOrder();
    });
  }


  void openTrackOrder() {
    _scaffoldKey.currentState!.showBottomSheet(
          (context) {
        return
          Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.45,
            child: BookingTime!=''?SingleChildScrollView(
              child: Column  (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainHeadingText(text:"Track Order ${BookingStatus}",fontSize: 20,) ,
                    ],
                  ),
                  sizeBox_mq(context, width: MediaQuery.of(context).size.width,
                      height: 0.01),
                  ListTile(
                    leading: Image.asset(BookingStatus!='Approve'?MyImages
                        .tracking1:MyImages.tracking1active,),
                    title: Text("In process-recipient city",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    // subtitle: ParagraphText(text: "Berlin,germany",),
                    trailing: Text(BookingTime, style: TextStyle(fontSize: 10,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:36.0),
                    child: Container(
                      width: 1,
                      height: 35,
                      color: MyColors.primaryColor,
                    ),
                  ) ,
                  ListTile(
                    leading: Image.asset(BookingStatus!='Start'?MyImages
                        .tracking2:MyImages.tracking2active),
                    title: Text("Transite-sending city"),
                    subtitle: ParagraphText(text: BookingPickLocation,),
                    trailing: Text(BookingDropLocationTime!='' && BookingDropLocationTime!=null?DateFormat('dd MMM yyyy').format(DateTime
                        .parse(BookingDropLocationTime)):'', style: TextStyle(fontSize:
                    10,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:36.0),
                    child: Container(
                      width: 1,
                      height: 35,
                      color: MyColors.primaryColor,
                    ),
                  ) ,
                  ListTile(
                    leading: Image.asset(BookingStatus!='Complete'?MyImages
                        .tracking3:MyImages.tracking3active),
                    title: Text("Sent from majalengka"),
                    subtitle: ParagraphText(text: BookingDropLocation,),
                    trailing: Text(BookingDropLocationTime!='' && BookingDropLocationTime!=null?DateFormat('dd MMM yyyy').format(DateTime
                        .parse(BookingDropLocationTime)):'', style: TextStyle(fontSize:
                    10,),
                    ),
                  ),


                ],
              ),
            ):Center(child: Text("No Booking found to track."),),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,

      body: Stack(
        children: [
          GoogleMapService(),
        ],
      ),
    );
  }
}


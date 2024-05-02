import 'package:ealaa_userr/Model/NotificationModel.dart';
import 'package:ealaa_userr/View/Screens/ChatRoom.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:intl/intl.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class DeliveryNotifications extends StatefulWidget {
  const DeliveryNotifications({Key? key}) : super(key: key);

  @override
  State<DeliveryNotifications> createState() => _DeliveryNotificationsState();
}

class _DeliveryNotificationsState extends State<DeliveryNotifications> {
  List<NotificationResult> notificationList = [];

  getNotificationList() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_notification?user_id=$userId&type=user");
    print("status from api ${res}");
    final resdata = NotificationModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      notificationList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
    getNotificationList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
          text: "Notifications",
          textAlign: TextAlign.center,
          fontSize: 20,
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: Image.asset("assets/images/roundedSearch.png"),
        //   )
        // ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < notificationList.length; i++)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  elevation: 0.5,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: notificationList[i].image,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      "Shipment id ${notificationList[i].shipmentId}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      notificationList[i].message,
                      style: (TextStyle(color: MyColors.primaryColor)),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('dd MMM yyyy')
                              .format(notificationList[i].dateTime),
                          style: (TextStyle(color: MyColors.primaryColor)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          DateFormat('hh:mm aa')
                              .format(notificationList[i].dateTime),
                          style: (TextStyle(color: MyColors.primaryColor)),
                        ),
                      ],
                    ),
                    onTap: (){
                      if(notificationList[i].type=="chat"){
                        push(context: context, screen: ChatRoom(id: notificationList[i].driverId,));
                      }
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

import 'package:ealaa_userr/advertisement/chat_message_detail.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../View/Screens/ChatRoom.dart';
import 'ad_chat_room.dart';

class AdChats extends StatefulWidget {
  const AdChats({super.key});

  @override
  State<AdChats> createState() => _AdAdsState();
}

class _AdAdsState extends State<AdChats> {
  bool isMap = false;
  bool showProgressBar = false;
  String notificationCount = "";
  List<Map<String, String>> chatUserList = [
    {
      "name": "Jalina Margo",
      "message": "kung Fu Chau added new image inFurniture and Garden.",
      'image': "assets/images/Ellipse 1.png"
    },
    {
      "name": "Dina Meyer",
      "message": "kung Fu Chau added new image inFurniture and Garden.",
      'image': "assets/icons/ic_boy.png"
    },
    {
      "name": "Dina Meyer",
      "message": "kung Fu Chau added new image inFurniture and Garden.",
      'image': "assets/images/Ellipse 1.png"
    },
    {
      "name": "Jafer Nargo",
      "message": "kung Fu Chau added new image inFurniture and Garden.",
      'image': "assets/icons/ic_boy.png"
    },
  ];

  clickOnItem() {
   /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdChatMessageDetail()),
    );*/
      push(context: context, screen: AdChatRoom(id: '10000'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      // Assign the key to Scaffold.
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Chats', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // push(
                      //     context: context,
                      //     screen: const DeliveryNotifications());
                    },
                    child: Image.asset(
                      MyImages.icEdit,
                      height: 25,
                      width: 25,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // SvgPicture.asset("assets/images/Notification.svg",height: 30,color: MyColors.primaryColor,)
                ],
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: showChatsUsers(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show showChatsUsers  ...
  Widget showChatsUsers() {
    return showProgressBar
        ? CommonWidget.commonShimmer(
            itemCount: 4,
            shimmerWidget: Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 2),
              clipBehavior: Clip.hardEdge,
            ))
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: chatUserList.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return GestureDetector(
                onTap: () {
                  clickOnItem();
                },
                child: Container(
                  height: 95,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              chatUserList[index]['image'] ?? '',
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chatUserList[index]['name'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.orange),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        chatUserList[index]['message'] ?? '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13,
                                            color: Colors.black54),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 70,
                                      child: Text(
                                        '08:00 PM',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}

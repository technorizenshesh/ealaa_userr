import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Model/advertisement_model/get_conversation_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/GlobalData.dart';
import '../View/Utils/webService.dart';
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

  List<GetConversationResult> result = [];

  GetConversationModel? getConversationModel;

  getConversationApi() async {
    showProgressBar = true;
    Map<String, dynamic> data = {
      "receiver_id": userId,
    };
    print("data.....$data");
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$get_conversation", body: data, context: context);
    getConversationModel =
        GetConversationModel.fromJson(res);
    setState(() {});
    if (getConversationModel!=null && getConversationModel!.status == 1 &&
        getConversationModel!.result != null &&
        getConversationModel!.result!.isNotEmpty) {
      result = getConversationModel!.result!;
      setState(() {});
      print('Successss::::::::::');
    } else {
      print('Fail::::::::::');
    }
    showProgressBar = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getConversationApi();
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
        /*actions: [
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
        ],*/
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
        : result.isNotEmpty && getConversationModel!=null
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: result.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      push(
                          context: context,
                          screen: AdChatRoom(id: result[index].id ?? '1'));
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
                                child: Image.network(
                                  result[index].image ??
                                      'https://avatar.iran.liara.run/public/37',
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      'https://avatar.iran.liara.run/public/37',
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      result[index].userName ?? 'NA',
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
                                            result.last.lastMessage ?? 'NA',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 70,
                                          child: Text(
                                            result[index].time ?? 'NA',
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
              )
            : Center(
                child: Text('not found any conversation'),
              );
  }
}

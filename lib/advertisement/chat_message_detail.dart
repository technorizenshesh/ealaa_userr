import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

class AdChatMessageDetail extends StatefulWidget {
  const AdChatMessageDetail({super.key});

  @override
  State<AdChatMessageDetail> createState() => _AdAdsState();
}

class _AdAdsState extends State<AdChatMessageDetail> {
  TextEditingController search = TextEditingController();
  bool isMap = false;
  bool showProgressBar = false;

  List<Map<String, String>> chatMessageList = [
    {
      "name": "Dina Meyer",
      "message": "What is the best time we will meet and where are we meeting?",
      'image': "assets/images/Ellipse 1.png"
    },
    {
      "name": "Rayan Josef",
      "message":
          "We will meet at 9:00 PM near my home at Mall@Door so that we ",
      'image': "assets/icons/ic_boy.png"
    },
    {
      "name": "Dina Meyer",
      "message": "And than what about the Jiya and Siya,who will pick them?",
      'image': "assets/images/Ellipse 1.png"
    },
    {
      "name": "Rayan Josef",
      "message": "Okay than will reach to your home soon. Bye. SYS.",
      'image': "assets/icons/ic_boy.png"
    },
    {
      "name": "Dina Meyer",
      "message": "What is the best time we will meet and where are we meeting?",
      'image': "assets/images/Ellipse 1.png"
    },
    {
      "name": "Rayan Josef",
      "message":
          "We will meet at 9:00 PM near my home at Mall@Door so that we ",
      'image': "assets/icons/ic_boy.png"
    },
    {
      "name": "Dina Meyer",
      "message": "And than what about the Jiya and Siya,who will pick them?",
      'image': "assets/images/Ellipse 1.png"
    },
    {
      "name": "Rayan Josef",
      "message": "Okay than will reach to your home soon. Bye. SYS.",
      'image': "assets/icons/ic_boy.png"
    },
  ];

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
          'Dena Mayer', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(
                  MyImages.icImogy,
                  height: 25,
                  width: 25,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
                child: TextFormField(
              controller: search,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Type a message ...',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black54)),
            )),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Icon(
                  Icons.send,
                  size: 30,
                  color: Colors.orange,
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: showChatMessages(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show chats messages  ...
  Widget showChatMessages() {
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
            itemCount: chatMessageList.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return Align(
                  alignment: index % 2 == 0
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: index % 2 == 0
                      ? sendingMessage(chatMessageList[index])
                      : receivingMessage(chatMessageList[index]));
            },
          );
  }

  Widget sendingMessage(Map<String, String> message) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250, minWidth: 150),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  message['image'] ?? '',
                  height: 25,
                  width: 25,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                message['name'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            message['message'] ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget receivingMessage(Map<String, String> message) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250, minWidth: 150),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orangeAccent.withOpacity(0.3)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  message['image'] ?? '',
                  height: 25,
                  width: 25,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                message['name'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            message['message'] ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ealaa_userr/View/Utils/ApiConstants.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:intl/intl.dart';

import '../import_ealaa_user.dart';
import '../View/Utils/webService.dart';

class AdChatRoom extends StatefulWidget {
  final String id;
  final String image;
  final String name;

  const AdChatRoom({super.key, required this.id,this.name = '',this.image = ''});

  @override
  State<AdChatRoom> createState() => _AdChatRoomState();
}

class _AdChatRoomState extends State<AdChatRoom> {
  TextEditingController messageController = TextEditingController();
  bool sendVisibility = false;
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future<void> uploadToFirestore() async {
    //  sendmessapi();
    // print("type is...............$type");
    //
    Map<String, dynamic> imageMap = {
      "sendBy": userId,
      "sendTo": "Admin",
      "message": messageController.text.trim().toString(),
      "time": FieldValue.serverTimestamp(),
    };

    await firebaseFireStore
        .collection("ad_chatroom")
        .doc(getChatId(userId, widget.id))
        .collection("chats")
        .add(imageMap);
    messageController.clear();
    sendVisibility = false;
    setState(() {});
    sendNotification();
  }

  sendNotification() async {
    var res = await Webservices.getMap(
        "$insert_chat?sender_id=$userId&reciever_id=${widget.id}&type=user");
    print("status from api ${res}");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        // toolbarHeight: 80,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close)),
        titleSpacing: 0,
        title: Row(
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: Image.network(
                widget.image.isNotEmpty ? widget.image :'https://avatar.iran.liara.run/public/37',
                fit: BoxFit.fill
              ),
            ),
            SizedBox(width: 14),
            Text(
              widget.name.isNotEmpty ? widget.name:'Unnamed user',
              style:
                  TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 15),
            ),
            /*Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.call,color: Colors.orange,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Call',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400,color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
            )*/
          ],
        ),
        // AppBarHeadingText(
        //   text: "FAQ",
        //   color: ColorConstant.white,
        // ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // getChatResult.isEmpty?Center(child: CustomLoader(color: ColorConstant.buttonColor,)):
          Divider(height: 1,),
          /*Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: .4),borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/Ellipse 1.png',
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
                            'Ford Mustang GT California Sp',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,),
                          ),
                          Row(
                            children: [
                              Text(
                                'View Ad',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.orange),
                              ),
                              Icon(Icons.arrow_forward,color: Colors.orange,size: 18,)
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),*/
          Expanded(
            child: ListView(
              reverse: true,
              children: [
                Column(
                  children: [
                    StreamBuilder(
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data != null) {
                          return listViewBuilderView(snapshot: snapshot);
                        } else {
                          return Column(
                            children: [],
                          );
                        }
                      },
                      stream: firebaseFireStore
                          .collection("ad_chatroom")
                          .doc(getChatId(userId, widget.id))
                          .collection("chats")
                          .orderBy("time", descending: false)
                          .snapshots(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _sendMessageArea()
        ],
      ),
    );
  }

  Widget listViewBuilderView({required AsyncSnapshot<QuerySnapshot> snapshot}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 1),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
              onLongPress: () {
                deleteMessageDialogBox(snapshot.data!.docs[index].id);
              },
              child: messages(snapshot: snapshot, index: index));
        },
        itemCount: snapshot.data?.docs.length,
      ),
    );
  }

  Widget messages(
      {required AsyncSnapshot<QuerySnapshot> snapshot, required int index}) {
    return textMessageView(snapshot: snapshot, index: index);
  }

  Widget textMessageView(
          {required AsyncSnapshot<QuerySnapshot> snapshot,
          required int index}) =>
      Column(
        children: [
          Container(
            width: double.infinity,
            alignment: snapshot.data?.docs[index]["sendBy"] == userId
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: snapshot.data?.docs[index]["sendBy"] == userId
                      ? Colors.black38.withOpacity(0.05)
                      : MyColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    snapshot.data?.docs[index]["message"],
                    style: const TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    snapshot.data?.docs[index]["time"] == null
                        ? ""
                        : (DateFormat('HH:mm a').format(
                                snapshot.data?.docs[index]["time"].toDate()))
                            .toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    snapshot.data?.docs[index]["time"] == null
                        ? ""
                        : getTimeAgo(snapshot.data?.docs[index]["time"]),
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  String getTimeAgo(Timestamp timestamp) {
    if (timestamp == null) {
      return "";
    }
    DateTime dateTime = timestamp.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays > 1 && difference.inDays <= 5) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays > 5) {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } else {
      // Handle future dates
      return 'Future date';
    }
  }

  deleteMessageDialogBox(String docId) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2),
        content: Text("Are you sure to delete this message"),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  "NO",
                  style: TextStyle(
                    color: MyColors.primaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  deleteMessage(docId);
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  "yes",
                  style: TextStyle(color: MyColors.primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deleteMessage(String docId) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('ad_chatroom');
      await users
          .doc(getChatId(userId, widget.id))
          .collection("chats")
          .doc(docId)
          .delete();

      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  _sendMessageArea() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.grey.withOpacity(0.1)),
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Type message',
                  ),
                  controller: messageController,
                  onChanged: (f) {
                    messageController.text == ""
                        ? sendVisibility = false
                        : sendVisibility = true;
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(width: 20,),
            Container(
             decoration: BoxDecoration( color: sendVisibility ? Color(0xffefb129) : Color(
                 0xFF777474),borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                icon: Icon(Icons.send),
                iconSize: 20,
                color: Colors.white,
                onPressed: () {
                  //sendMessage();
                  sendVisibility ? uploadToFirestore():null;
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  String getChatId(String senderId, String recieverId) {
    if (int.parse(senderId) == int.parse(recieverId)) {
      return "$recieverId";
    } else if (int.parse(senderId) > int.parse(recieverId)) {
      print("${recieverId}_to_$senderId");
      return "${recieverId}_to_$senderId";
    } else {
      print("${senderId}_to_$recieverId");
      return "${senderId}_to_$recieverId";
    }
  }
}

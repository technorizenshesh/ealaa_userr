import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ealaa_userr/View/Utils/ApiConstants.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../import_ealaa_user.dart';
import '../Utils/webService.dart';

class ChatRoom extends StatefulWidget {
  final String id;

  const ChatRoom({super.key, required this.id});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
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
        .collection("chatroom")
        .doc(getChatId(userId, widget.id))
        .collection("chats")
        .add(imageMap);
    messageController.clear();
    sendVisibility = false;
    setState(() {});
    sendNotification();
  }

  sendNotification() async{
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
        backgroundColor: MyColors.primaryColor,
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back)),
        titleSpacing: 0,
        title: Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: Image.asset(
                  "assets/images/Profile.png",
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "User Name",
              style:
                  TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15),
            ),
          ],
        ),
        // AppBarHeadingText(
        //   text: "FAQ",
        //   color: ColorConstant.white,
        // ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // getChatResult.isEmpty?Center(child: CustomLoader(color: ColorConstant.buttonColor,)):
          Container(
            height: height * 0.85,
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
                          .collection("chatroom")
                          .doc(getChatId(userId, widget.id))
                          .collection("chats")
                          .orderBy("time", descending: false)
                          .snapshots(),
                    ),
                    SizedBox(
                      height: 55,
                    )
                  ],
                ),
              ],
            ),
            // height: height * 0.78,
            // color: Colors.yellow,
            // child: ListView.builder(
            //   reverse: true,
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   itemCount: getChatResult.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     final bool isMe = userId == getChatResult[index].senderId;
            //     // final bool isSameUser = prevUserId == message.sender.id;
            //     // prevUserId = message.sender.id;
            //     return _chatBubble(getChatResult[index], isMe);
            //   },),
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
          FirebaseFirestore.instance.collection('chatroom');
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.grey.withOpacity(0.1)),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
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
              // IconButton(
              //   icon: Icon(Icons.photo),
              //   iconSize: 25,
              //   color: Theme.of(context).primaryColor,
              //   onPressed: () {},
              // ),
              // IconButton(
              //   icon: Icon(Icons.gif_box_outlined),
              //   iconSize: 25,
              //   color: Theme.of(context).primaryColor,
              //   onPressed: () {},
              // ),
              Visibility(
                visible: sendVisibility,
                child: IconButton(
                  icon: SvgPicture.asset('assets/images/SendIcon.svg'),
                  iconSize: 25,
                  color: Color(0xffefb129),
                  onPressed: () {
                    //sendMessage();
                    uploadToFirestore();
                  },
                ),
              ),
            ],
          ),
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

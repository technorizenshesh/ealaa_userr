import 'package:ealaa_userr/View/Utils/bottom_bar.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Utils/GlobalData.dart';

class Success extends StatefulWidget {
  final String orderId;
  const Success({super.key, required this.orderId});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
       await pushReplacement(context: context, screen: Bottom_bar(key: MyGlobalKeys.tabBarKey,)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: InkWell(
              onTap: (){
                pushReplacement(context: context, screen: Bottom_bar(key: MyGlobalKeys.tabBarKey,));
              },
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset("assets/images/backButton.svg")),
            ),
          centerTitle: true,
          title: Text(
              "Order Successful",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )
          )

        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              sizeBox_mq(context, width: 1, height: 0.1),
              Image.asset(MyImages.Success),
              MainHeadingText(text: "Order Successful",fontSize: 20,),
              ParagraphText(text: "Order ID : ${widget.orderId}",fontSize: 15,),
              sizeBox_mq(context, width: 1, height: 0.05),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RoundButton(title: "OK", onTap: (){
                  pushReplacement(context: context, screen: Bottom_bar(key: MyGlobalKeys.tabBarKey,));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

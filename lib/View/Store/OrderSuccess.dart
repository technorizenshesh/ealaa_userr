import 'package:ealaa_userr/View/Store/storeBottomBar.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Utils/GlobalData.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  Future<bool> onWillPop() async {
    currentindex = 0;
    selectedValue.value = CurrentTabIndex.first;
    pushReplacement(context: context, screen: StoreBottomBar());
    return Future.value(true); //back all class & exit
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(onWillPop: onWillPop,child:  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: Text("Order Success",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: RoundButton(
          title: 'Back to Home',
          onTap: () {
            currentindex=0;
            selectedValue.value = CurrentTabIndex.first;
            setState(() {

            });
            pushReplacement(context: context, screen: StoreBottomBar());
          },
          fontsize: 16,
          fontweight: FontWeight.w700,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: height*0.1,),
          Center(child: Image.asset("assets/images/SuccessIcon.png",height: 250,width: 250,)),
          Center(child: Image.asset("assets/images/Frame 1171275434.png",height: 230,width: 230,)),
        ],
      ),
    ));
  }
}

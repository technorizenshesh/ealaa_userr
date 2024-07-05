import 'package:ealaa_userr/View/Store/CancelStoreOrder.dart';
import 'package:ealaa_userr/View/Store/OngoingStoreOrder.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

class MyStoreOrder extends StatefulWidget {
  const MyStoreOrder({Key? key}) : super(key: key);

  @override
  State<MyStoreOrder> createState() => _MyStoreOrderState();
}

class _MyStoreOrderState extends State<MyStoreOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          scrolledUnderElevation: 0.0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset("assets/images/backButton.svg")),
          ),
          centerTitle: true,
          title: Text("My Order",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
    body:  Padding(padding: EdgeInsets.symmetric(horizontal: 20),child:
    tabbar() ,),
    );
  }

  Widget tabbar() {
    return
      DefaultTabController(
        length: 2, // length of tabs
        initialIndex: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TabBar(
              labelPadding: EdgeInsets.only(left: 5, right: 0),
              labelColor: MyColors.primaryColor,
              ///555
              unselectedLabelColor: Color(0xffAFB1B0),
              isScrollable: false,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 3,
                  color: MyColors.primaryColor,
                ),
              ),
              // duration: 0,
              labelStyle: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                letterSpacing: 0.2,
                fontFamily: "Poppins",
              ),
              unselectedLabelStyle: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontSize: 15.0,
                letterSpacing: 0.2,
                fontFamily: "Poppins",
              ),
              tabs:
              [
                Tab(text: 'Ongoing'),
                Tab(text: 'Cancelled '),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                //  color: Colors.white,
                height: MediaQuery.of(context).size.height*0.75, //height of
                // TabBarView
                child:
                TabBarView(
                  children: <Widget>[
                    OngoingStoreOrder(),
                    CancelStoreOrder(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}

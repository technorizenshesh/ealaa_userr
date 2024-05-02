import 'package:ealaa_userr/View/Store/StoreFaq.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import 'StoreContactUs.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
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
        title: Text("Help Center",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ))),
      body:  tabbar(),
    );
  }
  Widget tabbar() {
    return DefaultTabController(
      length: 3, // length of tabs
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TabBar(
            physics: NeverScrollableScrollPhysics(),

            labelPadding: EdgeInsets.only(left: 5, right: 0),
            labelColor: MyColors.primaryColor,

            ///555
            unselectedLabelColor: Color(0xff000000),
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
              fontSize: 15.0,
              letterSpacing: 0.2,
              fontFamily: "Poppins",
            ),
            unselectedLabelStyle: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
              letterSpacing: 0.2,
              fontFamily: "Poppins",
            ),

            tabs: [
              Tab(text: 'FAQ',),
              Tab(text: 'Contact Us'),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            child: Container(
              //  color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.51, //height of TabBarView
              child: Expanded(
                child: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    StoreFaq(),
                    StoreContactUs(),
                    // CancelledAppointment()
                  ],
                  // children: <Widget>[Container(), Container(), Container()],
                  // controller: _tabController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:ealaa_userr/import_ealaa_user.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
          title: Text("My Account",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: RoundButton(
          title: 'Edit',
          onTap: () {
Navigator.pop(context);          },
          fontsize: 16,
          fontweight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [Center(child: Image.asset("assets/images/Frameprofile image (2).png",width: 180,)),
             SizedBox(height: 20,),
        Container(
            height: height*0.6,
            child: Image.asset("assets/images/Frame 1171275460.png"))],),
      ),
    );
  }
}

import 'package:ealaa_userr/import_ealaa_user.dart';

class AddressHO extends StatefulWidget {
  const AddressHO({Key? key}) : super(key: key);

  @override
  State<AddressHO> createState() => _AddressHOState();
}

class _AddressHOState extends State<AddressHO> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          title: Text("Address",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
      body: Image.asset("assets/images/Frame 1171275468.png",
        height: 230,
        width: width,
        fit: BoxFit.contain,),
    );
  }
}

import 'package:ealaa_userr/import_ealaa_user.dart';

class DriverDetail extends StatefulWidget {
  const DriverDetail({super.key});

  @override
  State<DriverDetail> createState() => _DriverDetailState();
}

class _DriverDetailState extends State<DriverDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:    AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset("assets/images/backButton.svg")),
          ),
          centerTitle: true,
          title: Text("Driver Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
    );
  }
}

import 'package:ealaa_userr/import_ealaa_user.dart';

class CompletedStoreOrder extends StatefulWidget {
  const CompletedStoreOrder({Key? key}) : super(key: key);

  @override
  State<CompletedStoreOrder> createState() => _CompletedStoreOrderState();
}

class _CompletedStoreOrderState extends State<CompletedStoreOrder> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
      Container(
          width: width,
          child: Image.asset("assets/images/Group 1171275178 (1).png",fit: BoxFit.fill,)),
    );
  }
}

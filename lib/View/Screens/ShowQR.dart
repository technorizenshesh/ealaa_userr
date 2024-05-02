import 'package:ealaa_userr/import_ealaa_user.dart';

class ShowQR extends StatefulWidget {
  final String qr;

  ShowQR({super.key, required this.qr});

  @override
  State<ShowQR> createState() => _ShowQRState();
}

class _ShowQRState extends State<ShowQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Center(child: Image.network(widget.qr)),
          Text(
            "Scan OR Code",
            style: TextStyle(color: MyColors.primaryColor),
          )
        ],
      ),
    );
  }
}

import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../Model/StoreModel/GetStorePaymentModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';

class PaymentStore extends StatefulWidget {
  const PaymentStore({Key? key}) : super(key: key);

  @override
  State<PaymentStore> createState() => _PaymentStoreState();
}

class _PaymentStoreState extends State<PaymentStore> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<
      RefreshIndicatorState>();
  bool showLoader = true;
  List<GetStorePaymentResult> transationList = [];
  getTransactionDetail() async {
    var res = await Webservices.getMap
      ("$get_store_payment?user_id=$userId&type=user");
    print("status from api ${res}");
    final resdata = GetStorePaymentModel.fromJson(res);
    print(resdata);
    showLoader=false;
    setState(() {

    });
    if (resdata.status == '1') {
      transationList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message!);
    }
  }
  @override
  void initState() {
    getTransactionDetail();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            scrolledUnderElevation: 0,
            toolbarHeight: 80,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset("assets/images/backButton.svg")),
            ),
            centerTitle: true,
            title: Text("Payment Transactions")),
        body:RefreshIndicator(onRefresh: () async{
          getTransactionDetail();
          setState(() {

          });
        },
            child: showLoader ?
            Container(height: 100, child:
            Center(child: CircularProgressIndicator(color:
            MyColors.primaryColor,))
            )
                : transationList.isEmpty ?
            Image
                .asset("assets/images/NoDataFound.png"):
            SingleChildScrollView(child: Column(
              children: [
                for(int i =0;i<transationList.length;i++)
                  ListTile(
                      trailing:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset("assets/images/Icon green received"
                              ".png",height: 23,width: 23,),

                        ],
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Transaction Id:  ${transationList[i].id}",style:
                          TextStyle(color: AppColors.themeColor,fontWeight:
                          FontWeight.bold),),
                          Text("Order Id:  ${transationList[i].shipmentId}",style:
                          TextStyle(color: AppColors.themeColor,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      subtitle: Column(crossAxisAlignment:CrossAxisAlignment.start,
                        children: [Text("${transationList[i].amount} \$"),Text
                          ("${transationList[i].name}"),
                          Text(
                            transationList[i].dateTime.toString(),
                            style: TextStyle( fontSize: 12),
                          ),],)
                  ),
              ],
            ),))
    );
  }
}

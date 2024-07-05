import 'package:ealaa_userr/Model/StoreModel/AddAddressModel.dart';
import 'package:ealaa_userr/View/Utils/CustomSnackBar.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Screens/ChoosePickupLocationMap.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/webService.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  bool loader = false;
  TextEditingController address = TextEditingController();
  TextEditingController consignee = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  String storeLat='';
  String storeLon='';

  addAddress() async {
    loader=true;
    setState(() {

    });
    Map<String, dynamic> data = {
      "user_id":userId,
      "address": address.text,
      "lat": storeLat.toString(),
      "lon": storeLon.toString(),
      "consignee_name": consignee.text,
      "phone_number": phoneNo.text,

    };
    var res = await Webservices.postData(
        apiUrl: add_address, body: data, context: context);
    loader=false;
    setState(() {
      
    });
    print("status from api ${res}");
    final resdata = AddAddressModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      showSnackbar(context, resdata.message);
      Navigator.pop(context);
    } else {
    }
  }

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
          title: Text("Add Address",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: RoundButton(
          loading: loader,
          title: 'Add',
          onTap: () {
            if(address.text.isEmpty){
              showSnackbar(context, "Select Address");
            }
            else if(consignee.text.isEmpty){
              showSnackbar(context, "Enter Consignee");
            }
            else if(phoneNo.text.isEmpty){
              showSnackbar(context, "Enter Phone Number");
            }
            else{
              addAddress();
            }
           // push(context: context, screen: OrderSuccess());
          },
          fontsize: 16,
          fontweight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,children: [
          MainHeadingText(text: "Address",fontSize: 16,) ,
          SizedBox(height: 15,),
          CustomTextFieldwithoutshadow(
            maxLines: null,
            controller: address,
            hintText: "Select Address",
            labelText: "Select Address",
            bgColor: Color(0xffF7F8F8),
            readonly: true,
            suffixIcon: 'assets/images/arrow.png',
            paddingsuffix: 17,
            onTapsuffix: () async {
              Map<String, String> data = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChoosePickipLocationMap()));
              print("pickloc.........${data['lat']}");
              address.text = data['address']!;
              storeLat = data['lat']!;
              storeLon = data['lon']!;
              setState(() {});
            },
          ),
          SizedBox(height: 30,),
          MainHeadingText(text: "Name of Consignee",fontSize: 16,) ,
          SizedBox(height: 15,),
          CustomTextFieldwithoutshadow(
            controller: consignee,
            hintText: 'Enter Consignee',
            labelText: 'Enter Consignee',
          ),
          SizedBox(height: 30,),
          MainHeadingText(text: "Phone Number",fontSize: 16,) ,
          SizedBox(height: 15,),
          CustomTextFieldwithoutshadow(
            controller: phoneNo,
            hintText: 'Enter Phone Number',
            labelText: 'Enter Phone Number',
            keyBoardType: TextInputType.number,
          ),
        ],)
      ),
    );
  }
}

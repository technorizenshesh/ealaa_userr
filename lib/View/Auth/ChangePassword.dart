import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../Model/GeneralModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class CreateNewPassword extends StatefulWidget {
  final String userId,token;
  const CreateNewPassword({super.key, required this.userId, required this.token});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController passController = TextEditingController();
  TextEditingController conpassController = TextEditingController();
  bool loader = false;

  updatePassword() async {
    Map<String, dynamic> data = {
      "user_id": widget.userId,
      "password": conpassController.text,
      "token":widget.token,
    };
    setState(() {
      loader=true;
    });
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$update_password", body: data, context: context);
    setState(() {
      loader=false;
    });
    print("status from api ${res}");
    final resdata = GeneralModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      showSnackbar(context, "Password updated successfully");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
              (route) => false);
    } else {
      showSnackbar(context, "Password couldn't be updated");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Padding(
      //         padding: EdgeInsets.all(10),
      //         child: SvgPicture.asset("assets/images/backButton.svg")),
      //   ),
      //   title: ParagraphText(
      //     text: 'Create New Password',
      //     fontSize: 18,
      //     fontWeight: FontWeight.normal,
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: height*0.05,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/images/backButton.svg")),
                ),
                SizedBox(width: 20,),
                Image.asset("assets/images/ChangePassImage.png",height: 200,)
              ],
            ),
            SizedBox(height: height*0.01,),
            Center(
                child: ParagraphText(
              text:
                  "Your new password must be different\nfrom previous used passwords.",
              textAlign: TextAlign.center,
            )),
            SizedBox(
              height: height * 0.08,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: CustomTextFieldwithoutshadow(
                controller: passController,
                hintText: 'Please Enter new password',
                labelText: 'New Password',
                obscureText: true,
                suffixIcon: MyImages.hide,
                prefixIcon: MyImages.lock,
              ),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: CustomTextFieldwithoutshadow(
                controller: conpassController,
                hintText: 'Please Enter Confrim password',
                labelText: 'Confrim password',
                obscureText: true,
                suffixIcon: MyImages.hide,
                prefixIcon: MyImages.lock,
              ),
            ),
            SizedBox(
              height: height * 0.10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: RoundButton(
                title: 'Change',
                loading: loader,
                onTap: () async {
                  if (passController.text=="") {
                    showSnackbar(context, "Enter new password");
                  }
                  else if(conpassController.text==""){
                    showSnackbar(context, "Confirm new password");
                  }
                  else{
                    if(passController.text!=conpassController.text){
                      showSnackbar(context, "new password and confirm password should be same");
                    }
                    else{
                      updatePassword();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

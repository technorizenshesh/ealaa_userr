import 'dart:io';

import 'package:ealaa_userr/Model/ProfileModel.dart';
import 'package:ealaa_userr/View/Utils/ApiConstants.dart';
import 'package:ealaa_userr/View/Utils/CustomSnackBar.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/View/Utils/webService.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/CommonMethods.dart';
class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  bool notification = false;
  bool loader = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var Data;
  TextEditingController email = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController name = TextEditingController();

  File? profilePicture;
  String profileImage='';
  final imgPicker = ImagePicker();

  autofill()async{
    name.text=profileResult!.userName!;
    email.text=profileResult!.email!;
    mob.text=profileResult!.mobile!;
    profileImage=profileResult!.image??"";
    setState(() {
      
    });
  }

  void _image_camera_dialog(BuildContext context) {
    // print("doc type is..$docType");
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Select an Image',
          style: GoogleFonts.openSans(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
              onPressed: () {
                openGallery();
                Navigator.pop(context);
              },
              child: Text(
                'Select a photo from Gallery',
                style: GoogleFonts.openSans(color: Colors.grey, fontSize: 15),
              )),
          CupertinoActionSheetAction(
              onPressed: () {
                openCamera();
                Navigator.pop(context);
              },
              child: Text(
                'Take a photo with the camera',
                style: GoogleFonts.openSans(color: Colors.grey, fontSize: 15),
              )),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel',
              style: GoogleFonts.openSans(fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  void openCamera() async {
    final imgCamera = await imgPicker.pickImage(
        source: ImageSource.camera);
    if(imgCamera!=null){
      profilePicture = await compressImage(File(imgCamera.path));
      print('store image upload by camera $profilePicture');
      setState(() {
      });
    }
    else{
      print("no image is selected");
    }
  }

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(
        source: ImageSource.gallery,);
    if(imgGallery!=null){
      profilePicture = await compressImage(File(imgGallery.path));
      print('store image upload by gallery $profilePicture');
      setState(() {
      });
    }
    else{
      print("no image is selected");
    }
  }

  updateProfileMethod() async {
    loader = true;
    setState(() {});
    Map<String, dynamic> data = {
      "user_id": userId,
      "user_name": name.text.toString()
    };
    Map<String, dynamic> files = {'image':
    profilePicture!=null?profilePicture:null};
    print("request ------------------$data   $files");
    var res = await Webservices.postDataWithImageFunction(
        body: data,
        files: files,
        context: context,
        apiUrl: updateProfile);
    setState(() {
      loader = false;
    });
    print("res from api ------------------$res");
    final resdata = ProfileModel.fromJson(res);
    if (resdata.status == '1') {
      profileResult = resdata.result;
                            Navigator.pop(context);
    } else {
      showSnackbar(context, resdata.message!);
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    autofill();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      // drawer: My_Drawer(),
      appBar:
      AppBar(
          toolbarHeight: 80,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset("assets/images/backButton.svg")),
          ),
          centerTitle: true,
          title: Text("Edit Profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
      body:
 AbsorbPointer(absorbing: loader,child:
 Padding(
   padding: EdgeInsets.symmetric(horizontal: 16),
   child: SingleChildScrollView(
     child: Stack(
       children: [
         Container(
           height: height * 0.8,
           child: Column(
             children: [

               Center(
                 child: GestureDetector(
                   onTap: ()async{
                     _image_camera_dialog(context);
                   },
                   child: Center(
                     child:
                     Stack(
                       children: [
                         Container(
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             border: Border.all(
                               color: MyColors.primaryColor, // Border color
                               width: 2.0, // Border width
                             ),
                           ),
                           child:       ClipRRect(
                               borderRadius: BorderRadius.circular(50),
                               // child: Image.network("${Data['image']}",height:
                               child:profilePicture!=null?
                               Image.file(profilePicture!,
                                 height: 100,
                                 width: 100,
                                 fit: BoxFit.cover,):profileImage.isNotEmpty?
                               CachedNetworkImage(
                                 imageUrl:profileImage,
                                 width: 100,
                                 height: 100,
                                 fit: BoxFit.cover,
                                 placeholder: (context, url) => Center
                                   (child: CircularProgressIndicator
                                   (color: MyColors.primaryColor,)),
                                 errorWidget: (context, url, error) => Icon(Icons.error),
                               )

                                   :
                               Image.asset(
                                 "assets/images/UserErrImage.png",
                                 height: 100,
                                 width: 100,
                                 fit: BoxFit.contain,
                               )),
                         ),

                         Positioned(
                             right: 0,
                             bottom: 0,
                             child:
                             SvgPicture.asset("assets/images/AddIcon.svg",
                               height: 30,)

                         )
                       ],
                     ),
                   ),
                 ),
               ),
               sizeBox_mq(context, width: width, height: 0.05) ,
               // CustomTextFieldwithoutshadow(controller: name, hintText:
               // 'Name',
               //   labelText: 'Name',prefixIcon: MyImages.profile,),
               CustomTextFieldwithoutshadow(controller: name, hintText: 'Full Name',
                 labelText: 'Full Name',prefixIcon: "assets/images/ProfileIcon.png",),
               sizeBox_mq(context, width: width, height: 0.03) ,
               CustomTextFieldwithoutshadow(controller: email, hintText: 'Email',
                 labelText: 'Email',prefixIcon: MyImages.email,readonly:
                 true,),
               sizeBox_mq(context, width: width, height: 0.03) ,

               CustomTextFieldwithoutshadow(controller: mob, hintText: 'Mobile Number',
                 labelText: 'Mobile Number',prefixIcon: MyImages.mobile,
                 readonly: true,),
               sizeBox_mq(context, width: width, height: 0.02) ,
             ],
           ),
         ),
         Positioned(
             bottom: 0,
             child: Container(width:width-32,child: Center(child:
             RoundButton(loading:loader,title: "Save", onTap: () async{
               updateProfileMethod();
             }
             )
             )
             )
         )
       ],
     ),
   ),
 ),)
    );
  }
}

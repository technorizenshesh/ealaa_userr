import 'package:ealaa_userr/View/Utils/bottom_bar.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

void CustomBottomSheet({ context,  body}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return body;
    },
  );
}
 SelectAddress(context){
   TextEditingController name=TextEditingController();
   List addressname=["Home","Shop","Other"] ;
   return CustomBottomSheet(context:context,
       body:Padding(
         padding: const EdgeInsets.all(8.0),
         child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               sizeBox_mq(context, width: 1, height: 0.01) ,
               ListTile(
                 leading: Image.asset(MyImages.pin,height: 25,width:
                 25,),
                 title: MainHeadingText(text: "Rajwaja",fontSize: 18,),
                 subtitle: ParagraphText(text: "Rajwada, indore ,Madhya Pra....",),
                 trailing: SizedBox(width:80,child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8),
                       border: Border.all(color: MyColors.primaryColor),
                     ),
                     child: Center(child: Text("Change")),),
                 )),
               ),
               sizeBox_mq(context, width: 1, height: 0.02) ,
               CustomTextFieldwithoutshadow(controller: name,
                 hintText: 'Receiver’s Name',
                 labelText: 'Receiver’s Name',
                 suffixIcon: MyImages.Contact,borderradius: 8,) ,
               sizeBox_mq(context, width: 1, height: 0.02) ,
               CustomTextFieldwithoutshadow(controller: name,
                 hintText: 'Receiver’s Mobile Number',
                 labelText: 'Receiver’s Mobile Number',
                 borderradius: 8,
               )  ,
               sizeBox_mq(context, width: 1, height: 0.02) ,

               Row(
                 children: [
                   Checkbox(
                     activeColor: MyColors.primaryColor,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(3),
                     ), value: true, onChanged: (bool? value)
                   {
                     // check2=value!;
                     // setState(() {
                     //
                     // });
                   },
                   ),
                   Text("Use My mobile number :8304564564",),
                 ],
               ),
               sizeBox_mq(context, width: 1, height: 0.02) ,
               ParagraphText(text: "Save as option") ,
               sizeBox_mq(context, width: 1, height: 0.02) ,
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Row(
                   children: [
                     for(int i=0; i<addressname.length;i++)
                       Container(
                         padding: EdgeInsets.all(5),
                         margin: EdgeInsets.only(right: 5,top: 5,
                             bottom: 5),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5),
                           border: Border.all(color: MyColors.primaryColor),
                         ),
                         child: Center(child: Text("${addressname[i]}")),)
                   ],
                 ),
               ),
               sizeBox_mq(context, width: 1, height: 0.02) ,

               RoundButton(title: "Confirm And Proceed", onTap: (){
                 Navigator.pop(context);
                 ShipmentDetail(context);
               })

             ],
           ),
         ),
       )
   );
 }
ShipmentDetail(context){
  TextEditingController name=TextEditingController();
  return CustomBottomSheet(context: context,
      body:
      Container(
      // height: 500,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MainHeadingText(text: "Shipment Details",fontSize: 18,),
            sizeBox_mq(context, width: 1, height: 0.02),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              padding: EdgeInsets.all(6),
              dashPattern: [6,9],
              color: MyColors.primaryColor,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(MyImages.add,height: 25,width: 25,) ,
                      sizeBox_mq(context, width: 1, height: 0.01),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ParagraphText(text: "Tap here to add a photo. Photo will be "
                            "shown in header of report ",textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            sizeBox_mq(context, width: 1, height: 0.02),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Name", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Size", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Weight", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Height",
                labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Distance"
                , labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Country", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Email", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Phone Number", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Name", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Address 1 (Optional)", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "City", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "Postal Code", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.01),
            CustomTextFieldwithoutshadow(controller: name, hintText: "House Number", labelText: "Name"),
            sizeBox_mq(context, width: 1, height: 0.02),
            RoundButton(title: "Save & Continue", onTap: (){
              Navigator.pop(context);
              SelectType(context);
            }) ,
            sizeBox_mq(context, width: 1, height: 0.02),

          ],
        ),
      ),
    ),
  ));
}

SelectType(context){
  return CustomBottomSheet(context: context,
      body:GestureDetector(
        onTap: (){
         // push(context: context, screen: Shipmentdetails());
        },
        child: Container(child:
        Image.asset(MyImages.popup,fit: BoxFit.cover,),),
      ));
  //     body:Container(
  //       child: Column(children: [
  //   Row(
  //       children: [
  //         for(int i=0;i<3;i++)
  //           Card(child: ListTile(
  //             leading: Image.asset(MyImages.bike),
  //             title: Column(
  //               children: [
  //                 MainHeadingText(text: "Tow Wheeler"),
  //                 ParagraphText(text: "2 min")
  //               ],
  //             ),
  //             subtitle: MainHeadingText(text: "05.00\$ ",),
  //           ),)
  //       ],
  //   ),
  //   Image.asset(MyImages.HomeImg)
  // ],),
  //     ));
}

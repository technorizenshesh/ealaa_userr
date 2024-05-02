import 'package:ealaa_userr/import_ealaa_user.dart';
class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  TextEditingController name= TextEditingController();


  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
       body:
       Stack(
         children: [
           MapView(),
           Positioned(
             top:MediaQuery.of(context).size.height*0.10,
             child: Container(
               padding: EdgeInsets.all(20),
               width:MediaQuery.of(context).size.width,
               color: Colors.white.withOpacity(0.15),

               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       ParagraphText(text: "30 Jul, Sunday"),
                       MainHeadingText(text: "Hi, Convyy!")
                     ],
                   ),
                   Image.asset(
                     MyImages.userPro,
                     width: 36,
                     height: 36,
                   )
                 ],
               ),
             ),) ,
           Positioned(
               top:MediaQuery.of(context).size.height*0.25,
               right: 16,
               left: 16,

               child: GestureDetector(
                 onTap:(){
                   SelectAddress(context);
                 },
                 child: Container(
                   width: width,
                   padding: EdgeInsets.all(16),
                   decoration: BoxDecoration(
                     color: AppColors.whiteColor ,
                     borderRadius: BorderRadius.circular(12)
                   ),
                   child:   Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                 Row(children: [
                   Icon(Icons.circle,color: MyColors.primaryColor,size: 14,) ,
                   sizeBox_mq(context, width: 0.03, height: 0),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         children: [
                           Image.asset(MyImages.pin,height: 18,width: 18,),
                           sizeBox_mq(context, width: 0.02, height: 0),
                           ParagraphText(text: "Home",fontSize: 14,),
                         ],
                       ),
                     ],
                   )
                 ],),
                 Padding(
                   padding: const EdgeInsets.only(left: 2.0),
                   child: Column(
                     children: [
                       for(int i=0;i<5;i++)
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 1.0,
                             vertical: 2),
                         child: Icon(Icons.circle,color: MyColors.primaryColor
                             .withOpacity(0.40),size: 8,),
                       ),

                     ],
                   ),
                 ),
                 Row(children: [
                   Icon(Icons.circle,color: MyColors.primaryColor,size: 14,) ,
                   sizeBox_mq(context, width: 0.03, height: 0),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         children: [
                           Image.asset(MyImages.search,height: 18,width: 18,
                             color: MyColors.primaryColor,),
                           sizeBox_mq(context, width: 0.02, height: 0),
                           ParagraphText(text: "Where to go?",fontSize: 14,),
                         ],
                       ),
                     ],
                   )
                 ],),
             ],
           ),),
               ))
         ],
       ),
    );
  }
}

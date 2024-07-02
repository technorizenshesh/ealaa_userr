import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class VehicleDetailScreen extends StatefulWidget {
  const VehicleDetailScreen({super.key});

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  List<Map<String,String>> detailElements = [{'title':'Body','Image':'assets/images/carIcon.png'},
    {'title':'Body','Image':'assets/images/carIcon.png'},
    {'title':'Body','Image':'assets/images/carIcon.png'},
    {'title':'Body','Image':'assets/images/carIcon.png'},
    {'title':'Body','Image':'assets/images/carIcon.png'},
    {'title':'Body','Image':'assets/images/carIcon.png'}];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white)),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            margin: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.file_upload_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              child: CachedNetworkImage(
                imageUrl:
                    "https://media.istockphoto.com/id/1150931120/photo/3d-illustration-of-generic-compact-white-car-front-side-view.jpg?s=612x612&w=0&k=20&c=MkM3U9ruXp2wKCgYKeL6DyZ9H5WFIHtyRWsbOMokrFg=",
                fit: BoxFit.fill,
                height: 300,
                placeholder: (context, url) => Center(
                  child: Shimmer.fromColors(
                    baseColor: MyColors.onSecondary.withOpacity(0.4),
                    highlightColor: Theme.of(context).colorScheme.onSecondary,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      color: MyColors.onSecondary.withOpacity(0.4),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text('Mercedes C 300 2015',style: TextStyle(color: AppColors.grey,fontWeight: FontWeight.w500,fontSize: 16),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text("5000 OMR",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Divider(color: Colors.grey.withOpacity(0.2),),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,children: [
                Text("Details",style: TextStyle(color:Colors.black.withOpacity(0.5),fontSize: 18),),
                SizedBox(height: 10,),
                GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 100,
                    maxCrossAxisExtent: 170,
                    mainAxisExtent: 70,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: detailElements.length,
                    itemBuilder: (context, int index){
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${detailElements[index]['title']}",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 16),),
                            Image.asset("${detailElements[index]['image']}",color: Colors.black.withOpacity(0.5))
                          ],
                        ),
                        Text(
                          "sedan",style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 16,fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                    }
                )
              ],),
            )
          ],
        ),
      ),
    );
  }
}

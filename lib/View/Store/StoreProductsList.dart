import 'package:ealaa_userr/Model/StoreModel/GetProductByStoreModel.dart';
import 'package:ealaa_userr/View/Store/ProductDetails.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../Model/StoreModel/GetStoreByCategoryModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';

class StoreProductsList extends StatefulWidget {
  final GetStoreByCategoryResult storeDetails;
  const StoreProductsList({super.key, required this.storeDetails});

  @override
  State<StoreProductsList> createState() => _StoreProductsListState();
}

class _StoreProductsListState extends State<StoreProductsList> {
  List<GetProductByStoreResult> productList = [];
  bool showProductListLoader = true;
              List dominantColor=[];
  getProductByStore() async {
    var res = await Webservices.getMap
      ("$get_product_by_store?store_id=${widget.storeDetails.drId}&user_id=$userId");
    showProductListLoader=false;
    setState(() {
      
    });
    print("status from api ${res}");
    final resdata = GetProductByStoreModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      productList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }
     @override
  void initState() {
       getProductByStore();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
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
        title: Text(widget.storeDetails.sellerStoreName!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            )),
      ) ,
    body:
    showProductListLoader?
    LinearProgressIndicator(color: MyColors.primaryColor,)
        :productList.isEmpty?
    Container(height: height*0.5,child:
    Center(child:
    Image
        .asset("assets/images/NoDataFound.png"),),)
        :
    Padding(padding: EdgeInsets.symmetric(horizontal: 20),
    child:    GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 15,
          mainAxisSpacing: 25),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(productId:
                    productList[index].id)));
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    FutureBuilder<PaletteGenerator>(
                      future: PaletteGenerator.fromImageProvider(
                        NetworkImage(productList[index].productImage,scale: 10),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                          dominantColor.add(snapshot.data!.dominantColor!
                              .color) ;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: 200,
                              height: 120,
                              color: snapshot.data!.dominantColor!
                                  .color.withOpacity(0.2), // Set the background color based on the dominant color
                            ),
                          );
                        } else {
                          return Container(
                            width: 200,
                            height: 120,
                            color: Colors.transparent, // Placeholder color while loading
                          );
                        }
                      },
                    ),
                    Positioned(top:10,bottom:10,left:10,right:10,child: CachedNetworkImage(
                      imageUrl:
                      productList[index].productImage,
                      width: width * 0.14,
                      height: height * 0.06,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                    MainHeadingText(
                        text: productList[index].productName,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                    SizedBox(height: 5),
                    MainHeadingText(
                        text: "\$${productList[index].productPrice}",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xff009788)),
                    Row(children: [
                      Image.asset("assets/images/StarImage.png",height: 14,),
                      SizedBox(width: 10,),
                      Text("4.5")
                    ],)
                  ],),
                )

              ],
            ),
          ),
        );
      },
    ),),);
  }
}

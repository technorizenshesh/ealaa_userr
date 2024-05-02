import 'package:carousel_slider/carousel_slider.dart';
import 'package:ealaa_userr/Model/StoreModel/CategoryModel.dart';
import 'package:ealaa_userr/Model/StoreModel/GetStoreByCategoryModel.dart';
import 'package:ealaa_userr/View/Store/ImageBackgroundExample.dart';
import 'package:ealaa_userr/View/Store/ProductDetails.dart';
import 'package:ealaa_userr/View/Store/SearchProduct.dart';
import 'package:ealaa_userr/View/Store/StoreProductsList.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shimmer/shimmer.dart';

import '../../Model/BannerModel.dart';
import '../../Model/StoreModel/GetProductByCategoryModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/searchbar.dart';
import '../Utils/webService.dart';
import 'WishList.dart';

class StoreHomeTab extends StatefulWidget {
  const StoreHomeTab({Key? key}) : super(key: key);

  @override
  State<StoreHomeTab> createState() => _StoreHomeTabState();
}

class _StoreHomeTabState extends State<StoreHomeTab> {
  TextEditingController search = TextEditingController();
  List<CategoryResult> categoryList = [];
  List<BannerResult> bannerList = [];
  List<GetStoreByCategoryResult> storeList = [];
  int selectedCategoryIndex = -1;
  List<String> categoriesImage = [
    'assets/images/Clothes.png',
    "assets/images/Electronics.png",
    "assets/images/Shoes.png",
    "assets/images/Sports.png",
    "assets/images/Furniture.png"
  ];

  bool showStoreListLoader = true;

  getCategory() async {
    var res = await Webservices.getMap("$baseUrl$get_category");
    showStoreListLoader=false;
    setState(() {

    });
    print("loader ${showStoreListLoader}");
    print("status from api ${res}");
    final resdata = CategoryModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      categoryList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  getBanner() async {
    var res = await Webservices.getMap("$baseUrl$get_banner_product");
    print("status from api ${res}");
    final resdata = BannerModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      bannerList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  // getProductByCategory(String id) async {
  //   productList = [];
  //   setState(() {});
  //   var res = await Webservices.getMap("$baseUrl$get_product_by_category?category_id=$id&user_id=$userId");
  //   print("status from api ${res}");
  //   final resdata = GetProductByCategoryModel.fromJson(res);
  //   print("status.....${resdata.status}");
  //   if (resdata.status == '1') {
  //     productList = resdata.result;
  //     setState(() {});
  //   } else {
  //     showSnackbar(context, resdata.message);
  //   }
  // }

  getStoreByCategory(String id) async {
    storeList = [];
    setState(() {});
    var res = await Webservices.getMap("$baseUrl$get_store_by_category?category_id=$id&user_id=$userId");
    print("status from api ${res}");
    final resdata = GetStoreByCategoryModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      storeList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message!);
    }
  }
  @override
  void initState() {
    getCategory();
    getBanner();
   // getProductByCategory("0");
    getStoreByCategory("0");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
          title: Text("Store",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              )),
      actions: [InkWell(onTap:(){
        push(context: context, screen: WishList());
      },child: Padding(padding:EdgeInsets.all(20),child: Image.asset("assets/images/HeartFilledIcon.png")))],),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20,0,20,10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  push(context: context, screen: SearchProduct());
                },
                child: CustomSearchbar(
                  onChanged: (String text) {
                    //  filterRoomNameList(text);
                  },
                  enabled: false,
                  controller: search,
                  hintText: 'Search All Cagegories...',
                  textcolor: MyColors.whitecolor,
                  bgColor: MyColors.lightgreycolor1,
                  prefixIcon: MyImages.search,
                  borderradius: 50,
                  // suffixIcon: MyImages.Filter,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              bannerList.isEmpty
                  ? Shimmer.fromColors(
                  baseColor: MyColors.onSecondary
                      .withOpacity(0.4),
                  highlightColor: Theme.of(context).colorScheme.onSecondary,
                  child: Container(     height: 200, decoration: BoxDecoration(borderRadius:
                  BorderRadius.circular(30),  color: MyColors.onSecondary
                      .withOpacity(0.4),),

                  ),
                )

                  :
              CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 200,
                        //height: MediaQuery.of(context).size.height / 6,
                        aspectRatio: 10.5 / 9,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      itemCount: bannerList.length,
                      itemBuilder: (context, int index, int realIndex) {
                        return
                          Container(
                          width: width,
                          height: height * 0.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              bannerList[index].image,
                              fit: BoxFit.fill,filterQuality: FilterQuality.high,
                            ),
                          ),
                        );
                      },
                    ),
              // Image.asset('assets/images/StorebannerImage.png'),
              SizedBox(
                height: height * 0.02,
              ),
              MainHeadingText(
                text: "Categories",
                fontSize: 20,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              categoryList.isEmpty
                  ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 5; i++)
                          Shimmer.fromColors(
                            baseColor: MyColors.onSecondary
                                .withOpacity(0.4),
                            highlightColor: Theme.of(context).colorScheme.onSecondary,
                            child:
                                  Column(
                                    children: [
                                      Container(
                                        height:60,width:60,decoration:
                                      BoxDecoration
                                          (borderRadius:
                                      BorderRadius.circular(50),  color: MyColors
                                          .onSecondary
                                          .withOpacity(0.4),),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 10,
                                        color: MyColors
                                            .onSecondary
                                            .withOpacity(0.4),
                                      )
                                    ],
                                  )

                          ),
                ],
              )
                  :
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < categoryList.length; i++)
                            GestureDetector(
                              onTap: (){
                                // Update the selected category index
                                setState(() {
                                  selectedCategoryIndex = i;
                                });
                                // Call the method to get products by category
                                getStoreByCategory(categoryList[i].id);
                              },
                              child: Column(
                                children: [
                                  // Apply color based on the selected category
                                  Container(
                                    decoration: BoxDecoration(
                                      color: selectedCategoryIndex == i ? MyColors.primaryColor.withOpacity(0.1) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Image.asset(
                                      categoriesImage[i],
                                      height: 70,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    categoryList[i].categoryName,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: selectedCategoryIndex == i ? MyColors.primaryColor : Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              MainHeadingText(
                text: "Recommendation",
                fontSize: 20,
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
                child:
                showStoreListLoader?
                Shimmer.fromColors(
                  baseColor: MyColors.onSecondary
                      .withOpacity(0.4),
                  highlightColor: Theme.of(context).colorScheme.onSecondary,
                  child: Container(       width: 150,
                    height: 150, decoration: BoxDecoration(borderRadius:
                    BorderRadius.circular(16),  color: MyColors.onSecondary
                        .withOpacity(0.4),),

                  ),
                ) :storeList.isEmpty?
                Center(child:
                Image
                    .asset("assets/images/NoDataFound.png"),)
                    :
                GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: storeList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 25),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoreProductsList
                                  (storeDetails: storeList[index],)));
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
                        ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      width: 200,
                                      height: 120,
                                      child: CachedNetworkImage(
                                        imageUrl:storeList[index]
                                            .sellerUploadPicture!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                      // the dominant color
                                    ),
                                  ) ,

                            // Stack(
                            //   children: [
                            //     FutureBuilder<PaletteGenerator>(
                            //       future: PaletteGenerator.fromImageProvider(
                            //         NetworkImage(storeList[index]
                            //             .sellerUploadPicture,scale: 10),
                            //       ),
                            //       builder: (context, snapshot) {
                            //         if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                            //           Color dominantColor = snapshot.data!.dominantColor!.color.withOpacity(0.2);
                            //           return ClipRRect(
                            //             borderRadius: BorderRadius.circular(16),
                            //             child: Container(
                            //               width: 200,
                            //               height: 120,
                            //               color: dominantColor, // Set the background color based on the dominant color
                            //             ),
                            //           );
                            //         } else {
                            //           return Container(
                            //             width: 200,
                            //             height: 120,
                            //             color: Colors.transparent, // Placeholder color while loading
                            //           );
                            //         }
                            //       },
                            //     ),
                            //     Positioned(top:10,bottom:10,left:10,right:10,child: Image.network(
                            //       storeList[index].sellerUploadPicture,
                            //       filterQuality: FilterQuality.high,
                            //       fit: BoxFit.fill,
                            //     ),)
                            //   ],
                            // ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                                MainHeadingText(
                                    text: storeList[index].sellerStoreName!,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                                SizedBox(height: 5),
                                // MainHeadingText(
                                //     text: "\$${productList[index].productPrice}",
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 14,
                                //     color: Color(0xff009788)),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ealaa_userr/Model/StoreModel/AddToCartModel.dart';
import 'package:ealaa_userr/Model/StoreModel/ProductDetailsModel.dart';
import 'package:ealaa_userr/Model/StoreModel/WishListModel.dart';
import 'package:ealaa_userr/View/Store/storeBottomBar.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class ProductDetails extends StatefulWidget {
  final String productId;

  const ProductDetails({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductDetailsResult? productDetailsResult;
  bool isWishList = false;
  Color? dominantColor;
  int activeIndex = 0;
  getProductDetails() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_product_details?product_id=${widget
            .productId}&user_id=$userId");
    print("status from api ${json.encode(res).toString()}");
    final resdata = ProductDetailsModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      productDetailsResult = resdata.result;
      productDetailsResult!.wishListStatus=="true"?isWishList=true:false;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  addToWishlist() async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "product_id": widget.productId
    };
    var res = await Webservices.postData(
        apiUrl: "$add_to_wishlist", body: data, context: context);
    print("status from api ${res}");
    final resdata = WishListModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      showSnackbar(context, resdata.message);
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  addToBag() async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "product_id": widget.productId,
      "quantity":"1"
    };
    print("data.....$data");
    var res = await Webservices.postData(
        apiUrl: "$add_to_cart", body: data, context: context);
    print("status from api ${res}");
    final resdata = AddToCartModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      currentindex=2;
      selectedValue.value = CurrentTabIndex.third;
      setState(() {});
      Navigator.pop(context);
      Navigator.pop(context);
      showSnackbar(context, resdata.message);
    } else {
      showSnackbar(context, resdata.message);
    }
  }
  @override
  void initState() {
    getProductDetails();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: MyColors.primaryColor.withOpacity(0.2),
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        toolbarHeight: 70,
        backgroundColor: MyColors.primaryColor.withOpacity(0.2),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset("assets/images/backButtonOrange.svg"),
          ),
        ),
        actions: [
          SvgPicture.asset("assets/images/shareIcon.svg"),
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset("assets/images/BagIcon.svg"),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: width,
        height: height * 0.1,
        decoration: BoxDecoration(
          color: MyColors.primaryColor, // Set your desired color here
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Price",
                    style: TextStyle(color: Colors.white.withOpacity(0.6)),
                  ),
                  MainHeadingText(
                    text: "\$${productDetailsResult?.productPrice??""}",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )
                ],
              ),
              RoundButton(
                title: 'ADD TO BAG',
                width: 150,
                height: 50,
                fontsize: 14,
                fontweight: FontWeight.w500,
                borderRadius: 40,
                btnColor: Color(0xff393F48),
                onTap: () {
                  addToBag();
                },
              )
            ],
          ),
        ),
      ),
      body: productDetailsResult == null || productDetailsResult == {}
          ? Center(child: CircularProgressIndicator(color: MyColors.primaryColor,))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
      Container(
      height: height * 0.35,
        color:
       // widget.dominantColor.withOpacity(0.2), // Set the background color
        MyColors.primaryColor.withOpacity(0.2)
        // based on the dominant color
      ),
                    // Container(height: height * 0.35, color: Color(0xffE0EAEB)),
                    Positioned(
                      child:
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 3),
                            viewportFraction: 1,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (index, reason) =>
                                setState(() => activeIndex = index),
                          ),
                          itemCount: 3,
                          itemBuilder: (context, int index, int realIndex) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: width,
                              height: height * 0.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CachedNetworkImage(
                                  imageUrl:productDetailsResult!.productImage,
                                  // width: 100,
                                  // height: 100,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Center(child:     Shimmer.fromColors(
                                    baseColor: MyColors.onSecondary
                                        .withOpacity(0.4),
                                    highlightColor: Theme.of(context).colorScheme.onSecondary,
                                    child: Container(       width: 200,
                                      height: 200, decoration: BoxDecoration
                                        (borderRadius:
                                      BorderRadius.circular(16),  color: MyColors.onSecondary
                                          .withOpacity(0.4),),

                                    ),
                                  )),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                        ),

                      // Center(
                      //     child: Image.network(
                      //   productDetailsResult!.productImage,
                      //   height: 200,
                      // )),
                    ),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          onPressed: () {
                            isWishList = !isWishList;
                            addToWishlist();
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.favorite_sharp,
                            color: isWishList
                                ? MyColors.primaryColor
                                : Colors.grey,
                          ),
                        )),
                    Positioned(
                        bottom: 15,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(padding: EdgeInsets.symmetric
                                (horizontal: 10,vertical: 5),decoration:BoxDecoration(color: Colors
                                  .white.withOpacity(0.3),borderRadius:
                              BorderRadius.circular(10)),child:  
                          AnimatedSmoothIndicator(
                            activeIndex: activeIndex,
                                count: 3,
                                effect: const ExpandingDotsEffect(
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  activeDotColor: MyColors.primaryColor,
                                  dotColor: Color(0xffD9D9D9),
                                ),
                              ),) ,

                              Image.asset(
                                "assets/images/ChatIcon.png",
                                height: 40,
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      MainHeadingText(text: productDetailsResult!.productName),
                      SizedBox(
                        height: 10,
                      ),
                      MainHeadingText(
                        text: "100+ viewed in past month",
                        color: Color(0xffC3C6C9),
                        fontSize: 14,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MainHeadingText(
                          text: "\$${productDetailsResult!.productPrice}",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: MyColors.primaryColor),
                      SizedBox(
                        height: 10,
                      ),
                      MainHeadingText(
                        text: productDetailsResult!.description,
                        color: Color(0xffC3C6C9),
                        fontSize: 14,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      MainHeadingText(
                        text: "Color",
                        fontSize: 18,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MainHeadingText(
                        text: productDetailsResult!.productColor,
                        color: Color(0xffC3C6C9),
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

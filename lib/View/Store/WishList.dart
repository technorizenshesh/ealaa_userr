import 'package:ealaa_userr/View/Store/ProductDetails.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../../Model/StoreModel/WishListModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  bool isDataFound = false;
  List<WishListResult> wishList = [];

  getWishList() async {
    Map<String, dynamic> data = {
      "user_id": userId,
    };
    isDataFound = true;
    var res = await Webservices.postData(
        apiUrl: "$get_wishlist", body: data, context: context);
    isDataFound = false;
    setState(() {});
    print("status from api ${res}");
    final resdata = WishListModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      wishList = resdata.result;
      setState(() {});
      showSnackbar(context, resdata.message);
    } else {
       wishList=[];
       setState(() {});
      showSnackbar(context, resdata.message);
    }
  }

  removeFromWishlist(String id, int index) async {
    Map<String, dynamic> data = {"user_id": userId, "product_id": id};
    var res = await Webservices.postData(
        apiUrl: "$add_to_wishlist", body: data, context: context);
    print("status from api ${res}");
    final resdata = WishListModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      wishList.removeAt(index);
      setState(() {});
      showSnackbar(context, resdata.message);
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
    getWishList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            title: Text("Wishlist",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ))),
        body: isDataFound
            ? LinearProgressIndicator(
                color: MyColors.primaryColor,
              )
            : wishList.isEmpty
                ? Container(
                    height: height * 0.5,
                    child: Center(
                      child: Image.asset("assets/images/NoDataFound.png"),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: width,
                      height: height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < wishList.length; i++)
                              GestureDetector(
                                onTap: () async {
                                  await push(
                                      context: context,
                                      screen: ProductDetails(
                                          productId: wishList[i].productId));
                                  print("hiiii");
                                  getWishList();
                                },
                                child: Container(
                                  width: width,
                                  height: height * 0.15,
                                  child: Card(
                                      color: Colors.white,
                                      elevation: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: width * 0.3,
                                                  height: height * 0.12,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl: wishList[i]
                                                          .productImage,
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.fill,
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child: Shimmer
                                                                  .fromColors(
                                                        baseColor: MyColors
                                                            .onSecondary
                                                            .withOpacity(0.4),
                                                        highlightColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onSecondary,
                                                        child: Container(
                                                          height: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: MyColors
                                                                .onSecondary
                                                                .withOpacity(
                                                                    0.4),
                                                          ),
                                                        ),
                                                      )),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    MainHeadingText(
                                                      text: wishList[i]
                                                          .productName,
                                                      fontSize: 18,
                                                    ),
                                                    ParagraphText(
                                                      text: "color : Made blue",
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                    ),
                                                    MainHeadingText(
                                                      text:
                                                          "\$ ${wishList[i].productAmount}",
                                                      fontSize: 15,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            IconButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: () {
                                                removeFromWishlist(
                                                    wishList[i].productId, i);
                                              },
                                              icon: Icon(
                                                Icons.favorite_sharp,
                                                color: MyColors.primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                      // ListTile(
                                      //   leading:      Stack(
                                      //     children: [
                                      //       FutureBuilder<PaletteGenerator>(
                                      //         future: PaletteGenerator.fromImageProvider(
                                      //           NetworkImage(wishList[i].productImage),
                                      //         ),
                                      //         builder: (context, snapshot) {
                                      //           if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                      //             Color dominantColor = snapshot.data!.dominantColor!.color.withOpacity(0.2);
                                      //             return ClipRRect(
                                      //               borderRadius: BorderRadius.circular(16),
                                      //               child: Container(
                                      //             decoration: BoxDecoration(color: dominantColor,
                                      //             shape: BoxShape.rectangle),
                                      //               ),
                                      //             );
                                      //           } else {
                                      //             return Container(
                                      //               color: Colors.transparent, // Placeholder color while loading
                                      //             );
                                      //           }
                                      //         },
                                      //       ),
                                      //       Positioned(top:10,bottom:10,left:10,right:10,child: Image.network(
                                      //         wishList[i].productImage,
                                      //         filterQuality: FilterQuality.high,
                                      //       ),)
                                      //     ],
                                      //   ),
                                      // ),
                                      ),
                                  margin: EdgeInsets.only(bottom: 15),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  )

        // Container(
        //   width: width,
        //   height: height,
        //   child: Image.asset("assets/images/Frame 1171275457.png",fit: BoxFit.cover,),
        // ),
        );
  }
}

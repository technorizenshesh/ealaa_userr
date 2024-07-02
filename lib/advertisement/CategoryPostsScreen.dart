import 'package:ealaa_userr/advertisement/AddPost/Vehicles/VehicleDetailScreen.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryPostsScreen extends StatefulWidget {
  const CategoryPostsScreen({super.key});

  @override
  State<CategoryPostsScreen> createState() => _CategoryPostsScreenState();
}

class _CategoryPostsScreenState extends State<CategoryPostsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return VehicleDetailScreen();
                  },
                ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.46,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://media.istockphoto.com/id/1150931120/photo/3d-illustration-of-generic-compact-white-car-front-side-view.jpg?s=612x612&w=0&k=20&c=MkM3U9ruXp2wKCgYKeL6DyZ9H5WFIHtyRWsbOMokrFg=",
                            fit: BoxFit.fill,
                            height: 200,
                            placeholder: (context, url) => Center(
                              child: Shimmer.fromColors(
                                baseColor:
                                    MyColors.onSecondary.withOpacity(0.4),
                                highlightColor:
                                    Theme.of(context).colorScheme.onSecondary,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  color: MyColors.onSecondary.withOpacity(0.4),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              "Ford Mustang GT Callifornia Special 2019",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "9900 OMR",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.1))),
                                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                  child:
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        color: Colors.black.withOpacity(0.5),
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "Share",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.pin_drop,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '53000 km',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  Expanded(child: Divider()),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.pin_drop,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '53000 km',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  Expanded(child: Divider()),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.pin_drop,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '53000 km',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

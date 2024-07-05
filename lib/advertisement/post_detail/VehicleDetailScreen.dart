import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Model/advertisement_model/get_ads_post_details_model.dart';
import '../../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/webService.dart';

class VehicleDetailScreen extends StatefulWidget {
  String ads_post;
  String ads_post_id;

  VehicleDetailScreen(
      {super.key, required this.ads_post, required this.ads_post_id});

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  List<Map<String, String>> detailElements = [
    {'title': 'Body', 'Image': 'assets/icons_for_car/ic_body.png'},
    {'title': 'Model Year', 'Image': 'assets/icons_for_car/ic_model_year.png'},
    {'title': 'Condition', 'Image': 'assets/icons_for_car/ic_model_year.png'},
    {'title': 'Origin', 'Image': 'assets/icons_for_car/ic_model_year.png'},
    {
      'title': 'Transmission',
      'Image': 'assets/icons_for_car/ic_transmission.png'
    },
    {
      'title': 'Exterior Color',
      'Image': 'assets/icons_for_car/ic_exterior_color.png'
    },
    {'title': 'Door Count', 'Image': 'assets/icons_for_car/ic_door_count.png'},
    {'title': 'Seats', 'Image': 'assets/icons_for_car/ic_seats.png'},
    {
      'title': 'Interior Color',
      'Image': 'assets/icons_for_car/ic_interior_color.png'
    },
    {
      'title': 'Engine Size',
      'Image': 'assets/icons_for_car/ic_engine_size.png'
    },
    {'title': 'Cylinders', 'Image': 'assets/icons_for_car/ic_engine_size.png'},
    {'title': 'Fuel', 'Image': 'assets/icons_for_car/ic_fuel.png'},
    {'title': 'Drivetrain', 'Image': 'assets/icons_for_car/ic_drivetrain.png'},
    {'title': 'Plate', 'Image': 'assets/icons_for_car/ic_drivetrain.png'},
    {'title': 'Location', 'Image': 'assets/icons_for_car/ic_drivetrain.png'},
    {'title': 'Kilometers', 'Image': 'assets/icons_for_car/ic_kilometer.png'},
    {'title': 'Miles', 'Image': 'assets/icons_for_car/ic_kilometer.png'},
    {'title': 'Price', 'Image': 'assets/icons_for_car/ic_price.png'},
    {'title': 'Ad Number', 'Image': 'assets/icons_for_car/ic_body.png'},
    {'title': 'Published Date', 'Image': 'assets/icons_for_car/ic_body.png'},
  ];

  bool showProgressBar = true;
  PostListDetails? result;

  getAdsPostDetails() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_ads_post_details?ads_post=${widget.ads_post_id}&ads_post_id=${widget.ads_post}");
    showProgressBar = false;
    GetAdsPostDetailsModel getAdsPostDetailsModel =
        GetAdsPostDetailsModel.fromJson(res);
    if (getAdsPostDetailsModel.result != null) {
      result = getAdsPostDetailsModel.result!;
      setState(() {});
    } else {
      showSnackbar(context, 'Something went wrong!');
      showProgressBar = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    getAdsPostDetails();
    super.initState();
  }

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
        /* actions: [
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
        ],*/
      ),
      body: SingleChildScrollView(
        child: showProgressBar
            ? Center(
                child: CircularProgressIndicator(
                  color: MyColors.primaryColor,
                ),
              )
            : result == null
                ? Image.asset("assets/images/NoDataFound.png")
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        child: CachedNetworkImage(
                          imageUrl: result?.vehicleAdsUploadImage ?? '',
                          fit: BoxFit.fill,
                          height: 300,
                          placeholder: (context, url) => Center(
                            child: Shimmer.fromColors(
                              baseColor: MyColors.onSecondary.withOpacity(0.4),
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
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          result?.vehicleAdsAdditionalDetailDescription ?? '',
                          maxLines: 1,
                          style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "${result?.vehicleAdsAdditionalDetailPrice ?? ''} OMR",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Details",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  childAspectRatio: 100,
                                  maxCrossAxisExtent: 170,
                                  mainAxisExtent: 70,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: detailElements.length,
                                itemBuilder: (context, int index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.3)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${detailElements[index]['title']}",
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: 16),
                                            ),
                                            Image.asset(
                                              "${detailElements[index]['Image']}",
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              height: 18,
                                              width: 18,
                                            )
                                          ],
                                        ),
                                        Text(
                                          getTextMethod(index: index),
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              result?.vehicleAdsAdditionalDetailDescription ??
                                  '',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact the seller",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: Image.network(
                                      (result != null &&
                                              result!.usersDetails != null &&
                                              result!.usersDetails!.image !=
                                                  null &&
                                              result!.usersDetails!.image!
                                                  .isNotEmpty)
                                          ? result!.usersDetails!.image!
                                          : 'https://avatar.iran.liara.run/public/37',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (result != null &&
                                            result!.usersDetails != null &&
                                            result!.usersDetails!.fullName !=
                                                null &&
                                            result!.usersDetails!.fullName!
                                                .isNotEmpty)
                                        ? result?.usersDetails?.fullName ?? ''
                                        : 'Unnamed',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    (result != null &&
                                            result!.usersDetails != null &&
                                            result!.usersDetails!.email !=
                                                null &&
                                            result!.usersDetails!.email!
                                                .isNotEmpty)
                                        ? result?.usersDetails?.email ?? ''
                                        : 'Unnamed',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
      ),
    );
  }

  String getTextMethod({required int index}) {
    switch (index) {
      case 0:
        return result?.vehicleAdsDetailGovernate??'';
      case 1:
        return result?.vehicleAdsDetailYear??'';
      case 2:
        return result?.vehicleAdsDetailCondition??'';
      case 3:
        return result?.vehicleAdsDetailOrigin??'';
      case 4:
        return result?.vehicleAdsDetailTransmission??'';
      case 5:
        return result?.vehicleAdsDetailExteriorColor??'';
      case 6:
        return result?.vehicleAdsDetailDoors??'';
      case 7:
        return result?.vehicleAdsDetailSeats??'4';
      case 8:
        return result?.vehicleAdsDetailInteriorColor??'';
      case 9:
        return result?.vehicleAdsDetailEngineSize??'';
      case 10:
        return result?.vehicleAdsDetailCylinders??'';
      case 11:
        return result?.vehicleAdsDetailFuel??'';
      case 12:
        return result?.vehicleAdsDetailDriveTrain??'';
      case 13:
        return result?.vehicleAdsDetailPlate??'';
      case 14:
        return result?.vehicleAdsDetailState??'';
      case 15:
        return result?.vehicleAdsAdditionalDetailDistanceTravelled??'';
      case 16:
        return result?.vehicleAdsAdditionalDetailDistanceTravelled??'';
      case 17:
        return result?.vehicleAdsAdditionalDetailPrice??'';
      case 18:
        return result?.vehicleAdsDetailPlate??'';
      case 19:
        return result?.adsCreatedAt??'';
      default:
        return 'test';
    }
  }
}
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Model/StoreModel/GetStoreOngoingModel.dart';

class OrderProductDetailScreen extends StatefulWidget {
  final ProductDetails productDatails;
  const OrderProductDetailScreen({super.key, required this.productDatails});

  @override
  State<OrderProductDetailScreen> createState() => _OrderProductDetailScreenState();
}

class _OrderProductDetailScreenState extends State<OrderProductDetailScreen> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            scrolledUnderElevation: 0,
            toolbarHeight: 80,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset("assets/images/backButton.svg")),
            ),
            centerTitle: true,
            title: Text(widget.productDatails.productName!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ))),
        body:
        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child:
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,children: [
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
                  margin: EdgeInsets.only(right: 16),
                  height: 200,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      imageUrl:widget.productDatails.productImage!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10,),
            Container(width: width,
              child:   Center(child:  Container(padding: EdgeInsets.symmetric
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
              ),),),),
            SizedBox(height: 20,),
            MainHeadingText(
              text: "Product Price",
              fontSize: 18,
            ),
            SizedBox(height: 5,),
            MainHeadingText(
                text: "\$${widget.productDatails.productPrice}",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: MyColors.primaryColor),
            SizedBox(
              height: 20,
            ),
            MainHeadingText(
              text: "Product Description",
              fontSize: 18,
            ),
            SizedBox(height: 5,),
            MainHeadingText(
              text: widget.productDatails.description!,
              color: Colors.grey,
              fontSize: 16,
            ),
            SizedBox(
              height: 20,
            ),
            MainHeadingText(
              text: "Product Color",
              fontSize: 18,
            ),
            SizedBox(
              height: 10,
            ),
            MainHeadingText(
              text: widget.productDatails.productColor!,
              color: Colors.grey,
              fontSize: 16,
            ),

            SizedBox(
              height: 20,
            ),
            MainHeadingText(
              text: "Product Size",
              fontSize: 18,
            ),
            SizedBox(height: 5,),
            MainHeadingText(
              text: widget.productDatails.productSize!,
              color: Colors.grey,
              fontSize: 16,
            ),
            SizedBox(
              height: 20,
            ),
            MainHeadingText(
              text: "Product Reviews",
              fontSize: 18,
            ),
            SizedBox(height: 5,),
            MainHeadingText(
              text: "100+ viewed in past month",
              color: Colors.grey,
              fontSize: 16,
            ),
          ],),)
    );
  }
}

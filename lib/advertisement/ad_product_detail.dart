import 'package:carousel_slider/carousel_slider.dart';
import 'package:ealaa_userr/advertisement/chat_message_detail.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AdProductDetail extends StatefulWidget {
  final String image;
  const AdProductDetail({super.key, required this.image});

  @override
  State<AdProductDetail> createState() => _AdAdsState();
}

class _AdAdsState extends State<AdProductDetail> {
  int activeIndex = 0;
  bool showProgressBar = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> share() async {
    try {
      Share.share('Hii....');
    } catch (e) {
      print('Share Error: $e');
    }
  }

  clickOnChatButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdChatMessageDetail()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      // Assign the key to Scaffold.
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
        centerTitle: true,
        title: const Text(
          'Product Detail', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      share();
                    },
                    child: const Icon(
                      Icons.share,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  // SvgPicture.asset("assets/images/Notification.svg",height: 30,color: MyColors.primaryColor,)
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: height * 0.5,
                    aspectRatio: width / height * 0.5,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                  ),
                  itemCount: 4,
                  itemBuilder: (context, int index, int realIndex) {
                    return Container(
                      width: width,
                      height: height * 0.5,
                      child: Image.asset(
                        widget.image,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Image.asset(
                    MyImages.icUnlike,
                    height: 50,
                    width: 50,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 40,
                  right: 15,
                  child: Container(
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: const Text(
                      '5 Likes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.orange),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Center(
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 4,
                effect: const ExpandingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: MyColors.primaryColor,
                  dotColor: Color(0xffD9D9D9),
                ),
              ),
            ),
            const ListTile(
              title: Text(
                'Product Name',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange),
              ),
              trailing: Text(
                'AED- 33,000',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.orange),
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              title: Text(
                'NEW IN CONDITION',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black54),
              ),
              trailing: Text(
                '3 days ago by',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.black54),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Blk #01-02, 304 Serangoon Ave 2, Block 304,Singapore 550304 ',
                style: TextStyle(fontSize: 16, color: Colors.orange),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Meet The Seller',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'assets/images/Ellipse 1.png',
                height: 60,
                width: 60,
                fit: BoxFit.fill,
              ),
              title: const Text(
                'Polakowsk',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange),
              ),
              subtitle: const Text(
                'Joined 3 days ago',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black54),
              ),
              trailing: const Text(
                'AED- 33,000',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.orange),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            CommonWidget.commonElevatedButton(
              onPressed: () {
                clickOnChatButton();
              },
              context: context,
              child: const Text(
                'Chat',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              buttonMargin:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              buttonColor: Colors.orange,
            ),
            CommonWidget.commonElevatedButton(
              onPressed: () {},
              context: context,
              child: const Text(
                'Make Offer',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange),
              ),
              buttonMargin:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              buttonColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Utils/searchbar.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height*0.05,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: CustomSearchbar(
              onChanged: (String text) {
                //  filterRoomNameList(text);
              },
              controller: search,
              hintText: 'Search All Cagegories...',
              textcolor: MyColors.whitecolor,
              bgColor: MyColors.lightgreycolor1,
              prefixIcon: MyImages.search,
              borderradius: 50,
              // suffixIcon: MyImages.Filter,
            ),
          ),
          GestureDetector(
              onTap: (){
                // push(context: context, screen: ProductDetails(productId: '1',));
              },
              child: Image.asset("assets/images/Frame 1171275458.png",fit: BoxFit.cover,))
        ],
      ),
    );
  }
}

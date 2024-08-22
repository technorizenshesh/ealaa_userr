import 'package:ealaa_userr/import_ealaa_user.dart';

import 'VehicleNumbers.dart';

class TransferType extends StatefulWidget {
  String advertisement_category_id = '';

  TransferType({
    super.key,
    required this.advertisement_category_id,
  });

  @override
  State<TransferType> createState() => _TransferTypeState();
}

class _TransferTypeState extends State<TransferType> {
  List<Map<String, String>> icons = [
    {"icon": "assets/images/SaleIcon.svg", "text": "For Sale"},
    //{"icon": "assets/images/RentIcon.svg", "text": "For Rent"},
    {"icon": "assets/images/WantedIcon.svg", "text": "Wanted"}
  ];

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        title: Text(
          "Transfer Type", // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: GridView.builder(
             //physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisExtent: 130),
          itemCount: icons.length,
          itemBuilder: (context, int index) {
            //  GetClubsResult item = controller.getClubsModel!.result![index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VehicleNumbers(type:icons[index]['text']??"",
                      // title: subcategoryList[index].subCategoryName?? '',
                      // advertisement_category_id:
                      // advertisementCategoryList[index].id ?? '',
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.grey, width: .25),
                    right: BorderSide(color: Colors.grey, width: .25),
                    bottom: BorderSide(color: Colors.grey, width: .5),
                  ),
                  // color: Colors.red,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200, // Set the width of the image here
                      height: 80,
                      child: ClipRRect(
                          //  borderRadius: BorderRadius.circular(10),
                          child: SvgPicture.asset(
                        icons[index]["icon"]!,
                        fit: BoxFit.cover,
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      icons[index]["text"]!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

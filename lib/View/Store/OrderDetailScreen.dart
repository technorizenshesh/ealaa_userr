import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../Model/StoreModel/GetStoreOngoingModel.dart';
import '../Screens/OrderProductDetailScreen.dart';

class OrderDetailScreen extends StatefulWidget {
  final GetStoreOngoingResult orderDetails;
  OrderDetailScreen({super.key, required this.orderDetails});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
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
          title: Text("Order ${widget.orderDetails.id}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                      itemCount: widget.orderDetails.productDetails!.length,
                      itemBuilder: (
                          BuildContext ctx,
                          index,
                          ) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                push(
                                    context: context,
                                    screen: OrderProductDetailScreen(
                                      productDatails: widget
                                          .orderDetails.productDetails![index],
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: MyColors.primaryColor
                                            .withOpacity(0.5),
                                        width: 1.5)),
                                child: ListTile(
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: MyColors.primaryColor
                                            .withOpacity(0.5),
                                        // Border
                                        // color
                                        width: 2.0, // Border width
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl: widget
                                            .orderDetails
                                            .productDetails![index]
                                            .productImage!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                              color: MyColors.primaryColor,
                                              strokeWidth: 2,
                                            )),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    widget.orderDetails.productDetails![index]
                                        .productName!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    "Qty : ${widget.orderDetails
                                        .productDetails![index].quantity!}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Text(
                                    "\$ ${widget.orderDetails
                                        .productDetails![index].productPrice!}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Text(
                      "Total Amount :   ",
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "\$ ${widget.orderDetails.amount}",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Order Date     :   ",
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "${widget.orderDetails.orderDate}",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Order Time     :   ",
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "${widget.orderDetails.orderTime}",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

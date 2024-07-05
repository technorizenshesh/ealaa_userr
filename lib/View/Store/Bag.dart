import 'package:ealaa_userr/Model/GeneralModel.dart';
import 'package:ealaa_userr/Model/StoreModel/AddAddressModel.dart';
import 'package:ealaa_userr/Model/StoreModel/GetCartModel.dart';
import 'package:ealaa_userr/View/Store/AddAddress.dart';
import 'package:ealaa_userr/View/Store/web_view_store.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../Model/StoreModel/AddToCartModel.dart';
import '../../Model/StoreModel/PlaceOrderModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class Bag extends StatefulWidget {
  const Bag({Key? key}) : super(key: key);

  @override
  State<Bag> createState() => _BagState();
}

class _BagState extends State<Bag> {
  bool isLoading = false;
  bool showBagDataLoader = true;
  List<GetCartResult> getCartList = [];
  List<AddAddressResult> addressList = [];
  String subtotal = "0";
  String selectedAddressId = "";
  List<String> cartIds = [];
  List<String> productIds = [];

  //= elements.join(', ');
  getCart() async {
    Map<String, dynamic> data = {
      "user_id": userId,
    };
    var res = await Webservices.postData(
        apiUrl: get_cart, body: data, context: context);
    showBagDataLoader = false;
    setState(() {});
    print("status from api ${res}");
    final resdata = GetCartModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      getCartList = resdata.result;
      getCartList.forEach((element) {
        cartIds.add(element.id);
        productIds.add(element.productId);
      });
      print('cartIds::::::::::::${cartIds}');
      print('cartIds::::::::::::${cartIds.join(',')}');
      subtotal = resdata.totalAmount ?? "0";
      setState(() {});
    } else {}
  }

  removeProductFromCart(String cartId) async {
    Map<String, dynamic> data = {"user_id": userId, "cart_id": cartId};
    var res = await Webservices.postData(
        apiUrl: delete_cart_data, body: data, context: context);
    print("status from api ${res}");
    final resdata = GeneralModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      getCart();
    } else {}
  }

  getAddress() async {
    var res = await Webservices.getMap("${get_address}?user_id=$userId");
    print("status from api ${res}");
    final resdata = AddAddressModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      addressList = resdata.result;
      setState(() {});
    } else {}
  }

  addToBag(String productId, String quantity) async {
    isLoading = true;
    setState(() {});
    Map<String, dynamic> data = {
      "user_id": userId,
      "product_id": productId,
      "quantity": quantity
    };
    var res = await Webservices.postData(
        apiUrl: "$add_to_cart", body: data, context: context);
    print("status from api ${res}");
    final resdata = AddToCartModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      showSnackbar(context, resdata.message);
      getCart();
    } else {
      showSnackbar(context, resdata.message);
    }
    isLoading = false;
    setState(() {});
  }

  placeOrder() async {
    isLoading = true;
    setState(() {});
    Map<String, dynamic> data = {
      "user_id": userId,
      "store_id": getCartList[0].userId,
      "product_id": productIds.join(','),
      "cart_id": cartIds.join(','),
      "amount": subtotal.toString(),
    };
    print("data is....$data");
    var res = await Webservices.postData(
        apiUrl: "$place_order", body: data, context: context);
    print("status from api ${res}");
    final resdata = PlaceOrderModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      String url =
          'https://11way.solutions/webservice/payment_store?amount=${double
          .parse(resdata.result!.amount).ceil()}'
          '&user_id=$userId&place_order_id=${resdata.result!.id}&store_id=${resdata.result!.storeId}&name=test&address_id=$selectedAddressId';
      print("url::::::::::::::::::::::$url");
      push(
          context: context,
          screen: WebViewStore(
            url: url,
          ));
    } else {
      showSnackbar(context, resdata.message);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getCart();
    getAddress();
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
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text("Bag",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ))),
        bottomNavigationBar: getCartList.isEmpty
            ? SizedBox()
            : Container(
                width: width,
                height: height * 0.1,
                color: MyColors.whitecolor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(
                                color: Color(0xff3B4051).withOpacity(0.6)),
                          ),
                          MainHeadingText(
                            text: "\$${subtotal.toString()}",
                            color: Color(0xff3B4051),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )
                        ],
                      ),
                      RoundButton(
                        title: 'Check Out',
                        width: 150,
                        height: 50,
                        fontsize: 14,
                        fontweight: FontWeight.w500,
                        borderRadius: 40,
                        btnColor: Color(0xff393F48),
                        onTap: () {
                          if (selectedAddressId == "") {
                            showSnackbar(
                                context, "Choose/Add delivery Address");
                          } else {
                            showConfirmDeliveryDialog(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
        body: AbsorbPointer(
            absorbing: isLoading,
            child: showBagDataLoader
                ? LinearProgressIndicator(
                    color: MyColors.primaryColor,
                  )
                : getCartList.isEmpty
                    ? Container(
                        height: height * 0.5,
                        child: Center(
                          child: Image.asset("assets/images/NoDataFound.png"),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  for (int i = 0; i < getCartList.length; i++)
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  width: 100,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: MyColors
                                                              .primaryColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: CachedNetworkImage(
                                                      imageUrl: getCartList[i]
                                                          .productImage,
                                                      width: width * 0.14,
                                                      height: height * 0.06,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  )),
                                              flex: 1,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        getCartList[i]
                                                            .productName!,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showConfirmDeleteProductDialog(
                                                            context,
                                                            getCartList[i].id,
                                                          );
                                                        },
                                                        child: SvgPicture.asset(
                                                          "assets/images/DeleteCartItemIcon"
                                                          ".svg",
                                                          height: 30,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      "Size :${getCartList[i].productSize}",
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "\$${getCartList[i].productPrice}",
                                                        style: TextStyle(
                                                            color: MyColors
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              int qty = int.parse(
                                                                  getCartList[i]
                                                                      .quantity);
                                                              if (qty > 1) {
                                                                addToBag(
                                                                    getCartList[
                                                                            i]
                                                                        .productId,
                                                                    (qty - 1)
                                                                        .toString());
                                                              } else {
                                                                showSnackbar(
                                                                    context,
                                                                    "Minimum quantity should be 1");
                                                              }
                                                            },
                                                            child: SvgPicture.asset(
                                                                "assets/images/QtyRemoveIcon.svg"),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          MainHeadingText(
                                                            text: getCartList[i]
                                                                .quantity,
                                                            fontSize: 16,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              addToBag(
                                                                  getCartList[i]
                                                                      .productId,
                                                                  (int.parse(getCartList[i]
                                                                              .quantity) +
                                                                          1)
                                                                      .toString());
                                                            },
                                                            child: SvgPicture.asset(
                                                                "assets/images/QtyAddIcon.svg"),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              flex: 3,
                                            )
                                          ],
                                        ))
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              MainHeadingText(
                                text: "Payment Detail",
                                fontSize: 18,
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Subtotal"),
                                  Text("\$${subtotal.toString()}")
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [Text("Taxes"), Text("\$0")],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    "\$${subtotal.toString()}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              MainHeadingText(
                                text: "Address",
                                fontSize: 18,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              addressList.isEmpty
                                  ? Container()
                                  : Column(
                                      children: [
                                        for (int i = 0;
                                            i < addressList.length;
                                            i++)
                                          RadioListTile(
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                            activeColor: Color(0xff115571),
                                            title: Text(
                                              addressList[i].address,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            secondary: SvgPicture.asset(
                                              "assets/images/AddressIconAdded.svg",
                                              height: 25,
                                            ),
                                            value: addressList[i].id,
                                            groupValue: selectedAddressId,
                                            onChanged: (value) {
                                              selectedAddressId = value!;
                                              setState(() {});
                                              print("add is"
                                                  ".....$value");
                                            },
                                          )
                                      ],
                                    ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    push(
                                        context: context, screen: AddAddress());
                                    getAddress();
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/addAddressIcon.svg",
                                        height: 35,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Add Address",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      )));
  }

  void showConfirmDeliveryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Payment",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("Are you sure you want to Checkout?",
              style: TextStyle(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              child: new Text("No",
                  style: TextStyle(
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes",
                  style: TextStyle(
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              onPressed: () async {
                placeOrder();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showConfirmDeleteProductDialog(BuildContext context, String cartId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(
              "Are you sure you want to Remove this product from "
              "the cart?",
              style: TextStyle(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              child: new Text("No",
                  style: TextStyle(
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes",
                  style: TextStyle(
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              onPressed: () async {
                removeProductFromCart(cartId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

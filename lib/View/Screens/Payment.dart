import 'package:ealaa_userr/import_ealaa_user.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Payment receipt",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainHeadingText(
                          text: "Service Fee",
                          fontSize: 14,
                        ),
                        MainHeadingText(
                          text: "\$128",
                          fontSize: 16,
                        ),
                      ],
                    ),
                    sizeBox_mq(context, width: 1, height: 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainHeadingText(
                          text: "Late NIght Surcharge",
                          fontSize: 14,
                        ),
                        MainHeadingText(
                          text: "\$50",
                          fontSize: 16,
                        ),
                      ],
                    ),
                    sizeBox_mq(context, width: 1, height: 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainHeadingText(
                              text: "Moving Cart",
                              fontSize: 14,
                            ),
                            ParagraphText(
                              text: "Additional Services",
                              color: MyColors.greycolor,
                              fontSize: 12,
                            )
                          ],
                        ),
                        MainHeadingText(
                          text: "\$50",
                          fontSize: 16,
                        ),
                      ],
                    ),
                    sizeBox_mq(context, width: 1, height: 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainHeadingText(
                              text: "Discount",
                              fontSize: 14,
                            ),
                            ParagraphText(
                              text: "Promo Code: 554dffd",
                              fontSize: 12,
                            )
                          ],
                        ),
                        MainHeadingText(
                          text: "\$50",
                          fontSize: 16,
                          color: MyColors.primaryColor,
                        ),
                      ],
                    ),
                    sizeBox_mq(context, width: 1, height: 0.02),
                    sizeBox_mq(context, width: 1, height: 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainHeadingText(
                          text: "Total",
                          fontSize: 12,
                        ),
                        MainHeadingText(
                          text: "\$138.00",
                          fontSize: 20,
                          color: MyColors.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Select payment",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff3E4958)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  // push(context: context, screen: TripEnded());
                },
                child: InkWell(
                  onTap: () {
                    // push(context: context, screen: TripEnded());
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.asset(MyImages.cards),
                        title: Text(
                          "**** 8295",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Image.asset(MyImages.rightarrow),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  // push(context: context, screen: TripEnded());
                },
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.asset(MyImages.visa),
                      title: Text(
                        "**** 3704",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Image.asset(MyImages.rightarrow),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  // push(context: context, screen: TripEnded());
                },
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.asset(MyImages.discount),
                      title: Text(
                        "Discount Code",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Image.asset(MyImages.rightarrow),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              sizeBox_mq(context, width: 1, height: 0.05),
              RoundButton(
                  title: "Pay",
                  onTap: () {
                  //  push(context: context, screen: Success());
                  })
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

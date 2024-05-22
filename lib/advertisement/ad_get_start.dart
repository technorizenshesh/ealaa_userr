import 'package:ealaa_userr/advertisement/ad_bottom_bar.dart';

import '../../import_ealaa_user.dart';

class AdGetStart extends StatefulWidget {
  const AdGetStart({super.key});

  @override
  State<AdGetStart> createState() => _AdGetStartState();
}

class _AdGetStartState extends State<AdGetStart> {
  int stepIndex = 0;

  List<String> imageList = [
    'assets/icons/ic_get_start1.png',
    'assets/icons/ic_get_start2.png',
    'assets/icons/ic_get_start3.png'
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Center(
                  child: Image.asset(
                imageList[stepIndex],
                height: 230,
                width: double.infinity,
                fit: BoxFit.fill,
              )),
              SizedBox(
                height: height * 0.1,
              ),
              getRetchText(stepIndex),
              SizedBox(
                height: height * 0.01,
              ),
              const Text(
                "Explore over 10,000 homes and find exactly what you're looking for with help of 10,000 trustedagents.",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sliderPoint(stepIndex == 0),
                  sliderPoint(stepIndex == 1),
                  sliderPoint(stepIndex == 2),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (stepIndex == 2) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdBottomBar()));
                  } else {
                    setState(() {
                      stepIndex++;
                    });
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget sliderPoint(bool status) {
    return Container(
      height: 10,
      width: status ? 30 : 10,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: status ? Colors.orange : Colors.white,
          border: Border.all(color: Colors.orange, width: 1),
          borderRadius: BorderRadius.circular(5)),
    );
  }

  Widget getRetchText(int index) {
    switch (index) {
      case 0:
        return RichText(
          text: const TextSpan(
              text: 'Find ',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              children: [
                TextSpan(
                  text: 'House ',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                TextSpan(
                  text: 'at your Budget',
                )
              ]),
        );

      case 1:
        return RichText(
          text: const TextSpan(
              text: 'Find ',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              children: [
                TextSpan(
                  text: 'Motorbike ',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                TextSpan(
                  text: 'at your Budget',
                )
              ]),
        );
      case 2:
        return RichText(
          text: const TextSpan(
              text: 'Get yourself a new ',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              children: [
                TextSpan(
                  text: 'Motorbike',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
              ]),
        );
    }
    return const Text('');
  }
}

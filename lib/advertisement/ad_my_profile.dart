import 'package:ealaa_userr/import_ealaa_user.dart';

class AdMyProfile extends StatefulWidget {
  const AdMyProfile({super.key});

  @override
  State<AdMyProfile> createState() => _AdProfileState();
}

class _AdProfileState extends State<AdMyProfile> {
  bool isMap = false;
  bool showProgressBar = false;
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool checkBox3 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          'My Profile', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/Ellipse 1.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                elevation: 1,
                color: Colors.white,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Change your Password',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        '******',
                        style: TextStyle(fontSize: 12, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                elevation: 1,
                color: Colors.white,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        '91-987456321',
                        style: TextStyle(fontSize: 12, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                elevation: 1,
                color: Colors.white,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        'john.parl098@gmail.com',
                        style: TextStyle(fontSize: 12, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
                indent: 10,
                endIndent: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  decoration: const InputDecoration(
                hintText: 'First Name',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  decoration: const InputDecoration(
                hintText: 'Last Name',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    checkBox1 = !checkBox1;
                  });
                },
                child: Row(
                  children: [
                    checkBox1
                        ? const Icon(
                            Icons.check_box_outlined,
                            size: 25,
                            color: Colors.orange,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank_outlined,
                            size: 25,
                            color: Colors.orange,
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                        child: Text(
                      "Hide my name and photo on my ads.",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    checkBox2 = !checkBox2;
                  });
                },
                child: Row(
                  children: [
                    checkBox2
                        ? const Icon(
                            Icons.check_box_outlined,
                            size: 25,
                            color: Colors.orange,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank_outlined,
                            size: 25,
                            color: Colors.orange,
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                        child: Text(
                      "Subscribe the weekly ADS SPOT newsletter of the most popular steals.",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    checkBox3 = !checkBox3;
                  });
                },
                child: Row(
                  children: [
                    checkBox3
                        ? const Icon(
                            Icons.check_box_outlined,
                            size: 25,
                            color: Colors.orange,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank_outlined,
                            size: 25,
                            color: Colors.orange,
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                        child: Text(
                      "Amazing offers and bargains from our advertising partners.",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Update Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

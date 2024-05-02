import 'package:ealaa_userr/Model/IndividualListModel.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class IndividualListScreen extends StatefulWidget {
  const IndividualListScreen({Key? key}) : super(key: key);

  @override
  State<IndividualListScreen> createState() => _IndividualListScreenState();
}

class _IndividualListScreenState extends State<IndividualListScreen> {

  List<IndividualListResult> individualList = [];

  getIndividualList() async {
    var res = await Webservices.getMap("$baseUrl$get_drivers_list");
    print("status from api ${res}");
    final resdata = IndividualListModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      individualList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }
  @override
  void initState() {
    getIndividualList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset("assets/images/backButton.svg")),

        ),
        title: MainHeadingText(text: "Individual",
          textAlign: TextAlign.center,fontSize: 20,),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: individualList==null?Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Column(
          children: [
            for(int i=0;i<individualList.length;i++)
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading:
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(10),
                    child: Image.asset('assets/images/Ellipse 4.png'),
                  ),

                  title: Text(individualList[i].drFullName,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 17 ),),
                  subtitle: Text(individualList[i].drCity,style: TextStyle(fontSize: 14,color: Colors.grey )),
                ),
              )
          ],
        ),
      ),
    );
  }
}

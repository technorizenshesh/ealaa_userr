import 'package:ealaa_userr/Model/advertisement_model/VehiclesMakeModel.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/GlobalData.dart';
import '../../../View/Utils/webService.dart';

class VehiclesMake extends StatefulWidget {
  final String advertisement_category_id;

  const VehiclesMake({super.key, required this.advertisement_category_id});

  @override
  State<VehiclesMake> createState() => _VehiclesMakeState();
}

class _VehiclesMakeState extends State<VehiclesMake> {
  final ScrollController _scrollController = ScrollController();
  bool showProgressBar = true;
  int _currentStepIndex = 1;
  final int _totalSteps = 5;
  List<String> topList = [
    'Make',
    'Modal',
    'Trim',
    'Year',
    'Condition',
    'Engine Size',
    'Door count',
    'Exterior Color',
    'Interior Color',
    'Cylinders',
    'Fuel',
    'Transmission',
    'Drivertrain',
    'Seats',
    'Plate',
    'Origin',
    'Governate',
    'State',
    'Upload Photos',
    'Additional Details'
  ];
  String title = "Make";
  List<VehiclesMakeResult> makeList = [];
  List<Model> modelList = [];
  List<ModelTrim> trimList = [];
  List<int> yearList = [];
  VehiclesMakeResult? selectedMake;
  Model? selectedModel;
  ModelTrim? selectedTrim;
  int? selectedYear;

  void _scrollToNextStep() {
    if (_currentStepIndex < _totalSteps) {
      double offset =
          _currentStepIndex * 20; // Assuming each step's height is 100.0
      _scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  getMakes() async {
    var res = await Webservices.getMap(
        "$get_maker_model?category_id=${widget.advertisement_category_id}");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = VehiclesMakeModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      makeList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  @override
  void initState() {
    getMakes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            _scrollToNextStep();
            _currentStepIndex == 1
                ? Navigator.pop(context)
                : _currentStepIndex = _currentStepIndex - 1;
            setState(() {});
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          title, // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: showProgressBar
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.primaryColor,
              ),
            )
          : makeList.isEmpty
              ? Image.asset("assets/images/NoDataFound.png")
              : NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      expandedHeight: 100,
                      flexibleSpace: FlexibleSpaceBar(
                        background: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                            child: Row(
                              children: List.generate(topList.length, (index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(
                                      height: 10,
                                      color: Colors.grey,
                                    ),
                                    _currentStepIndex <= index
                                        ? SvgPicture.asset(
                                            "assets/images/card_grey.svg",
                                            height: 40,
                                          )
                                        : _currentStepIndex == index + 1
                                            ? SvgPicture.asset(
                                                'assets/images/card_blue.svg',
                                                height: 45,
                                              )
                                            : SvgPicture.asset(
                                                'assets/images/card_green.svg',
                                                height: 45,
                                              ),
                                    // Container(
                                    //   width: 15,
                                    //   height: 15,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(10),
                                    //     color: _currentStepIndex <= index
                                    //         ? Colors.grey
                                    //         : _currentStepIndex == index + 1
                                    //             ? Colors.blue
                                    //             : Colors.green,
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              topList[index],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      _currentStepIndex <= index
                                                          ? Colors.grey
                                                          : Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              selectedMake?.name ?? "",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color:
                                                    _currentStepIndex <= index
                                                        ? Colors.grey
                                                        : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(right: 15),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: tabsScreens(_currentStepIndex)),
                  ),
                ),
    );
  }

  Widget tabsScreens(int index) {
    switch (index) {
      case 1:
        return Make();
      case 2:
        return Modal();
      case 3:
        return Trim();
      case 4:
        return Year();
      case 5:
        return step5();
      default:
        return step5();
    }
  }

  Widget Make() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisExtent: 100, mainAxisSpacing: 5),
      itemCount: makeList.length,
      itemBuilder: (context, int index) {
        //  GetClubsResult item = controller.getClubsModel!.result![index];
        return GestureDetector(
          onTap: () {
            selectedMake = makeList[index];
            modelList = makeList[index].model ?? [];
            yearList = makeList[index].year??[];
            _currentStepIndex = 2;
            _scrollToNextStep();
            setState(() {});
          },
          child: Container(
            height: 45,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            // padding: const EdgeInsets.only(
            //     left: 3, right: 3, top: 5, bottom: 5),
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: selectedMake == makeList[index]
                              ? Colors.blueAccent
                              : AppColors.grey)),
                  width: 100, // Set the width of the image here
                  height: 60,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: makeList[index].image ?? '',
                        height: 40,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Center(
                            child: Shimmer.fromColors(
                          baseColor: MyColors.onSecondary.withOpacity(0.4),
                          highlightColor:
                              Theme.of(context).colorScheme.onSecondary,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: MyColors.onSecondary.withOpacity(0.4),
                            ),
                          ),
                        )),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  makeList[index].name ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: selectedMake == makeList[index]
                          ? Colors.blueAccent
                          : AppColors.grey),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      },
    );
    // InkWell(
    //   onTap: () {
    //     _currentStepIndex = 1;
    //     setState(() {});
    //   },
    //   child: Text("step 1 widget"));
  }

  Widget Modal() {
    return ListView.builder(
        itemCount: modelList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: modelList[index],
                title: Text('${modelList[index].name}'),
                groupValue: selectedModel,
                onChanged: (Model? value) {
                  _currentStepIndex = 3;
                  selectedModel = value;
                  trimList = modelList[index].modelTrim ?? [];
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
    //   InkWell(
    //     onTap: () {
    //       _currentStepIndex = 2;
    //       setState(() {});
    //     },
    //     child: Text("step 2 widget"));
  }

  Widget Trim() {
    return ListView.builder(
        itemCount: trimList.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(bottom: 15),
          child: RadioListTile(
            activeColor: MyColors.primaryColor,
            value: trimList[index],
            title: Text('${trimList[index].name}'),
            groupValue: selectedTrim,
            onChanged: (ModelTrim? value) {
              _currentStepIndex = 4;
              selectedTrim = value;
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ));
    //   InkWell(
    //     onTap: () {
    //       _currentStepIndex = 2;
    //       setState(() {});
    //     },
    //     child: Text("step 2 widget"));
  }

  Widget Year() {
    return ListView.builder(
        itemCount: yearList.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(bottom: 15),
          child: RadioListTile(
            activeColor: MyColors.primaryColor,
            value: yearList[index],
            title: Text('${yearList[index]}'),
            groupValue: selectedYear,
            onChanged: (int? value) {
              _currentStepIndex = 5;
              selectedYear = value;
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ));
    //   InkWell(
    //     onTap: () {
    //       _currentStepIndex = 2;
    //       setState(() {});
    //     },
    //     child: Text("step 2 widget"));
  }
  Widget step3() {
    return InkWell(
        onTap: () {
          _currentStepIndex = 4;
          _scrollToNextStep();
          setState(() {});
        },
        child: Text("step 3 widget"));
  }

  Widget step4() {
    return InkWell(
        onTap: () {
          _currentStepIndex = 5;
          _scrollToNextStep();
          setState(() {});
        },
        child: Text("step 4 widget"));
  }

  Widget step5() {
    return InkWell(
        onTap: () {
          _currentStepIndex = 6;
          _scrollToNextStep();
          setState(() {});
        },
        child: Text("step 5 widget"));
  }
}

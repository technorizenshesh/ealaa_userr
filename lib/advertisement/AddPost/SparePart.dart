import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/material.dart';

import 'VehicleParts/Ad_VehiclePartAdd.dart';

class SparePart extends StatefulWidget {
  final String adType;
  final String advertisement_category_id;

  SparePart({super.key,required this.advertisement_category_id,
    required this.adType});

  @override
  State<SparePart> createState() => _SparePartState();
}

class _SparePartState extends State<SparePart> {
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
          'Spare Part', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdVehiclesPartAdd(type: 'Wanted',adType: widget.adType,advertisement_category_id: widget.advertisement_category_id,)));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                padding: EdgeInsets.fromLTRB(20,10,0,0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/WantedIcon.png",height: 60,),
                    SizedBox(height: 10),
                    Text("Wanted",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)
                  ],
                ),
              ),
            ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdVehiclesPartAdd(type: 'Sale',adType: widget.adType,advertisement_category_id: widget.advertisement_category_id)));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              padding: EdgeInsets.fromLTRB(20,10,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/SpareSaleIcon.png",height: 60,),
                  SizedBox(height: 10),
                  Text("For Sale",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)
                ],
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}

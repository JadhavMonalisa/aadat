import 'package:adat/common_widget/widget.dart';
import 'package:adat/screens/home/firm_model.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return SafeArea(child:
      WillPopScope(
        onWillPop: () async {
          return await cont.closeAppDialog(context);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: buildTextBoldWidget("Home", whiteColor, context, 15.0),
            actions: [
              Center(
                child: buildTextRegularWidget(
                    cont.selectedLang, whiteColor, context, 14.0),
              ),
              PopupMenuButton<String>(
                  itemBuilder: (context) =>
                      cont.langList.map((item) =>
                          PopupMenuItem<String>(
                              value: item,
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: ListTile(
                                    tileColor: orangeColor,
                                    title: buildTextRegularWidget(
                                        item, blackColor, context, 14.0)
                                ),
                              )
                          ))
                          .toList(),
                  onSelected: (value) {
                    cont.changeLanguage(value);
                  },
                  child: const SizedBox(
                    height: 100, width: 50.0,
                    child: Icon(Icons.arrow_drop_down_circle_outlined,
                        color: Colors.white),
                  )
              ),
              const SizedBox(width: 20.0,),
              GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                    return logoutDialog(cont);
                    },);
              },
                child:const Icon(Icons.logout)
              ),
              const SizedBox(width: 20.0,),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0,bottom: 20.0),
                    child: SizedBox(
                        height: 40.0,
                        child: Center(
                            child: Container(
                              width: 230.0,height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color:primaryColor),),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                child: DropdownButton<String>(
                                  hint: buildTextBoldWidget(cont.selectedFirm==""?"Select Firm":cont.selectedFirm,
                                      primaryColor, context, 15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  icon: const Icon(Icons.arrow_drop_down,color: primaryColor,size: 30.0,),
                                  items:
                                  cont.firmList.isEmpty
                                      ?
                                  cont.noDataList.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: buildTextBoldWidget(value, primaryColor, context, 15.0),
                                    );
                                  }).toList()
                                      :
                                  cont.firmList.map((FirmDetails value) {
                                    return DropdownMenuItem<String>(
                                      value: value.engFirmName,
                                      child: buildTextBoldWidget(value.engFirmName!, primaryColor, context, 15.0),
                                      onTap: (){
                                        cont.updateSelectedFirmId(value.engFirmName!,value.firmId!);
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    cont.updateSelectedFirm(val!);
                                  },
                                ),
                              ),
                            )
                        )
                    ),
                  ),

                  Row(
                    children: [
                      Flexible(
                        child:Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: (){
                              cont.checkChoice(true,false,false);
                            },
                            child: Container(
                              height: 80.0,width: 150.0,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: whiteColor,
                              border: Border.all(color: cont.isCustomerSelected ? orangeColor : grey,width: 2.0)),
                              child: Center(
                                child: buildTextRegularWidget("Customer\nRelated",
                                    cont.isCustomerSelected ? orangeColor : grey,
                                    context, 15.0,align: TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child:Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: (){
                              cont.checkChoice(false,true,false);
                            },
                            child: Container(
                              height: 80.0,width: 150.0,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: whiteColor,
                                border: Border.all(color: cont.isSupplierSelected ? orangeColor : grey,width: 2)),
                              child: Center(
                                child: buildTextRegularWidget("Supplier\nRelated",
                                    cont.isSupplierSelected ? orangeColor : grey,
                                    context, 15.0,align: TextAlign.center),
                              ),
                            ),
                          ),
                        )
                      ),
                      Flexible(
                        child:Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: (){
                              cont.checkChoice(false,false,true);
                            },
                            child: Container(
                              height: 80.0,width: 150.0,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: whiteColor,
                                border: Border.all(color: cont.isFarmerSelected ? orangeColor : grey,width: 2)),
                              child: Center(
                                child: buildTextRegularWidget("Farmer\nRelated",
                                    cont.isFarmerSelected ? orangeColor : grey,
                                    context, 15.0,align: TextAlign.center),
                              ),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),

                  const SizedBox(height: 20.0,),
                  cont.isCustomerSelected ?
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: cont.customerTypeList.length,
                      itemBuilder: (context,index){
                    return buildChoiceDetails(context, cont.customerTypeList[index],cont,cont.customerTypeList,index,"customer");
                  }) : const Opacity(opacity: 0.0,),

                  cont.isSupplierSelected ?
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: cont.supplierTypeList.length,
                      itemBuilder: (context,index){
                        return buildChoiceDetails(context, cont.supplierTypeList[index],cont,cont.supplierTypeList,index,"supplier");
                      })
                  : const Opacity(opacity: 0.0,),

                  cont.isFarmerSelected ?
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: cont.farmerList.length,
                      itemBuilder: (context,index){
                        return buildChoiceDetails(context, cont.farmerList[index],cont,cont.farmerList,index,"farmer");
                      })
                      : const Opacity(opacity: 0.0,),
                ],
              )
            ),
          ),
        ),
      ));
    });
  }

  logoutDialog(HomeController homeController){
    return AlertDialog(
      title: buildTextBoldWidget('Logout', blackColor, context, 15.0),
      content: buildTextRegularWidget('Are you sure you want to logout?', blackColor, context, 15.0),
      actions: [
        TextButton(
          child: buildTextBoldWidget('No', blackColor, context, 15.0),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: buildTextBoldWidget('Yes', blackColor, context, 15.0),
          onPressed: () {
            homeController.callLogout(context);
          },
        ),
      ],
    );
  }

}

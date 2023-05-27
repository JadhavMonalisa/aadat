import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/farmer/farmer_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FarmerReceipt extends StatefulWidget {
  const FarmerReceipt({Key? key}) : super(key: key);

  @override
  State<FarmerReceipt> createState() => _FarmerReceiptState();
}

class _FarmerReceiptState extends State<FarmerReceipt> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FarmerController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.navigateFromReceiptToHome();
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget("Farmer Receipt", whiteColor, context, 15.0),
                leading: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.home);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: whiteColor,)
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0,top: 30.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0,bottom: 20.0),
                          child: buildTextRegularWidget("FARMER RECEIPT REPORT FOR\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),
                        const SizedBox(height: 20.0,),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0,bottom: 10.0),
                          child: SizedBox(
                              height: 40.0,
                              child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color:primaryColor),),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                      child: DropdownButton<String>(
                                        hint: buildTextBoldWidget(cont.selectedFarmerType==""?"Select Farmer Type":cont.selectedFarmerType,
                                            primaryColor, context, 15.0),
                                        isExpanded: true,
                                        underline: Container(),
                                        icon: const Icon(Icons.arrow_drop_down,color: primaryColor,size: 30.0,),
                                        items:
                                        cont.farmerTypeList.isEmpty
                                            ?
                                        cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: buildTextBoldWidget(value, primaryColor, context, 15.0),
                                          );
                                        }).toList()
                                            :
                                        cont.farmerTypeList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: buildTextBoldWidget(value, primaryColor, context, 15.0),
                                            onTap: (){
                                            },
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          cont.updateSelectedFarmerType(val!);
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
                              child: GestureDetector(
                                onTap: (){
                                  cont.selectDate(context,"fromDate");
                                },
                                child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color:primaryColor),),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10.0,),
                                      buildTextRegularWidget(cont.selectedFromDateToShow==""?"Date":cont.selectedFromDateToShow, primaryColor, context, 15.0),
                                      const Spacer(),
                                      const Icon(Icons.calendar_month,color: primaryColor,),
                                      const SizedBox(width: 10.0,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0,),
                            Flexible(
                              child: Container(
                                height: 40.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color:primaryColor),),
                                child: TextFormField(
                                  controller: cont.pattiNo,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.left,
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.done,
                                  onTap: () {
                                  },
                                  onChanged: (val){
                                    cont.updatePattiNo();
                                  },
                                  style:const TextStyle(fontSize: 15.0,color: primaryColor),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: "Patti No",
                                      hintStyle: TextStyle(color: primaryColor),
                                      border: InputBorder.none,
                                      suffixIcon: Icon(Icons.receipt,color: primaryColor,)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20.0,),

                        cont.showCustomerList ?
                        Padding(
                          padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 20.0),
                          child: buildTextBoldWidget("Select customer", blackColor, context, 15.0),
                        ): const Opacity(opacity: 0.0),

                        cont.showCustomerList
                            ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: cont.customerNameList.length,
                                itemBuilder: (context,index){
                                  return Row(
                                    children: [
                                      Checkbox(value:
                                      cont.addedCustomer.contains(cont.customerNameList[index])
                                          ? true : false ,
                                          activeColor: Colors.green,
                                          onChanged:(newValue){
                                            cont.updateCustomerCheckBox(newValue!,cont.customerNameList[index]);
                                          }),
                                      const SizedBox(width: 5.0,),
                                      buildTextRegularWidget(cont.customerNameList[index], blackColor, context, 14.0)
                                    ],
                                  );
                                })
                        )
                            : const Opacity(opacity: 0.0),
                        const SizedBox(height: 20.0,),

                        Padding(
                            padding: const EdgeInsets.only(left: 100.0,right: 100.0),
                            child:GestureDetector(
                              onTap: (){
                                cont.showFarmerReceiptResult();
                              },
                              child:  buildButtonWidget(context, "GET REPORT", buttonColor: orangeColor),
                            )
                        ),
                        cont.isViewSelected
                            ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0),
                                child: Table(
                                  border: TableBorder.all(color: whiteColor,width: 2.0),
                                  defaultColumnWidth: const FixedColumnWidth(120.0),
                                  children: [
                                    TableRow(
                                        children: [
                                          Container(
                                            color: grey,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: buildTextBoldWidget("Column 1", blackColor, context, 14.0),
                                            ),
                                          ),
                                          Container(
                                            color: grey,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: buildTextBoldWidget("Column 2", blackColor, context, 14.0),
                                            ),
                                          ),
                                          Container(
                                            color: grey,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: buildTextBoldWidget("Column 3", blackColor, context, 14.0),
                                            ),
                                          ),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          Container(
                                            color: grey.withOpacity(0.2),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: buildTextRegularWidget("data 1", blackColor, context, 14.0),
                                            ),
                                          ),
                                          Container(
                                            color: grey.withOpacity(0.2),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: buildTextRegularWidget("data 2", blackColor, context, 14.0),
                                            ),
                                          ),
                                          Container(
                                            color: grey.withOpacity(0.2),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: buildTextRegularWidget("data 3", blackColor, context, 14.0),
                                            ),
                                          ),
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          Container(
                                            color: grey.withOpacity(0.2),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: buildTextRegularWidget("data 1", blackColor, context, 14.0),
                                            ),
                                          ),
                                          Container(
                                            color: grey.withOpacity(0.2),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: buildTextRegularWidget("data 2", blackColor, context, 14.0),
                                            ),
                                          ),
                                          Container(
                                            color: grey.withOpacity(0.2),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: buildTextRegularWidget("data 3", blackColor, context, 14.0),
                                            ),
                                          ),
                                        ]
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ) : const Opacity(opacity: 0.0),

                      ],
                    )
                ),
              ),
            )
        ),
      );
    });
  }
}

import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/home/home_controller.dart';
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
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.navigateFromFarmerReceiptToHome();
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
                        Row(
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: (){
                                  cont.onPattiDateSelectionChange(context);
                                },
                                child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color:cont.showPattiDate == true? primaryColor : grey),),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10.0,),
                                      buildTextRegularWidget(cont.selectedFromDateToShow==""?"Date":cont.selectedFromDateToShow,
                                          cont.showPattiDate == true ? primaryColor : grey, context, 15.0),
                                      const Spacer(),
                                      Icon(Icons.calendar_month,color:cont.showPattiDate == true? primaryColor : grey,),
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
                                  border: Border.all(color: cont.showPattiNo ? primaryColor : grey),),
                                child: TextFormField(
                                  controller: cont.pattiNo,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.left,
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.done,
                                  onTap: () {
                                    cont.onPattiNoSelectionChange();
                                  },
                                  onChanged: (val){
                                  },
                                  style:const TextStyle(fontSize: 15.0,color: primaryColor),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      hintText: "Patti No",
                                      hintStyle: TextStyle(color: cont.showPattiNo ? primaryColor : grey),
                                      border: InputBorder.none,
                                      suffixIcon: Icon(Icons.receipt,color:  cont.showPattiNo ? primaryColor : grey)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20.0,),

                        // cont.showCustomerList ?
                        // Padding(
                        //   padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 20.0),
                        //   child: buildTextBoldWidget("Select customer", blackColor, context, 15.0),
                        // ): const Opacity(opacity: 0.0),

                        // cont.showCustomerList
                        //     ? Padding(
                        //     padding: const EdgeInsets.all(10.0),
                        //     child: ListView.builder(
                        //         shrinkWrap: true,
                        //         itemCount: cont.customerList.length,
                        //         itemBuilder: (context,index){
                        //           return Row(
                        //             children: [
                        //               Checkbox(value:
                        //               cont.addedCustomerIndex.contains(index)
                        //                   ? true : false ,
                        //                   activeColor: Colors.green,
                        //                   onChanged:(newValue){
                        //                     cont.updateCustomerCheckBoxFromFarmer(newValue!,index);
                        //                   }),
                        //               const SizedBox(width: 5.0,),
                        //               buildTextRegularWidget(cont.customerList[index].custAccountName!, blackColor, context, 14.0)
                        //             ],
                        //           );
                        //         })
                        // )
                        //     : const Opacity(opacity: 0.0),
                        // const SizedBox(height: 20.0,),

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
                       ? cont.isLoading ? buildCircularIndicator() :
                             cont.farmerPattiList.isEmpty ? buildNoDataFound(context):
                        Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0),
                              // child: Table(
                              //   border: TableBorder.all(color: whiteColor,width: 2.0),
                              //   defaultColumnWidth: const IntrinsicColumnWidth(),
                              //   children: [
                              //     TableRow(
                              //         children: [
                              //           buildTableTitleForReport(context,"Patti No"),
                              //           buildTableTitleForReport(context,"Patti Date"),
                              //           buildTableTitleForReport(context,"Account Name"),
                              //           buildTableTitleForReport(context,"City"),
                              //           buildTableTitleForReport(context,"mEng_name"),
                              //           buildTableTitleForReport(context,"Quantity"),
                              //           buildTableTitleForReport(context,"Weight"),
                              //           buildTableTitleForReport(context,"Rate"),
                              //           buildTableTitleForReport(context,"Amount"),
                              //           buildTableTitleForReport(context,"Hamali"),
                              //           buildTableTitleForReport(context,"Mapai"),
                              //           buildTableTitleForReport(context,"Bharai"),
                              //           buildTableTitleForReport(context,"Leavy"),
                              //           buildTableTitleForReport(context,"mcess"),
                              //           buildTableTitleForReport(context,"mFee"),
                              //           buildTableTitleForReport(context,"Varai"),
                              //           buildTableTitleForReport(context,"comm"),
                              //           buildTableTitleForReport(context,"other"),
                              //           buildTableTitleForReport(context,"actPatti"),
                              //           buildTableTitleForReport(context,"Amt in word"),
                              //           buildTableTitleForReport(context,"Motor Rent"),
                              //           buildTableTitleForReport(context,"engFirmName"),
                              //         ]
                              //     ),
                              //     for (var data in cont.farmerPattiList)
                              //       TableRow(
                              //           children: [
                              //             buildTableSubtitleForReport(context,data.pattiNo.toString()),
                              //             buildTableSubtitleForReport(context,data.pattiDate!),
                              //             buildTableSubtitleForReport(context,data.accountName!),
                              //             buildTableSubtitleForReport(context,data.city!),
                              //             buildTableSubtitleForReport(context,data.engFirmName.toString()),
                              //             buildTableSubtitleForReport(context,data.qty.toString()),
                              //             buildTableSubtitleForReport(context,data.weight.toString()),
                              //             buildTableSubtitleForReport(context,data.rate.toString()),
                              //             buildTableSubtitleForReport(context,data.amount.toString()),
                              //             buildTableSubtitleForReport(context,data.hamali.toString()),
                              //             buildTableSubtitleForReport(context,data.mapai.toString()),
                              //             buildTableSubtitleForReport(context,data.bharai.toString()),
                              //             buildTableSubtitleForReport(context,data.leavy.toString()),
                              //             buildTableSubtitleForReport(context,data.mcess.toString()),
                              //             buildTableSubtitleForReport(context,data.mFee.toString()),
                              //             buildTableSubtitleForReport(context,data.varai.toString()),
                              //             buildTableSubtitleForReport(context,data.comm.toString()),
                              //             buildTableSubtitleForReport(context,data.other.toString()),
                              //             buildTableSubtitleForReport(context,data.actPatti.toString()),
                              //             buildTableSubtitleForReport(context,data.amttoword.toString()),
                              //             buildTableSubtitleForReport(context,data.motorRent.toString()),
                              //             buildTableSubtitleForReport(context,data.engFirmName.toString()),
                              //           ]
                              //       ),
                              //   ],
                              // ),
                              child:Column(
                                children: [
                                  Table(
                                    border: TableBorder.all(color: blackColor,width: 2.0),
                                    defaultColumnWidth: const IntrinsicColumnWidth(),
                                    children: [
                                      TableRow(
                                          children: [
                                            buildTableTitleForReport(context,"Title 1"),
                                            buildTableTitleForReport(context,"Title 2"),
                                            buildTableTitleForReport(context,"Title 3"),
                                            buildTableTitleForReport(context,"Title 4"),
                                            buildTableTitleForReport(context,"Title 5"),
                                            buildTableTitleForReport(context,"Title 6"),
                                          ]
                                      ),
                                      for (var data in cont.farmerPattiList)
                                        TableRow(
                                            children: [
                                              buildTableSubtitleForReport(context,data.mEngName.toString()),
                                              buildTableSubtitleForReport(context,data.mEngName!),
                                              buildTableSubtitleForReport(context,data.mEngName!),
                                              buildTableSubtitleForReport(context,data.mEngName!),
                                              buildTableSubtitleForReport(context,data.mEngName.toString()),
                                              buildTableSubtitleForReport(context,data.mEngName.toString()),
                                            ]
                                        ),
                                      for (var data in cont.farmerPattiList)
                                        TableRow(
                                            children: [
                                              buildTableSubtitleForReport(context,data.mEngName.toString()),
                                              const Opacity(opacity: 0.0,),
                                              buildTableSubtitleForReport(context,data.mEngName!),
                                              buildTableSubtitleForReport(context,data.mEngName!),
                                              const Opacity(opacity: 0.0,),
                                              const Opacity(opacity: 0.0,),
                                            ]
                                        ),
                                    ],
                                  ),
                                  Table(
                                    border: TableBorder.all(color: blackColor,width: 2.0),
                                    defaultColumnWidth: const IntrinsicColumnWidth(),
                                    children: [
                                      TableRow(
                                          children: [
                                            Row(children: [
                                              Text("Aadat"),
                                              Text("Hamali"),
                                              Text("Tolai"),
                                              Text("Total"),
                                            ],),
                                          ]
                                      ),
                                      for (var data in cont.farmerPattiList)
                                        TableRow(
                                            children: [
                                             Row(
                                               children: [
                                                 Text("s1"),
                                                 Text("s2"),
                                                 Text("s3"),
                                                 Text("s4"),
                                               ],
                                             )
                                            ]
                                        ),
                                    ],
                                  ),
                                ],
                              )
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

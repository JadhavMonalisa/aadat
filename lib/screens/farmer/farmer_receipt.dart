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

                        Padding(
                            padding: const EdgeInsets.only(left: 100.0,right: 100.0,bottom: 20.0),
                            child:GestureDetector(
                              onTap: (){
                                cont.showFarmerReceiptResult();
                              },
                              child:  buildButtonWidget(context, "GET REPORT", buttonColor: orangeColor),
                            )
                        ),

                        cont.farmerPattiList.isEmpty ?
                        buildTextBoldWidget("No Data Found", blackColor, context, 14,align: TextAlign.center):

                        // cont.isViewSelected?
                        // cont.showPattiNo
                        //     ? Align(
                        //     alignment: Alignment.center,
                        //     child: buildTextBoldWidget(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].engFirmName!, blackColor, context, 16.0)
                        // ) : const Opacity(opacity: 0.0) : const Opacity(opacity: 0.0),
                        //
                        // cont.isViewSelected?
                        // cont.showPattiNo
                        // ? Align(
                        //   alignment: Alignment.center,
                        //   child: buildTextBoldWidget(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].firmAddress!, blackColor, context, 16.0)
                        // ) : const Opacity(opacity: 0.0) : const Opacity(opacity: 0.0),

                        // cont.isViewSelected?
                        // cont.showPattiNo
                        //     ? Padding(
                        //       padding: const EdgeInsets.only(left: 10.0),
                        //       child: Align(
                        //       alignment: Alignment.topLeft,
                        //       child: buildRichTextWidget("Mobile No. : ", cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].mobileNo!,),),
                        //     )
                        //         : const Opacity(opacity: 0.0) : const Opacity(opacity: 0.0),


                        // cont.isViewSelected?
                        // cont.showPattiNo
                        //     ?
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0,right: 20.0),
                        //   child: Row(
                        //     children: [
                        //       Align(
                        //         alignment: Alignment.topLeft,
                        //         child: buildRichTextWidget("Patti No. : ", cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].pattiNo!,),),
                        //        const Spacer(),
                        //       Align(
                        //         alignment: Alignment.topRight,
                        //         child: buildRichTextWidget("Patti Date : ", cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].pattiDate!,),),
                        //     ],
                        //   ),
                        // ) : const Opacity(opacity: 0.0) : const Opacity(opacity: 0.0),

                        // cont.isViewSelected?
                        // cont.showPattiNo
                        //     ?
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0,right: 20.0),
                        //   child: Align(
                        //     alignment: Alignment.topLeft,
                        //     child: buildRichTextWidget("Farmer Name : ", cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].accountName!,),),
                        // ) : const Opacity(opacity: 0.0) : const Opacity(opacity: 0.0),

                        cont.isViewSelected ? cont.isLoading ? buildCircularIndicator() :

                        cont.showPattiNo
                                ? Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Align(
                                    child:buildTextBoldWidget(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].engFirmName!,
                                        blackColor, context, 16.0),
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: buildTextBoldWidget(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].firmAddress!,
                                          blackColor, context, 16.0)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: buildRichTextWidget("Mobile No. : ", cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].mobileNo!,),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0,right: 20.0),
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: buildRichTextWidget("Patti No. : ", cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].pattiNo!,),),
                                        const Spacer(),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: buildRichTextWidget("Patti Date : ", cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].pattiDate!,),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0,right: 20.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: buildRichTextWidget("Farmer Name : ", cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].accountName!,),),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0),
                                    child: Table(
                                      border: TableBorder.all(color: blackColor,width: 2.0),
                                      defaultColumnWidth: const IntrinsicColumnWidth(),
                                      children: [
                                        TableRow(
                                            decoration: const BoxDecoration(color: grey),
                                            children: [
                                              buildTableTitleForReport(context,"Product Name"),
                                              buildTableTitleForReport(context,"Vakkal"),
                                              buildTableTitleForReport(context,"Daag"),
                                              buildTableTitleForReport(context,"Weight"),
                                              buildTableTitleForReport(context,"Rate"),
                                              buildTableTitleForReport(context,"Total"),
                                            ]
                                        ),
                                        for (var data in cont.farmerPattiList)
                                          TableRow(
                                              decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                                              children: [
                                                buildTableSubtitleForReport(context,data.prodName.toString()),
                                                buildTableSubtitleForReport(context,data.vakkal.toString()),
                                                buildTableSubtitleForReport(context,data.qty.toString()),
                                                buildTableSubtitleForReport(context,data.weight!),
                                                buildTableSubtitleForReport(context,data.rate.toString()),
                                                buildTableSubtitleForReport(context,data.amount.toString()),
                                              ]
                                          ),
                                        TableRow(
                                            decoration: const BoxDecoration(color: grey),
                                            children: [
                                              buildTableTitleForReport(context,"Total"),
                                              buildTableTitleForReport(context,""),
                                              buildTableTitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].totQty!,align: TextAlign.center),
                                              buildTableTitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].totWeight!,align: TextAlign.center),
                                              buildTableTitleForReport(context,""),
                                              buildTableTitleForReport(context,""),
                                            ]
                                        ),
                                        TableRow(
                                            decoration: const BoxDecoration(color: grey),
                                            children: [
                                              buildTableTitleForReport(context,""),
                                              buildTableTitleForReport(context,"Hamali"),
                                              buildTableTitleForReport(context,"Tolai"),
                                              buildTableTitleForReport(context,"Mo. Rent"),
                                              buildTableTitleForReport(context,"Total"),
                                              buildTableTitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].totAmount!),
                                            ]
                                        ),
                                        //for (var data in cont.farmerPattiList)
                                        TableRow(
                                            decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                                            children: [
                                              buildTableSubtitleForReport(context,""),
                                              buildTableSubtitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].hamali!),
                                              buildTableSubtitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].mapai!),
                                              buildTableSubtitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].motorRent!),
                                              buildTableSubtitleForReport(context,"Kharch (-)"),
                                              buildTableSubtitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].netExp!),
                                            ]
                                        ),
                                        TableRow(
                                            decoration: const BoxDecoration(color: grey),
                                            children: [
                                              buildTableTitleForReport(context,"Bharai"),
                                              buildTableTitleForReport(context,"Varai"),
                                              buildTableTitleForReport(context,"Other exp"),
                                              buildTableTitleForReport(context,"Uchal"),
                                              buildTableTitleForReport(context,"Total"),
                                              buildTableTitleForReport(context,""),
                                            ]
                                        ),
                                        //for (var data in cont.farmerPattiList)
                                          TableRow(
                                              decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                                              children: [
                                                buildTableSubtitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].bharai!),
                                                buildTableSubtitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].varai!),
                                                buildTableSubtitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].other!),
                                                buildTableSubtitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].uchal!),
                                                buildTableSubtitleForReport(context,"Total"),
                                                buildTableSubtitleForReport(context,cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].netAmount!),
                                              ]
                                          ),
                                        // for (var data in cont.farmerPattiList)
                                        //   TableRow(
                                        //       children: [
                                        //         buildTableSubtitleForReport(context,data.mEngName.toString()),
                                        //         const Opacity(opacity: 0.0,),
                                        //         buildTableSubtitleForReport(context,data.mEngName!),
                                        //         buildTableSubtitleForReport(context,data.mEngName!),
                                        //         const Opacity(opacity: 0.0,),
                                        //         const Opacity(opacity: 0.0,),
                                        //       ]
                                        //   ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                                : Scrollbar(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0),
                                        child:
                                        SizedBox(
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            child:
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: cont.farmerPattiList.length,
                                                itemBuilder: (context,index){
                                                  return Padding(
                                                      padding: const EdgeInsets.only(bottom: 10.0),
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                              alignment: Alignment.center,
                                                              child: buildTextBoldWidget(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[index].engFirmName!, blackColor, context, 16.0)
                                                          ),

                                                          Align(
                                                              alignment: Alignment.center,
                                                              child: buildTextBoldWidget(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[index].firmAddress!, blackColor, context, 16.0)
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 5.0,right: 20.0),
                                                            child: Align(
                                                                alignment: Alignment.topLeft,
                                                                child:buildRichTextWidget("Mobile No. : ", cont.farmerPattiList.isEmpty?"":
                                                                cont.farmerPattiList[0].mobileNo!)),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 5.0,right: 20.0),
                                                            child: Row(
                                                              children: [
                                                                Align(
                                                                  alignment: Alignment.topLeft,
                                                                  child: buildRichTextWidget("Patti No. : ", cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[index].pattiNo!,),),
                                                                const Spacer(),
                                                                Align(
                                                                  alignment: Alignment.topRight,
                                                                  child: buildRichTextWidget("Patti Date : ", cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[index].pattiDate!,),),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 5.0,right: 20.0,bottom: 10.0),
                                                            child: Align(
                                                              alignment: Alignment.topLeft,
                                                              child: buildRichTextWidget("Farmer Name : ", cont.farmerPattiList[index].accountName!,),),
                                                          ),
                                                          Table(
                                                            border: TableBorder.all(color: blackColor,width: 2.0),
                                                            defaultColumnWidth: const IntrinsicColumnWidth(),
                                                            children: [
                                                              TableRow(decoration: const BoxDecoration(
                                                                color: grey,
                                                              ),
                                                                  children: [
                                                                    buildTableTitleForReport(context,"Product Name"),
                                                                    buildTableTitleForReport(context,"Vakkal"),
                                                                    buildTableTitleForReport(context,"Daag"),
                                                                    buildTableTitleForReport(context,"Weight"),
                                                                    buildTableTitleForReport(context,"Rate"),
                                                                    buildTableTitleForReport(context,"Total"),
                                                                  ]
                                                              ),
                                                              TableRow(
                                                                  decoration: BoxDecoration(
                                                                    color: grey.withOpacity(0.2),
                                                                  ),
                                                                  children: [
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].prodName.toString()),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].vakkal.toString()),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].qty.toString()),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].weight!),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].rate.toString()),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].amount.toString()),
                                                                  ]
                                                              ),
                                                              TableRow(
                                                                  decoration: BoxDecoration(
                                                                    color: grey.withOpacity(0.2),
                                                                  ),
                                                                  children: [
                                                                    buildTableSubtitleForReport(context,"Total"),
                                                                    buildTableSubtitleForReport(context,""),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].totQty!),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].totWeight!),
                                                                    buildTableSubtitleForReport(context,""),
                                                                    buildTableSubtitleForReport(context,""),
                                                                  ]
                                                              ),
                                                              TableRow(
                                                                  decoration: const BoxDecoration(
                                                                    color: grey,
                                                                  ),
                                                                  children: [
                                                                    buildTableTitleForReport(context,""),
                                                                    buildTableTitleForReport(context,"Hamali"),
                                                                    buildTableTitleForReport(context,"Tolai"),
                                                                    buildTableTitleForReport(context,"Mo. Rent"),
                                                                    buildTableTitleForReport(context,"Total"),
                                                                    buildTableTitleForReport(context,cont.farmerPattiList[index].totAmount!),
                                                                  ]
                                                              ),
                                                              //for (var data in cont.farmerPattiList)
                                                              TableRow(
                                                                  decoration: BoxDecoration(
                                                                    color: grey.withOpacity(0.2),
                                                                  ),
                                                                  children: [
                                                                    buildTableSubtitleForReport(context,""),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].hamali!),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].mapai!),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].motorRent!),
                                                                    buildTableSubtitleForReport(context,"Kharch (-)"),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].netExp!),
                                                                  ]
                                                              ),
                                                              TableRow(
                                                                  decoration: const BoxDecoration(
                                                                    color: grey,
                                                                  ),
                                                                  children: [
                                                                    buildTableTitleForReport(context,"Bharai"),
                                                                    buildTableTitleForReport(context,"Varai"),
                                                                    buildTableTitleForReport(context,"Other exp"),
                                                                    buildTableTitleForReport(context,"Uchal"),
                                                                    buildTableTitleForReport(context,"Total"),
                                                                    buildTableTitleForReport(context,""),
                                                                  ]
                                                              ),
                                                              //for (var data in cont.farmerPattiList)
                                                              TableRow(
                                                                  decoration: BoxDecoration(
                                                                    color: grey.withOpacity(0.2),
                                                                  ),
                                                                  children: [
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].bharai!),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].varai!),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].other!),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].uchal!),
                                                                    buildTableSubtitleForReport(context,"Total"),
                                                                    buildTableSubtitleForReport(context,cont.farmerPattiList[index].netAmount!),
                                                                  ]
                                                              ),
                                                              // for (var data in cont.farmerPattiList)
                                                              //   TableRow(
                                                              //       children: [
                                                              //         buildTableSubtitleForReport(context,data.mEngName.toString()),
                                                              //         const Opacity(opacity: 0.0,),
                                                              //         buildTableSubtitleForReport(context,data.mEngName!),
                                                              //         buildTableSubtitleForReport(context,data.mEngName!),
                                                              //         const Opacity(opacity: 0.0,),
                                                              //         const Opacity(opacity: 0.0,),
                                                              //       ]
                                                              //   ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 10.0,),
                                                          const Divider(color: blackColor),
                                                        ],
                                                      )
                                                  );
                                                })
                                        )
                                    ),
                                  ),
                                )

                            : const Opacity(opacity: 0.0),

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

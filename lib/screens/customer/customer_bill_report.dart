import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillReportScreen extends StatefulWidget {
  const BillReportScreen({Key? key}) : super(key: key);

  @override
  State<BillReportScreen> createState() => _BillReportScreenState();
}

class _BillReportScreenState extends State<BillReportScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.onBackPressFromBillReport();
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget("Bill Report", whiteColor, context, 15.0),
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
                                  cont.onBillDateSelectionChange(context);
                                },
                                child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color:cont.showBillDate == true? primaryColor : grey),),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10.0,),
                                      buildTextRegularWidget(cont.billDate==""?"Bill Date":cont.billDate,
                                          cont.showBillDate == true? primaryColor : grey, context, 15.0),
                                      const Spacer(),
                                      Icon(Icons.calendar_month,color:cont.showBillDate == true? primaryColor : grey,),
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
                                  border: Border.all(color:cont.showBillNo ? primaryColor : grey),),
                                child: TextFormField(
                                  controller: cont.billNo,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.left,
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.done,
                                  onTap: () {
                                  },
                                  onChanged: (val){
                                  },
                                  style:const TextStyle(fontSize: 15.0,color: primaryColor),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      hintText: "Bill No",
                                      hintStyle: TextStyle(color: cont.showBillNo ? primaryColor : grey),
                                      border: InputBorder.none,
                                      suffixIcon: Icon(Icons.receipt,color:  cont.showBillNo ? primaryColor : grey)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20.0,),

                        Padding(
                            padding: const EdgeInsets.only(left: 100.0,right: 100.0,bottom: 10.0),
                            child:GestureDetector(
                              onTap: (){
                                cont.showBillResult();
                              },
                              child:  buildButtonWidget(context, "GET REPORT", buttonColor: orangeColor),
                            )
                        ),
                        Align(
                          alignment: Alignment.center,
                          child:buildTextRegularWidget(
                              cont.billReportList.isEmpty?"":
                              cont.billReportList[0].custAccountName!, blackColor, context, 15.0,align: TextAlign.center),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child:buildTextRegularWidget(cont.billReportList.isEmpty?"":
                              cont.billReportList[0].firmAddress!, blackColor, context, 15.0,align: TextAlign.center),
                        ),
                        cont.showBillReport?
                        Padding(
                            padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                            child:buildRichTextWidget("Mobile No. : ", cont.billReportList.isEmpty?"":
                        cont.billReportList[0].mobileNo!))
                        :const Opacity(opacity: 0.0),

                        cont.showBillReport?
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,top: 5.0),
                          child: Row(
                            children: [
                              buildRichTextWidget("Bill No. : ", cont.billReportList.isEmpty?"":
                              cont.billReportList[0].billNo!),const Spacer(),
                              buildRichTextWidget("Bill Date : ", cont.billReportList.isEmpty?"":
                              cont.billReportList[0].billDate!)
                            ],
                          ),
                        ):const Opacity(opacity: 0.0),

                        cont.showBillReport?
                        Padding(
                            padding: const EdgeInsets.only(left: 10.0,top: 5.0),
                            child:buildRichTextWidget("Customer Name : ", cont.billReportList.isEmpty?"":
                            cont.billReportList[0].custAccountName!))
                            :const Opacity(opacity: 0.0),

                        cont.showBillReport
                            ? cont.isLoading ? buildCircularIndicator() :
                        cont.billReportList.isEmpty ? buildNoDataFound(context):
                        Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Table(
                                      border: TableBorder.all(color: whiteColor,width: 2.0),
                                      defaultColumnWidth: const IntrinsicColumnWidth(),
                                      children: [
                                        TableRow(
                                          decoration: const BoxDecoration(color: grey),
                                            children: [
                                              buildTableTitleForReport(context,"Product Name"),
                                              buildTableTitleForReport(context,"LOT No"),
                                              buildTableTitleForReport(context,"Quantity"),
                                              buildTableTitleForReport(context,"Weight"),
                                              buildTableTitleForReport(context,"Rate"),
                                              buildTableTitleForReport(context,"Amount"),
                                            ]
                                        ),
                                        for (var data in cont.billReportList)
                                          TableRow(
                                              decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                                              children: [
                                                buildTableSubtitleForReport(context,data.prodName.toString()),
                                                buildTableSubtitleForReport(context,data.lotNo.toString()),
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
                                              buildTableTitleForReport(context,cont.billReportList[0].totQty.toString()),
                                              buildTableTitleForReport(context,cont.billReportList[0].totWeight!),
                                              buildTableTitleForReport(context,""),
                                              buildTableTitleForReport(context,cont.billReportList[0].totAmount.toString()),
                                            ]
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0,),
                                    Table(
                                      border: TableBorder.all(color: blackColor,width: 2.0),
                                      defaultColumnWidth: const IntrinsicColumnWidth(),
                                      children:[
                                        TableRow(
                                            children: [
                                              buildTableTitleForReport(context,"Adat",),
                                              buildTableSubtitleForReport(context,cont.billReportList[0].adat!),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              buildTableTitleForReport(context,"M. Ses"),
                                              buildTableSubtitleForReport(context,cont.billReportList[0].mcess!),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              buildTableTitleForReport(context,"Hamali"),
                                              buildTableSubtitleForReport(context,cont.billReportList[0].custHamali!),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              buildTableTitleForReport(context,"Net Amount"),
                                              buildTableSubtitleForReport(context,cont.billReportList[0].netAmount!),
                                            ]
                                        ),
                                      ]
                                    )
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

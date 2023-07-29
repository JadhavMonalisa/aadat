import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/common/pdf_api.dart';
import 'package:adat/screens/customer/pdf/ledger_short_report_pdf.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:adat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerLedgerShortReportResultScreen extends StatefulWidget {
  const CustomerLedgerShortReportResultScreen({Key? key}) : super(key: key);

  @override
  State<CustomerLedgerShortReportResultScreen> createState() => _CustomerLedgerShortReportResultScreenState();
}

class _CustomerLedgerShortReportResultScreenState extends State<CustomerLedgerShortReportResultScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.backPressNavigation(AppRoutes.customerLedgerShortReport);
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Ledger Short Report Result", whiteColor, context, 15.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.backPressNavigation(AppRoutes.customerLedgerShortReport);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: whiteColor,)
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0,top: 30.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child:
                    ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10.0,bottom: 20.0),
                        //   child: buildTextRegularWidget("CUSTOMER LEDGER SHORT REPORT FOR\n${cont.selectedCustomer} "
                        //       "from ${cont.selectedShortReportFromDateToShow} to ${cont.selectedShortReportToDateToShow} "
                        //       "of ${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20.0),
                          child: buildTextRegularWidget("CUSTOMER LEDGER SHORT REPORT FOR\n${cont.selectedCustomer} "
                              "FROM ${cont.selectedShortReportFromDateToShow} to ${cont.selectedShortReportToDateToShow} "
                              "OF\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: GestureDetector(
                              onTap: () async {
                                // if(cont.ledgerShortReportList.isEmpty){
                                //   Utils.showErrorSnackBar("Please get report first!");
                                // }
                                // else{
                                //   final pdfFile = await LedgerShortReportExportScreen.generate(cont.ledgerShortReportList,cont);
                                //   PdfApi.openFile(pdfFile);
                                // }
                              },
                              child: buildButtonWidget(context, "EXPORT TO PDF",
                                  width: 170.0,
                                  height: 40.0,buttonColor: cont.ledgerShortReportList.isEmpty?grey:orangeColor),
                            )
                          ),
                        ),

                        TextField(
                          onChanged: (value) {
                           cont.filterSearchResults(value);
                          },
                          controller: cont.editingController,
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                cont.isLoading = true;
                                cont.editingController.clear();
                                cont.searchList.clear();
                                cont.callLedgerShortReportList();
                              },
                              child: const Icon(Icons.clear),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0.0),
                              ),
                            ),
                          ),
                        ),

                        cont.isLoading ? buildCircularIndicator():
                        cont.searchList.isNotEmpty || cont.editingController.text.isNotEmpty ?
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cont.searchList.length,
                            itemBuilder: (context,index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20.0,),
                                  cont.searchList.isEmpty?const Text(""):
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                      child:buildTextBoldWidget(cont.searchList[index].shortReportList![0].accountName!,
                                          blackColor, context, 15.0,align: TextAlign.left)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top:10.0),
                                    child: Table(
                                      border: TableBorder.all(color: whiteColor,width: 2.0),
                                      defaultColumnWidth: const IntrinsicColumnWidth(),
                                      children: [
                                        TableRow(
                                            decoration: const BoxDecoration(color: grey),
                                            children: [
                                              buildTableTitleForReport(context,"Date",align: TextAlign.center),
                                              buildTableTitleForReport(context,"Amount",align: TextAlign.center),
                                            ]
                                        ),
                                        for (var data in cont.searchList[index].shortReportList!)
                                          TableRow(
                                              decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                                              children: [
                                                buildTableSubtitleForReport(context,data.billDate.toString()),
                                                buildTableSubtitleForReport(context,data.amount.toString(),align: TextAlign.right),
                                              ]
                                          ),
                                        TableRow(
                                            decoration: const BoxDecoration(color: grey),
                                            children: [
                                              buildTableTitleForReport(context,"Total",align: TextAlign.center),
                                              buildTableTitleForReport(context,cont.totalCustomerLedgerShortAmtList.isEmpty?"":
                                              cont.totalCustomerLedgerShortAmtList[index].toString(),align: TextAlign.right),
                                            ]
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            })
                            :
                        cont.ledgerShortReportList.isEmpty ? buildNoDataFound(context):
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cont.ledgerShortReportList.length,
                            itemBuilder: (context,index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20.0,),
                                  cont.ledgerShortReportList.isEmpty?const Text(""):
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                      child:buildTextBoldWidget(cont.ledgerShortReportList[index].shortReportList![0].accountName!,
                                          blackColor, context, 15.0,align: TextAlign.left)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top:10.0),
                                    child: Table(
                                      border: TableBorder.all(color: whiteColor,width: 2.0),
                                      defaultColumnWidth: const IntrinsicColumnWidth(),
                                      children: [
                                        TableRow(
                                            decoration: const BoxDecoration(color: grey),
                                            children: [
                                              buildTableTitleForReport(context,"Date",align: TextAlign.center),
                                              buildTableTitleForReport(context,"Amount",align: TextAlign.center),
                                            ]
                                        ),
                                        for (var data in cont.ledgerShortReportList[index].shortReportList!)
                                          TableRow(
                                              decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                                              children: [
                                                buildTableSubtitleForReport(context,data.billDate.toString()),
                                                buildTableSubtitleForReport(context,data.amount.toString(),align: TextAlign.right),
                                              ]
                                          ),
                                        TableRow(
                                            decoration: const BoxDecoration(color: grey),
                                            children: [
                                              buildTableTitleForReport(context,"Total",align: TextAlign.center),
                                              buildTableTitleForReport(context,cont.totalCustomerLedgerShortAmtList.isEmpty?"":
                                              cont.totalCustomerLedgerShortAmtList[index].toString(),align: TextAlign.right),
                                            ]
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            })
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

import 'package:adat/common_widget/widget.dart';
import 'package:adat/screens/common/pdf_api.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/screens/supplier/pdf/supplier_ledger_summary_report_pdf.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:adat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierSummaryReport extends StatefulWidget {
  const SupplierSummaryReport({Key? key}) : super(key: key);

  @override
  State<SupplierSummaryReport> createState() => _SupplierSummaryReportState();
}

class _SupplierSummaryReportState extends State<SupplierSummaryReport> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.navigateFromSummaryToHomeScreen();
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Ledger Summary Report", whiteColor, context, 16.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.navigateFromSummaryToHomeScreen();
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
                          child: buildTextRegularWidget("LEDGER SUMMARY REPORT FOR\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),

                        Row(
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: (){
                                  cont.selectSupplierDate(context,"ledgerSummaryFromDate");
                                },
                                child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color:primaryColor),),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10.0,),
                                      buildTextRegularWidget(cont.selectedLedgerSummaryFromDate==""?"From Date":cont.selectedLedgerSummaryFromDate, primaryColor, context, 15.0),
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
                              child: GestureDetector(
                                onTap: (){
                                  cont.selectSupplierDate(context,"ledgerSummaryToDate");
                                },
                                child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color:primaryColor),),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10.0,),
                                        buildTextRegularWidget(cont.selectedLedgerSummaryToDate==""?"To Date":cont.selectedLedgerSummaryToDate, primaryColor, context, 15.0),
                                        const Spacer(),
                                        const Icon(Icons.calendar_month,color: primaryColor,),
                                        const SizedBox(width: 10.0,)
                                      ],
                                    )
                                ),
                              ),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0),
                          child: Row(
                            children: [
                              Flexible(
                                child:GestureDetector(
                                  onTap: (){
                                    cont.showSupplierLedgerSummaryReport();
                                  },
                                  child:  buildButtonWidget(context, "Get Report", buttonColor: orangeColor),
                                )
                              ),
                              const SizedBox(width: 10.0,),
                              Flexible(
                                  child:GestureDetector(
                                    onTap: () async {
                                      if(cont.supplierLedgerSummaryReportList.isEmpty)
                                      {
                                        Utils.showErrorSnackBar("Please first get report!");
                                      }
                                      else{
                                        final pdfFile = await SupplierLedgerSummaryReportExportScreen.generate(cont.supplierLedgerSummaryReportList,cont);
                                        PdfApi.openFile(pdfFile);
                                      }
                                    },
                                    child:  buildButtonWidget(context, "EXPORT TO PDF", buttonColor:
                                    cont.supplierLedgerSummaryReportList.isEmpty?grey:orangeColor),
                                  )
                              )
                            ],
                          ),
                        ),

                        cont.isLoading ? buildCircularIndicator() :
                        cont.isViewSelected ? cont.supplierLedgerSummaryReportList.isEmpty ? buildNoDataFound(context) :
                             Scrollbar(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0,right: 10.0,top:20.0),
                                  child: Table(
                                    border: TableBorder.all(color: whiteColor,width: 2.0),
                                    defaultColumnWidth: const IntrinsicColumnWidth(),
                                    children: [
                                      TableRow(
                                          decoration: const BoxDecoration(color: grey),
                                          children: [
                                            buildTableTitleForReport(context,"Account No",align: TextAlign.center),
                                            buildTableTitleForReport(context,"Supplier",align: TextAlign.center),
                                            buildTableTitleForReport(context,"Mobile No",align: TextAlign.center),
                                            buildTableTitleForReport(context,"Debit Amt",align: TextAlign.center),
                                            buildTableTitleForReport(context,"Credit Amt",align: TextAlign.center),
                                          ]
                                      ),
                                      for (var data in cont.supplierLedgerSummaryReportList)
                                        TableRow(
                                            decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                                            children: [
                                              buildTableSubtitleForReport(context,data.acctNO.toString()),
                                              buildTableSubtitleForReport(context,data.suppAccountName.toString(),align: TextAlign.left),
                                              buildTableSubtitleForReport(context,data.mobile.toString()),
                                              buildTableSubtitleForReport(context,data.debitAmount.toString(),align: TextAlign.right),
                                              buildTableSubtitleForReport(context,data.creditAmount.toString(),align: TextAlign.right),
                                            ]
                                        ),
                                      TableRow(
                                          decoration: const BoxDecoration(color: grey),
                                          children: [
                                            buildTableSubtitleForReport(context,""),
                                            buildTableSubtitleForReport(context,""),
                                            buildTableSubtitleForReport(context,"Total",fontWeight: FontWeight.bold),
                                            buildTableSubtitleForReport(context,cont.totalSupplierLedgerSummaryReportDebit.toString(),
                                                fontWeight: FontWeight.bold,align: TextAlign.right),
                                            buildTableSubtitleForReport(context,cont.totalSupplierLedgerSummaryReportCredit.toString(),
                                                fontWeight: FontWeight.bold,align: TextAlign.right),
                                          ]
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ) : const Opacity(opacity: 0.0)
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

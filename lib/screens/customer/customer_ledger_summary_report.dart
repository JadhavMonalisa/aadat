import 'package:adat/common_widget/widget.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CustomerLedgerSummaryReport extends StatefulWidget {
  const CustomerLedgerSummaryReport({Key? key}) : super(key: key);

  @override
  State<CustomerLedgerSummaryReport> createState() => _CustomerLedgerSummaryReportState();
}

class _CustomerLedgerSummaryReportState extends State<CustomerLedgerSummaryReport> {
  final pdf = pw.Document();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.navigateFromSummaryToHome();
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: primaryColor,
                  centerTitle: true,
                  title: buildTextBoldWidget("Ledger Summary Report", whiteColor, context, 16.0),
                  leading: GestureDetector(
                      onTap: () {
                        cont.navigateFromSummaryToHome();
                      },
                      child: const Icon(Icons.arrow_back_ios, color: whiteColor,)
                  ),
                  actions: [
                    GestureDetector(
                      onTap: (){},
                      child: const Icon(Icons.print,color: whiteColor,size: 30.0,),
                    ),
                    const SizedBox(width: 10.0,),]
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
                          child: buildTextRegularWidget("CUSTOMER LEDGER SUMMARY REPORT FOR\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      cont.selectCustomerDate(context,"summaryReportFromDate");
                                    },
                                    child: Container(
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(color:primaryColor),),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10.0,),
                                          buildTextRegularWidget(cont.selectedSummaryReportFromDateToShow==""?"From Date":cont.selectedSummaryReportFromDateToShow, primaryColor, context, 15.0),
                                          const Spacer(),
                                          const Icon(Icons.calendar_month,color: primaryColor,),
                                          const SizedBox(width: 10.0,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10.0,),
                            Flexible(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    cont.selectCustomerDate(context,"summaryReportToDate");
                                  },
                                  child: Container(
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(color:primaryColor),),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10.0,),
                                          buildTextRegularWidget(cont.selectedSummaryReportToDateToShow==""?"To Date":cont.selectedSummaryReportToDateToShow, primaryColor, context, 15.0),
                                          const Spacer(),
                                          const Icon(Icons.calendar_month,color: primaryColor,),
                                          const SizedBox(width: 10.0,)
                                        ],
                                      )
                                  ),
                                ),
                              ],))
                          ],
                        ),
                        const SizedBox(height: 20.0,),
                        Padding(
                            padding: const EdgeInsets.only(left: 100.0,right: 100.0),
                            child:GestureDetector(
                              onTap: (){
                                cont.getLedgerSummaryReport();
                              },
                              child:  buildButtonWidget(context, "GET REPORT", buttonColor: orangeColor),
                            )
                        ),
                        const SizedBox(height: 20.0,),

                        cont.isLoading ? buildCircularIndicator():

                        cont.isViewSelected
                            ?
                        cont.ledgerSummaryReportList.isEmpty ? buildNoDataFound(context):
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                child:Table(
                                  border: TableBorder.all(color: whiteColor,width: 2.0),
                                  defaultColumnWidth: const IntrinsicColumnWidth(),
                                  children: [
                                    TableRow(
                                        children: [
                                          buildTableTitleForReport(context,"Account No"),
                                          buildTableTitleForReport(context,"Account Name"),
                                          buildTableTitleForReport(context,"Debit Amt"),
                                          buildTableTitleForReport(context,"Credit Amt"),
                                          buildTableTitleForReport(context,"Mobile No"),
                                        ]
                                    ),
                                    for (var data in cont.ledgerSummaryReportList)
                                      TableRow(
                                          children: [
                                            buildTableSubtitleForReport(context,data.acctNO.toString()),
                                            buildTableSubtitleForReport(context,data.custAccountName!),
                                            buildTableSubtitleForReport(context,data.debitAmount.toString()),
                                            buildTableSubtitleForReport(context,data.creditAmount.toString()),
                                            buildTableSubtitleForReport(context,data.mobile!),
                                          ]
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                            : const Opacity(opacity: 0.0)
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

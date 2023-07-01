import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20.0),
                          child: buildTextRegularWidget("CUSTOMER LEDGER SHORT REPORT FOR\n${cont.selectedCustomer} "
                              "from ${cont.selectedShortReportFromDateToShow} to ${cont.selectedShortReportToDateToShow} "
                              "of ${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0,left: 250.0),
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: buildButtonWidget(context, "Export to",width: 100.0,height: 40.0),
                          )
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
                        cont.ledgerShortReportList.isEmpty ? buildNoDataFound(context):
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cont.ledgerShortReportList.length,
                            itemBuilder: (context,index){
                          return Column(
                            children: [
                              const SizedBox(height: 20.0,),
                              cont.ledgerShortReportList.isEmpty?const Text(""):
                              Center(child:buildTextBoldWidget(cont.ledgerShortReportList[index].accountName!,
                                  blackColor, context, 15.0)),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top:10.0),
                                child: Table(
                                  border: TableBorder.all(color: whiteColor,width: 2.0),
                                  defaultColumnWidth: const IntrinsicColumnWidth(),
                                  children: [
                                    // TableRow(
                                    //     children: [
                                    //       buildTableTitleForReport(context,"Amount"),
                                    //       buildTableTitleForReport(context,"Account Name"),
                                    //       buildTableTitleForReport(context,"Bill Date"),
                                    //       buildTableTitleForReport(context,"Account No"),
                                    //     ]
                                    // ),
                                    // for (var data in cont.ledgerShortReportList)
                                    //   TableRow(
                                    //       children: [
                                    //         buildTableSubtitleForReport(context,data.amount.toString()),
                                    //         buildTableSubtitleForReport(context,data.accountName!),
                                    //         buildTableSubtitleForReport(context,data.billDate!),
                                    //         buildTableSubtitleForReport(context,data.acctNo.toString()),
                                    //       ]
                                    //   ),
                                    TableRow(
                                        children: [
                                          buildTableTitleForReport(context,"Amount",align: TextAlign.center),
                                          buildTableTitleForReport(context,"Date",align: TextAlign.center),
                                        ]
                                    ),
                                    //for (var data in cont.ledgerShortReportList)
                                      TableRow(
                                          children: [
                                            buildTableSubtitleForReport(context,cont.ledgerShortReportList[index].amount.toString()),
                                            buildTableSubtitleForReport(context,cont.ledgerShortReportList[index].billDate.toString()),
                                          ]
                                      ),
                                    TableRow(
                                        children: [
                                          buildTableSubtitleForReport(context,cont.totalCustomerLedgerShortAmtList.isEmpty?"":
                                              cont.totalCustomerLedgerShortAmtList[index].toString(),fontWeight: FontWeight.bold),
                                          buildTableSubtitleForReport(context,""),
                                        ]
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
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

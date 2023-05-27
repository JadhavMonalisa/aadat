import 'package:adat/common_widget/widget.dart';
import 'package:adat/screens/customer/customer_controller.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerLedgerShortReport extends StatefulWidget {
  const CustomerLedgerShortReport({Key? key}) : super(key: key);

  @override
  State<CustomerLedgerShortReport> createState() => _CustomerLedgerShortReportState();
}

class _CustomerLedgerShortReportState extends State<CustomerLedgerShortReport> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.navigateFromShortReportToHome();
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Ledger Short Report", whiteColor, context, 16.0),
                leading: GestureDetector(
                    onTap: () {
                     cont.navigateFromShortReportToHome();
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
                          child: buildTextRegularWidget("CUSTOMER LEDGER SHORT REPORT FOR\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
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
                                      cont.selectCustomerDate(context,"shortReportFromDate");
                                    },
                                    child: Container(
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(color:primaryColor),),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10.0,),
                                          buildTextRegularWidget(cont.selectedShortReportFromDateToShow==""?"From Date":cont.selectedShortReportFromDateToShow, primaryColor, context, 15.0),
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
                                  cont.selectCustomerDate(context,"shortReportToDate");
                                },
                                child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color:grey),),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10.0,),
                                        buildTextRegularWidget(cont.selectedShortReportToDateToShow == "" ?"To Date": cont.selectedShortReportToDateToShow, primaryColor, context, 15.0),
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
                                cont.getLedgerShortReport();
                              },
                              child:  buildButtonWidget(context, "GET REPORT", buttonColor: orangeColor),
                            )
                        ),
                        const SizedBox(height: 20.0,),
                        cont.isLoading ? buildCircularIndicator() :
                        cont.isViewSelected 
                        ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
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

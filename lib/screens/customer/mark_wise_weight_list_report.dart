import 'package:adat/common_widget/widget.dart';
import 'package:adat/screens/customer/customer_controller.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarkWiseWeightListReportScreen extends StatefulWidget {
  const MarkWiseWeightListReportScreen({Key? key}) : super(key: key);

  @override
  State<MarkWiseWeightListReportScreen> createState() => _MarkWiseWeightListReportScreenState();
}

class _MarkWiseWeightListReportScreenState extends State<MarkWiseWeightListReportScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.navigateFromMarkWiseToHome();
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: primaryColor,
                  centerTitle: true,
                  title: buildTextBoldWidget("Mark Wise Weight List", whiteColor, context, 16.0),
                  leading: GestureDetector(
                      onTap: () {
                        cont.navigateFromMarkWiseToHome();
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
                child:  SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                      child: Padding(
                  padding: const EdgeInsets.only(top:10.0,left:10.0,right:10.0,bottom: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0,bottom: 20.0),
                        child: buildTextRegularWidget("CUSTOMER MARK WISE WEIGHT LIST FOR\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
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

                      cont.showCustomerList ?
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 20.0),
                        child: buildTextBoldWidget("Select customer", blackColor, context, 15.0),
                      ): const Opacity(opacity: 0.0),

                      cont.showCustomerList
                          ? Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cont.customerList.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return Row(
                                children: [
                                  Checkbox(value:
                                  cont.addedCustomerIndex.contains(index)
                                      ? true : false ,
                                      activeColor: Colors.green,
                                      onChanged:(newValue){
                                        cont.updateCustomerCheckBox(newValue!,index);
                                      }),
                                  const SizedBox(width: 5.0,),
                                  buildTextRegularWidget(cont.customerList[index].custAccountName!, blackColor, context, 14.0)
                                ],
                              );
                            }),
                      )
                          : const Opacity(opacity:0.0),

                      Padding(
                          padding: const EdgeInsets.only(left: 100.0,right: 100.0,top: 20.0),
                          child:GestureDetector(
                            onTap: (){
                              //cont.getLedgerMarkWise();
                            },
                            child:  buildButtonWidget(context, "GET REPORT", buttonColor: orangeColor),
                          )
                      ),
                    ],
                  )
                ),
                    )
              ),
            )
        ),
      );
    });
  }
}

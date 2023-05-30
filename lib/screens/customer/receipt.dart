import 'package:adat/common_widget/widget.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerReceipt extends StatefulWidget {
  const CustomerReceipt({Key? key}) : super(key: key);

  @override
  State<CustomerReceipt> createState() => _CustomerReceiptState();
}

class _CustomerReceiptState extends State<CustomerReceipt> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
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
                title: buildTextBoldWidget("Customer Receipt", whiteColor, context, 15.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.navigateFromReceiptToHome();
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
                        child: buildTextRegularWidget("CUSTOMER RECEIPT REPORT FOR\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                      ),
                      GestureDetector(
                        onTap: (){
                          cont.selectCustomerDate(context,"receiptDate");
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Container(
                              height: 40.0,width: 200.0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color:primaryColor),),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10.0,),
                                  buildTextRegularWidget(cont.selectedReceiptBillDateToShow==""?"Bill Date (Optional)":cont.selectedReceiptBillDateToShow, primaryColor, context, 15.0),
                                  const Spacer(),
                                  const Icon(Icons.calendar_month,color: primaryColor,),
                                  const SizedBox(width: 10.0,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0,),

                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color:primaryColor),),
                              child: TextFormField(
                                controller: cont.receiptBillNo,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                textInputAction: TextInputAction.done,
                                onTap: () {
                                },
                                style:const TextStyle(fontSize: 15.0,color: primaryColor),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    hintText: "Bill No",
                                    hintStyle: TextStyle(color: primaryColor),
                                    suffixIcon: Icon(Icons.receipt,color: primaryColor,)
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
                                controller: cont.receiptSearchParameter,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                textInputAction: TextInputAction.done,
                                onTap: () {
                                },
                                style:const TextStyle(fontSize: 15.0,color: primaryColor),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    hintText: "Search ",
                                    hintStyle: TextStyle(color: primaryColor),
                                    suffixIcon: Icon(Icons.search,color: primaryColor,)
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 40.0,),

                      Padding(
                          padding: const EdgeInsets.only(left: 100.0,right: 100.0),
                          child:GestureDetector(
                            onTap: (){
                              cont.showReceiptReport();
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

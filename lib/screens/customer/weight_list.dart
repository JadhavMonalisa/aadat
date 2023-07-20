
import 'package:adat/common_widget/widget.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/painting/box_border.dart' as border;

class WeightListScreen extends StatefulWidget {
  const WeightListScreen({Key? key}) : super(key: key);

  @override
  State<WeightListScreen> createState() => _WeightListScreenState();
}

class _WeightListScreenState extends State<WeightListScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.navigateFromWeightListToHome();
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Weight List (Rough Bill)", whiteColor, context, 16.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.navigateFromWeightListToHome();
                    },
                    child: const Icon(Icons.arrow_back_ios, color: whiteColor,)
                ),
              ),
              body:
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0,top: 30.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 30.0,bottom: 20.0),
                          child: buildTextRegularWidget("WEIGHT LIST (ROUGH BILL) REPORT FOR\n"
                              "${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),

                        GestureDetector(
                          onTap: (){
                            cont.selectCustomerDate(context,"forWeightList");
                          },
                          child: Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              border: border.Border.all(color:primaryColor),),
                            child: Row(
                              children: [
                                const SizedBox(width: 10.0,),
                                buildTextRegularWidget(cont.selectedDateForWeightList==""?"Select Bill Date":cont.selectedDateForWeightList, primaryColor, context, 15.0),
                                const Spacer(),
                                const Icon(Icons.calendar_month,color: primaryColor,),
                                const SizedBox(width: 10.0,)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0,),

                        cont.isBillDateAdded ?
                            cont.loaderForCustomer ? buildCircularIndicator() :
                          cont.customerByDateList.isEmpty ? buildNoDataFound(context):
                          SizedBox(
                          height: MediaQuery.of(context).size.height/2.5,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: cont.customerByDateList.length,
                              itemBuilder: (context,index){
                            return Row(
                              children: [
                                Checkbox(value:
                                cont.addedWeightListIndex.contains(index)
                                    ? true : false ,
                                    activeColor: Colors.green,
                                    onChanged:(newValue){
                                      cont.updateWeightListCheckBox(newValue!,index,cont.customerByDateList[index].custAccountName!);
                                    }),
                                buildTextRegularWidget(cont.customerByDateList[index].custAccountName!,
                                    blackColor, context, 15.0),
                              ],
                            );
                          }),
                        )
                        : const Opacity(opacity: 0.0),

                        //
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 20.0,left: 50.0,right: 50.0),
                        //   child: SizedBox(
                        //       height: 40.0,
                        //       child: Center(
                        //           child: Container(
                        //             width: 230.0,height: 40.0,
                        //             decoration: BoxDecoration(
                        //               borderRadius: const BorderRadius.all(Radius.circular(5)),
                        //               border: Border.all(color:primaryColor),),
                        //             child: Padding(
                        //               padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                        //               child: DropdownButton<String>(
                        //                 hint: buildTextBoldWidget(cont.selectedCustomer==""?"Select Customer":cont.selectedCustomer,
                        //                     primaryColor, context, 15.0),
                        //                 isExpanded: true,
                        //                 underline: Container(),
                        //                 icon: const Icon(Icons.arrow_drop_down,color: primaryColor,size: 30.0,),
                        //                 items:
                        //                 cont.customerList.isEmpty
                        //                     ?
                        //                 cont.noDataList.map((value) {
                        //                   return DropdownMenuItem<String>(
                        //                     value: value,
                        //                     child: buildTextBoldWidget(value, primaryColor, context, 15.0),
                        //                   );
                        //                 }).toList()
                        //                     :
                        //                 cont.customerList.map((CustomerListDetails value) {
                        //                   return DropdownMenuItem<String>(
                        //                     value: value.custAccountName,
                        //                     child: buildTextBoldWidget(value.custAccountName!, primaryColor, context, 15.0,align: TextAlign.left),
                        //                     onTap: (){
                        //                       cont.updateSelectedCustomer(value.custAccountName!);
                        //                     },
                        //                   );
                        //                 }).toList(),
                        //                 onChanged: (val) {
                        //                   cont.updateSelectedCustomer(val!);
                        //                 },
                        //               ),
                        //             ),
                        //           )
                        //       )
                        //   ),
                        // ),
                        Padding(
                            padding: const EdgeInsets.only(left: 100.0,right: 100.0,bottom: 20.0,top:20.0),
                            child:GestureDetector(
                              onTap: (){
                                cont.getWeightList();
                              },
                              child:  buildButtonWidget(context, "GET REPORT", buttonColor: orangeColor),
                            )
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0,top:20.0),
                        //   child: Row(
                        //     children: [
                        //       Flexible(child: GestureDetector(
                        //         onTap: (){
                        //           cont.getWeightList();
                        //         },
                        //         child:  buildButtonWidget(context, "GET REPORT", buttonColor: orangeColor),
                        //       )),
                        //       const SizedBox(width: 10.0,),
                        //       Flexible(child: GestureDetector(
                        //         onTap: () async{
                        //           //cont.getWeightList();
                        //           final pdfFile = await PdfSubscriptionHistoryApi.generate(cont.weightList,0);
                        //           PdfApi.openFile(pdfFile);
                        //         },
                        //         child:  buildButtonWidget(context, "EXPORT TO PDF", buttonColor: orangeColor),
                        //       )),
                        //     ],
                        //   ),
                        // ),

                        cont.isViewSelected?
                        Align(
                          alignment: Alignment.center,
                          child:buildTextBoldWidget(
                              cont.weightList.isEmpty?"":
                              cont.weightList[0].custAccountName!, blackColor, context, 15.0,align: TextAlign.center),
                        ):const Opacity(opacity: 0.0,),

                        cont.isViewSelected?
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,top: 5.0,bottom: 5.0),
                          child: buildRichTextWidget("Bill Date : ", cont.weightList.isEmpty?"":
                          cont.weightList[0].billDate!)
                        ):const Opacity(opacity: 0.0),

                        cont.loaderForWeightList ? buildCircularIndicator() :
                        cont.isViewSelected
                            ?
                        cont.weightList.isEmpty ? Center(child:buildNoDataFound(context)) :
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,),
                              child:Scrollbar(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  child: Padding(
                                      padding: const EdgeInsets.only(bottom:30.0),
                                      child:
                                      Table(
                                        border: TableBorder.all(color: whiteColor,width: 2.0),
                                        defaultColumnWidth: const IntrinsicColumnWidth(),
                                        children: [
                                          TableRow(
                                              decoration: const BoxDecoration(color: grey),
                                              children: [
                                                buildTableTitleForReport(context,"Bill Date"),
                                                buildTableTitleForReport(context,"Customer"),
                                                buildTableTitleForReport(context,"LOT No."),
                                                buildTableTitleForReport(context,"Quantity"),
                                                buildTableTitleForReport(context,"Weight"),
                                                buildTableTitleForReport(context,"Rate"),
                                                buildTableTitleForReport(context,"Supplier"),
                                              ]
                                          ),
                                          for (var data in cont.weightList)
                                            TableRow(
                                                decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                                                children: [
                                                  buildTableSubtitleForReport(context,data.billDate!),
                                                  buildTableSubtitleForReport(context,data.custAccountName!),
                                                  buildTableSubtitleForReport(context,data.remark!),
                                                  buildTableSubtitleForReport(context,data.qty.toString()),
                                                  buildTableSubtitleForReport(context,data.weight.toString()),
                                                  buildTableSubtitleForReport(context,data.rate.toString(),align: TextAlign.right),
                                                  buildTableSubtitleForReport(context,data.suppAccountName!),
                                                ]
                                            ),
                                        ],
                                      )
                                  ),
                                ),
                              )
                            )

                        // ?  SfDataGrid(
                        //   key: cont.key,
                        //   source: cont.weightListDataSource,
                        //   columnWidthMode: ColumnWidthMode.auto,
                        //   columns: <GridColumn>[
                        //     GridColumn(
                        //         columnName: 'Bill Date',
                        //         label: Container(
                        //             padding: const EdgeInsets.all(16.0),
                        //             alignment: Alignment.centerLeft,
                        //             child: const Text(
                        //               'Bill Date',
                        //             ))),
                        //     GridColumn(
                        //         columnName: 'Customer',
                        //         label: Container(
                        //             padding: const EdgeInsets.all(8.0),
                        //             alignment: Alignment.centerLeft,
                        //             child: const Text('Customer'))),
                        //     GridColumn(
                        //         columnName: 'LOT No',
                        //         width: 100.0,
                        //         label: Container(
                        //             padding: const EdgeInsets.all(8.0),
                        //             alignment: Alignment.centerLeft,
                        //             child: const Text(
                        //               'LOT No',
                        //               overflow: TextOverflow.ellipsis,
                        //             ))),
                        //     GridColumn(
                        //         columnName: 'Quantity',
                        //         label: Container(
                        //             padding: const EdgeInsets.all(8.0),
                        //             alignment: Alignment.centerLeft,
                        //             child: const Text('Quantity'))),
                        //     GridColumn(
                        //         columnName: 'Weight',
                        //         label: Container(
                        //             padding: const EdgeInsets.all(8.0),
                        //             alignment: Alignment.centerLeft,
                        //             child: const Text('Weight'))),
                        //     GridColumn(
                        //         columnName: 'Rate',
                        //         label: Container(
                        //             padding: const EdgeInsets.all(8.0),
                        //             alignment: Alignment.centerLeft,
                        //             child: const Text('Rate'))),
                        //     GridColumn(
                        //         columnName: 'Supplier',
                        //         label: Container(
                        //             padding: const EdgeInsets.all(8.0),
                        //             alignment: Alignment.centerLeft,
                        //             child: const Text('Supplier'))),
                        //   ],
                        // )
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

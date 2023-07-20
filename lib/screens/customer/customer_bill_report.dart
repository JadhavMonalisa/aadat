import 'dart:io';

import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/customer/pdf/bill_report_pdf.dart';
import 'package:adat/screens/customer/pdf_api.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:adat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart'
as path_provider_interface;

class BillReportScreen extends StatefulWidget {
  const BillReportScreen({Key? key}) : super(key: key);

  @override
  State<BillReportScreen> createState() => _BillReportScreenState();
}

class _BillReportScreenState extends State<BillReportScreen> {
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory =
      await path_provider.getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await path_provider_interface.PathProviderPlatform.instance
          .getApplicationSupportPath();
    }

    final String fileLocation =
    Platform.isWindows ? '$path\\$fileName' : '$path/$fileName';
    final File file = File(fileLocation);
    await file.writeAsBytes(bytes, flush: true);

    if (Platform.isAndroid || Platform.isIOS) {
      await open_file.OpenFile.open(fileLocation);
    } else if (Platform.isWindows) {
      await Process.run('start', <String>[fileLocation], runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>[fileLocation], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>[fileLocation], runInShell: true);
    }
  }

  Future<void> exportDataGridToPdf() async {
    final PdfDocument document =
    key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true);

    final List<int> bytes = document.saveSync();
    await saveAndLaunchFile(bytes, 'DataGrid.pdf');
    document.dispose();
  }

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
                      cont.onBackPressFromBillReport();
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
                          child: buildTextRegularWidget("Bill REPORT FOR\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
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
                                    cont.onBillNoSelectionChange();
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
                            padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
                            child:Row(
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: (){
                                      cont.showBillResult();
                                    },
                                    child:  buildButtonWidget(context, "GET REPORT", buttonColor: orangeColor),
                                  ),
                                ),
                                      const SizedBox(width: 10.0,),
                                      Flexible(child: GestureDetector(
                                        onTap: () async{
                                          if(cont.showBillReport==false)
                                           {
                                             Utils.showErrorSnackBar("Please first get report!");
                                           }
                                          else{
                                            final pdfFile = await BillReportExportScreen.generate(cont.billReportList,cont);
                                            PdfApi.openFile(pdfFile);
                                          }
                                        },
                                        child:  buildButtonWidget(context, "EXPORT TO PDF", buttonColor: orangeColor),
                                      )),
                              ],
                            )
                        ),
                        Align(
                          alignment: Alignment.center,
                          child:buildTextBoldWidget(
                              cont.billReportList.isEmpty?"":
                              cont.billReportList[0].custAccountName!, blackColor, context, 15.0,align: TextAlign.center),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child:buildTextRegularWidget(cont.billReportList.isEmpty?"":
                              cont.billReportList[0].firmAddress!, blackColor, context, 15.0,align: TextAlign.center),
                        ),
                        cont.showBillReport?
                        cont.billReportList.isEmpty ? const Opacity(opacity: 0.0):
                        Padding(
                            padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTextBoldWidget("Mobile No. : ", blackColor, context, 15.0),
                                Flexible(
                                  child:buildTextRegularWidget(cont.billReportList.isEmpty?"":
                                  cont.billReportList[0].mobileNo!, blackColor, context, 15.0,align: TextAlign.left),
                                )
                              ],
                            )
                        )
                        :const Opacity(opacity: 0.0),

                        cont.showBillReport?
                        cont.billReportList.isEmpty ? const Opacity(opacity: 0.0):
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
                        cont.billReportList.isEmpty ? const Opacity(opacity: 0.0):
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
                                      key: key,
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
                                                buildTableSubtitleForReport(context,data.rate.toString(),align: TextAlign.right),
                                                buildTableSubtitleForReport(context,data.amount.toString(),align: TextAlign.right),
                                              ]
                                          ),
                                          TableRow(
                                              decoration: const BoxDecoration(color: grey),
                                            children: [
                                              buildTableTitleForReport(context,"Total",align: TextAlign.center),
                                              buildTableTitleForReport(context,""),
                                              buildTableTitleForReport(context,cont.billReportList[0].totQty.toString(),align: TextAlign.right),
                                              buildTableTitleForReport(context,cont.billReportList[0].totWeight!,align: TextAlign.right),
                                              buildTableTitleForReport(context,""),
                                              buildTableTitleForReport(context,cont.billReportList[0].totAmount.toString(),align: TextAlign.right),
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
                                              buildTableSubtitleForReport(context,cont.billReportList[0].adat!,align: TextAlign.right),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              buildTableTitleForReport(context,"M. Ses"),
                                              buildTableSubtitleForReport(context,cont.billReportList[0].mcess!,align: TextAlign.right),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              buildTableTitleForReport(context,"Hamali"),
                                              buildTableSubtitleForReport(context,cont.billReportList[0].custHamali!,align: TextAlign.right),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              buildTableTitleForReport(context,"Net Amount"),
                                              buildTableSubtitleForReport(context,cont.billReportList[0].netAmount!,align: TextAlign.right),
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

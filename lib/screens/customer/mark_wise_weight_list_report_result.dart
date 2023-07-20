import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/customer/pdf/mark_wise_weight_list_report_pdf.dart';
import 'package:adat/screens/customer/pdf_api.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/screens/home/save_to_mobile.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class MarkWiseWeightListResultReport extends StatefulWidget {
  const MarkWiseWeightListResultReport({Key? key}) : super(key: key);

  @override
  State<MarkWiseWeightListResultReport> createState() => _MarkWiseWeightListResultReportState();
}

class _MarkWiseWeightListResultReportState extends State<MarkWiseWeightListResultReport> {
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await  Get.toNamed(AppRoutes.customerMarkWiseWeightListReportScreen);
        },
        child: SafeArea(
            child: Scaffold(
              key: key,
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Mark Wise Weight List Report Result", whiteColor, context, 15.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.backPressNavigationFromResult(AppRoutes.customerMarkWiseWeightListReportScreen);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: whiteColor,)
                ),
              ),
              body:
              cont.isLoading ? buildCircularIndicator() :
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0,top: 30.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20.0),
                          child: buildTextRegularWidget("CUSTOMER MARK WISE WEIGHT LIST REPORT FOR\n${cont.selectedCustomer} "
                              "BILL DATE ${cont.selectedBillDateToShow} "
                              "OF\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10.0,bottom: 20.0),
                        //   child:buildRichTextWidget("CUSTOMER MARK WISE WEIGHT LIST REPORT FOR ${cont.selectedCustomer} "
                        //       "BILL DATE ${cont.selectedBillDateToShow} ",
                        //       "OF ${cont.selectedFirm}",title1Weight: FontWeight.normal,title2Weight: FontWeight.normal,
                        //   title1Color: orangeColor,title2Color: orangeColor,title1Size: 17.0,title2Size: 17.0)
                        // ),

                        cont.addedMarkWiseListIndex.isEmpty?const Opacity(opacity: 0.0):
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0,left: 200.0),
                          child: GestureDetector(
                            onTap: () async {
                              // final pdfFile = await MarkWiseWeightListReportExportScreen.generate(cont.markWiseWeightList,cont);
                              // PdfApi.openFile(pdfFile);
                            },
                            child: buildButtonWidget(context, "EXPORT TO PDF",width: 100.0,height: 40.0),
                          ),
                        ),

                        cont.markWiseWeightList.isEmpty ? buildNoDataFound(context):
                        Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 30.0),
                              child:  Table(
                                border: TableBorder.all(color: whiteColor,width: 2.0),
                                defaultColumnWidth: const IntrinsicColumnWidth(),
                                children: [
                                  TableRow(
                                      decoration: const BoxDecoration(color: grey),
                                      children: [
                                        buildTableTitleForReport(context,"",boxColor:Colors.white),
                                        buildTableTitleForReport(context,"Customer Mark"),
                                        buildTableTitleForReport(context,"Customer Name"),
                                        buildTableTitleForReport(context,"Total Quantity"),
                                        buildTableTitleForReport(context,"Total Weight"),
                                        buildTableTitleForReport(context,"Avg. Rate"),
                                      ]
                                  ),
                                    for (int index = 0 ; index < cont.markWiseWeightList.length ; index ++)
                                    TableRow(
                                        decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                                        children: [
                                          Checkbox(value:
                                          cont.addedMarkWiseListIndex.contains(index)
                                              ? true : false ,
                                              activeColor: Colors.green,
                                              onChanged:(newValue){
                                                cont.updateMarkWiseListCheckBox(newValue!,index);
                                              }),
                                          buildTableSubtitleForReport(context,cont.markWiseWeightList[index].mark.toString()),
                                          buildTableSubtitleForReport(context,cont.selectedCustomerNameInMarkList),
                                          buildTableSubtitleForReport(context,cont.markWiseWeightList[index].qty.toString()),
                                          buildTableSubtitleForReport(context,cont.markWiseWeightList[index].weight.toString()),
                                          buildTableSubtitleForReport(context,cont.markWiseWeightList[index].amount.toString(),align: TextAlign.right),
                                        ]
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            )
        ),
      );
    });
  }

  Future<void> exportDataGridToPdf() async {
    final PdfDocument document =
    key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true,);

    final List<int> bytes = document.saveSync();
    await saveAndLaunchFile(bytes, 'DataGrid.pdf');
    //document.dispose();
  }

  exportThisDocument(){
    return GetBuilder<HomeController>(builder: (cont){
      return SfDataGrid(
        key: key,
        source: cont.markWiseWeightListDataSource,
        columnWidthMode: ColumnWidthMode.auto,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'Customer Mark',
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Customer Mark',
                  ))),
          GridColumn(
              columnName: 'Customer Name',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Customer Name'))),
          GridColumn(
              columnName: 'Total Quantity',
              width: 100.0,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Total Quantity',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'Total Weight',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Total Weight'))),
          GridColumn(
              columnName: 'Avg. Rate',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Avg. Rate'))),
        ],
      );
    });
  }
}


class MarkWiseWeightListDataSource extends DataGridSource {
  MarkWiseWeightListDataSource({required List<MarkWiseWeightListDetails> weightListData}) {
    _markWiseWeightListData = weightListData
        .map<DataGridRow>((MarkWiseWeightListDetails e) =>
        DataGridRow(cells: <DataGridCell>[
          DataGridCell<String>(
            columnName: 'Customer Mark',
            value: e.mark,
          ),
          DataGridCell<String>(
            columnName: 'Customer Name',
            value: e.custAccountName,
          ),
          DataGridCell<String>(
              columnName: 'Total Quantity', value: e.qty),
          DataGridCell<String>(columnName: 'Total Weight', value: e.weight),
          DataGridCell<String>(columnName: 'Avg. Rate', value: e.amount),
        ]))
        .toList();
  }

  List<DataGridRow> _markWiseWeightListData = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _markWiseWeightListData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell cell) {
          return Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cell.value.toString(),
            ),
          );
        }).toList());
  }
}

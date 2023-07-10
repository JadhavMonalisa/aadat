import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/screens/home/save_to_mobile.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

import '../../theme/app_colors.dart';

class CustomerWeightListExportScreen extends StatefulWidget {
  const CustomerWeightListExportScreen({Key? key}) : super(key: key);

  @override
  State<CustomerWeightListExportScreen> createState() => _CustomerWeightListExportScreenState();
}

class _CustomerWeightListExportScreenState extends State<CustomerWeightListExportScreen> {
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  Future<void> _exportDataGridToExcel() async {
    final Workbook workbook = key.currentState!.exportToExcelWorkbook();

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    await saveAndLaunchFile(bytes, 'DataGrid.xlsx');
  }

  Future<void> exportDataGridToPdf() async {
    final PdfDocument document =
    key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true,);

    final List<int> bytes = document.saveSync();
    await saveAndLaunchFile(bytes, 'DataGrid.pdf');
    //document.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return await Get.toNamed(AppRoutes.customerWightListScreen);
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: buildTextMediumWidget(
                  "Export weight list", whiteColor, context, 16,
                  align: TextAlign.center),
              leading: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.customerWightListScreen);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: whiteColor,
                ),
              ),
            ),
            body: cont.isLoading == true
                ? Center(
              child: buildCircularIndicator(),
            )
                : Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(12.0),
                  // child: Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     SizedBox(
                  //       height: 40.0,
                  //       width: 150.0,
                  //       child: MaterialButton(
                  //           color: approveColor,
                  //           onPressed: _exportDataGridToExcel,
                  //           child: const Center(
                  //               child: Text(
                  //                 'Export to Excel',
                  //                 style: TextStyle(color: Colors.white),
                  //               ))),
                  //     ),
                  //     const Padding(padding: EdgeInsets.all(20)),
                  //     SizedBox(
                  //       height: 40.0,
                  //       width: 150.0,
                  //       child: MaterialButton(
                  //           color: errorColor,
                  //           onPressed: _exportDataGridToPdf,
                  //           child: const Center(
                  //               child: Text(
                  //                 'Export to PDF',
                  //                 style: TextStyle(color: Colors.white),
                  //               ))),
                  //     ),
                  //   ],
                  // ),
                  child: SizedBox(
                    height: 40.0,
                    width: 150.0,
                    child: MaterialButton(
                        color: errorColor,
                        onPressed: exportDataGridToPdf,
                        // onPressed: (){
                        //   // pdfDoc.PdfDocument document = key.currentState!.exportToPdfDocument();
                        //   // final List<int> bytes = document.saveSync();
                        //   //cont.downloadPdf();
                        // },
                        child: const Center(
                            child: Text(
                              'Export to PDF',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
                Expanded(
                  child: SfDataGrid(
                    key: key,
                    source: cont.weightListDataSource,
                    columnWidthMode: ColumnWidthMode.auto,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'Bill Date',
                          label: Container(
                              padding: const EdgeInsets.all(16.0),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Bill Date',
                              ))),
                      GridColumn(
                          columnName: 'Customer',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: const Text('Customer'))),
                      GridColumn(
                          columnName: 'LOT No',
                          width: 100.0,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'LOT No',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          columnName: 'Quantity',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: const Text('Quantity'))),
                      GridColumn(
                          columnName: 'Weight',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: const Text('Weight'))),
                      GridColumn(
                          columnName: 'Rate',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: const Text('Rate'))),
                      GridColumn(
                          columnName: 'Supplier',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: const Text('Supplier'))),
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }
}

class WeightListDataSource extends DataGridSource {
  WeightListDataSource({required List<WeightListDetails> weightListData}) {
    _weightListData = weightListData
        .map<DataGridRow>((WeightListDetails e) =>
        DataGridRow(cells: <DataGridCell>[
          DataGridCell<String>(
            columnName: 'Bill Date',
            value: e.billDate,
          ),
          DataGridCell<String>(
            columnName: 'Customer',
            value: e.custAccountName,
          ),
          DataGridCell<String>(
              columnName: 'LOT No', value: e.remark),
          DataGridCell<String>(columnName: 'Quantity', value: e.qty),
          DataGridCell<String>(columnName: 'Weight', value: e.weight),
          DataGridCell<String>(
              columnName: 'Rate', value: e.rate),
          DataGridCell<String>(columnName: 'Supplier', value: e.suppAccountName,),
        ]))
        .toList();
  }

  List<DataGridRow> _weightListData = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _weightListData;

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

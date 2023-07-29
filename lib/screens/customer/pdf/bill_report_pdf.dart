import 'dart:io';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/common/pdf_api.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class BillReportExportScreen {

  static int startIndex = 0;
  static int endIndex = 0;
  static int totalLength = 0;

  static Future<File> generate(List<BillReportListData> billListPdf,HomeController cont) async {
    final pdf = Document();
    final font = await rootBundle.load("assets/font/Hindi.ttf");
    final ttf = pw.Font.ttf(font);

    if(billListPdf.length<=10){
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex == 0 ?
        buildHeader(billListPdf[0].billDate!,billListPdf[0].custAccountName!,
            billListPdf[0].firmAddress!, billListPdf[0].mobileNo!,billListPdf[0].billNo!,ttf)
            : Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
            border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable("Product Name"),
                  buildTitleForTable("LOT No"),
                  buildTitleForTable("Quantity"),
                  buildTitleForTable("Weight"),
                  buildTitleForTable("Rate"),
                  buildTitleForTable("Amount"),
                ],
              ),
              for(int i = 0 ;i < billListPdf.length ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].prodName!),
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].lotNo!),
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].qty!),
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].weight!),
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].rate!),
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].amount!),
                  ],
                ),
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable(billListPdf.isEmpty ? "" : "Total",),
                  buildTitleForTable(billListPdf.isEmpty ? "" : ""),
                  buildTitleForTable(billListPdf.isEmpty ? "" : billListPdf[0].totQty!),
                  buildTitleForTable(billListPdf.isEmpty ? "" : billListPdf[0].totWeight!),
                  buildTitleForTable(billListPdf.isEmpty ? "" : ""),
                  buildTitleForTable(billListPdf.isEmpty ? "" : billListPdf[0].totAmount.toString()),
                ],
              ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
              border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              children:[
                TableRow(
                  children: [
                    buildTitleForTable("Adat"),
                    buildRowTextForTable(cont.billReportList[0].adat!),
                  ],
                ),
                TableRow(
                  children: [
                    buildTitleForTable("M. Ses"),
                    buildRowTextForTable(cont.billReportList[0].mcess!),
                  ],
                ),
                TableRow(
                  children: [
                    buildTitleForTable("Hamali"),
                    buildRowTextForTable(cont.billReportList[0].custHamali!),
                  ],
                ),
                TableRow(
                  children: [
                    buildTitleForTable("Net Amount"),
                    buildRowTextForTable(cont.billReportList[0].netAmount!),
                  ],
                ),
              ]
          )
        ],
      ));
    }
    else{
      int divideValue = billListPdf.length ~/ 10;
      int modeValue = billListPdf.length % 10;

      if(divideValue<modeValue){
        totalLength = divideValue + 1;
      }

      for(int i = 0; i<totalLength-1; i++ ) {
        startIndex = i == 0 ? 0 : startIndex + 10;
        endIndex = i == 0 ? 10 : endIndex + 10;

        pdf.addPage(MultiPage(
          pageFormat: PdfPageFormat.letter,
          header: (context) =>
          i == 0 ?
          buildHeader(billListPdf[0].billDate!,billListPdf[0].custAccountName!,
              billListPdf[0].firmAddress!, billListPdf[0].mobileNo!,billListPdf[0].billNo!,ttf)
              : Opacity(opacity: 0.0),
          build: (context) => [
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            Table(
              border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable("Product Name"),
                    buildTitleForTable("LOT No"),
                    buildTitleForTable("Quantity"),
                    buildTitleForTable("Weight"),
                    buildTitleForTable("Rate"),
                    buildTitleForTable("Amount"),
                  ],
                ),
                for(int i = startIndex ;i < endIndex ; i++)
                  TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                    children: [
                      buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].prodName!),
                      buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].lotNo!),
                      buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].qty!),
                      buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].weight!),
                      buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].rate!),
                      buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].amount!),
                    ],
                  ),
              ],
            )
          ],
        ));
      }

      if(endIndex<billListPdf.length){
        startIndex = startIndex + 10;
        endIndex = endIndex + modeValue;
      }

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex == 0 ?
        buildHeader(billListPdf[0].billDate!,billListPdf[0].custAccountName!,
            billListPdf[0].firmAddress!, billListPdf[0].mobileNo!,billListPdf[0].billNo!,ttf)
            : Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
            border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable("Product Name"),
                  buildTitleForTable("LOT No"),
                  buildTitleForTable("Quantity"),
                  buildTitleForTable("Weight"),
                  buildTitleForTable("Rate"),
                  buildTitleForTable("Amount"),
                ],
              ),
              for(int i = startIndex ;i < endIndex ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].prodName!),
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].lotNo!),
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].qty!),
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].weight!),
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].rate!),
                    buildRowTextForTable(billListPdf.isEmpty ? "" : billListPdf[i].amount!),
                  ],
                ),
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable(billListPdf.isEmpty ? "" : "Total",),
                  buildTitleForTable(billListPdf.isEmpty ? "" : ""),
                  buildTitleForTable(billListPdf.isEmpty ? "" : billListPdf[0].totQty!),
                  buildTitleForTable(billListPdf.isEmpty ? "" : billListPdf[0].totWeight!),
                  buildTitleForTable(billListPdf.isEmpty ? "" : ""),
                  buildTitleForTable(billListPdf.isEmpty ? "" : billListPdf[0].totAmount.toString()),
                ],
              ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
              border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              children:[
                TableRow(
                  children: [
                    buildTitleForTable("Adat"),
                    buildRowTextForTable(cont.billReportList[0].adat!),
                  ],
                ),
                TableRow(
                  children: [
                    buildTitleForTable("M. Ses"),
                    buildRowTextForTable(cont.billReportList[0].mcess!),
                  ],
                ),
                TableRow(
                  children: [
                    buildTitleForTable("Hamali"),
                    buildRowTextForTable(cont.billReportList[0].custHamali!),
                  ],
                ),
                TableRow(
                  children: [
                    buildTitleForTable("Net Amount"),
                    buildRowTextForTable(cont.billReportList[0].netAmount!),
                  ],
                ),
              ]
          )
        ],
      ));
    }

    return PdfApi.saveDocument(name: 'Bill Report.pdf', pdf: pdf);
  }

  ///pdf header
  static Widget buildHeader(String billDate, String customerName,String firmAddress,
      String mobileNo,String billNo,Font ttf) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
        alignment: Alignment.center,
        child:Text(customerName,style: TextStyle(fontWeight: FontWeight.bold))
      ),
      Align(
        alignment: Alignment.center,
        child:Text(firmAddress, style: TextStyle(fontSize: 13,color: PdfColor.fromHex("#546cb1"),
            font: ttf,fontWeight: FontWeight.bold
        ))
      ),
      Padding(
          padding: const EdgeInsets.only(left: 10.0,top: 10.0),
          child:Row(
            children: [
              Text("Mobile No. : ",style: TextStyle(fontWeight: FontWeight.bold)),Text(mobileNo)
            ]
          )
      ),
      Padding(
          padding: const EdgeInsets.only(left: 10.0,top: 5.0),
          child:Row(
            children: [
              Text("Bill No. : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(billNo), Spacer(),
              Text("Bill Date : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(billDate),
            ]
          )),
      pw.SizedBox(height: 20),
    ],
  );

  ///invoice details
  static Widget buildWeightListDetails(List<WeightListDetails> weightListPdf,Font ttf,int startIndex,int endIndex) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Center(
        child: Text("Weight List (Rough Bill)",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
      ),
      pw.SizedBox(height: 7),
      pw.Divider(color: PdfColor.fromHex("#E0E0E0")),
      pw.SizedBox(height: 10),
      Table(
        border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
        defaultColumnWidth: const IntrinsicColumnWidth(),
        children: [
          TableRow(
            decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
            children: [
              buildTitleForTable("Bill Date"),
              buildTitleForTable("Customer"),
              buildTitleForTable("LOT No"),
              buildTitleForTable("Quantity"),
              buildTitleForTable("Weight"),
              buildTitleForTable("Rate"),
              buildTitleForTable("Supplier"),
            ],
          ),
          for(var data = startIndex; data < endIndex; data++)
            TableRow(
              decoration: BoxDecoration(color: PdfColor.fromHex("#C0C0C0")),
              children: [
                buildRowTextForTable(weightListPdf.isEmpty ? "" : "${weightListPdf[data].billDate}"),
                buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[data].custAccountName}"),
                buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[data].remark}"),
                buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[data].qty}"),
                buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[data].weight}"),
                buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[data].rate}"),
                buildRowTextForTableMarathi(weightListPdf.isEmpty ? "" :"${weightListPdf[data].suppAccountName}",ttf),
              ],
            ),
        ],
      )
    ],
  );

  /// Build widget to design row text for table
  static Widget buildTitleForTable(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0,bottom: 2.0,left: 7,right: 2.0),
      child: Text(title, style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    );
  }

  /// Build widget to design row text for table
  static Widget buildRowTextForTable(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0,right: 5.0,bottom: 5.0,left: 10.0),
      child: Text(title, style: TextStyle(fontSize: 13,color: PdfColor.fromHex("#000000")),textAlign: TextAlign.center,
      ),
    );
  }

  static Widget buildRowTextForTableMarathi(String title, Font ttf) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0,right: 5.0,bottom: 5.0,left: 10.0),
      child: Text(title, style: TextStyle(fontSize: 13,color: PdfColor.fromHex("#546cb1"),
          font: ttf
      ),textAlign: TextAlign.center,
      ),
    );
  }
}
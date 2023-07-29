import 'dart:io';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/common/pdf_api.dart';
import 'package:adat/screens/farmer/farmer_model.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class FarmerPattiExportScreen {

  static int startIndex = 0;
  static int endIndex = 0;
  static int totalLength = 0;

  static Future<File> generate(List<FarmerPattiDetailsList> farmerPattiListPdf,HomeController cont) async {
    final pdf = Document();
    final font = await rootBundle.load("assets/font/Hindi.ttf");
    final ttf = pw.Font.ttf(font);

    if(farmerPattiListPdf.length<=10){
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex == 0 ?
        buildHeader(farmerPattiListPdf[0].pattiDate!,farmerPattiListPdf[0].engFirmName!,
            farmerPattiListPdf[0].firmAddress!, farmerPattiListPdf[0].mobileNo!,farmerPattiListPdf[0].pattiNo!,
            farmerPattiListPdf[0].accountName!,ttf)
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
                  buildTitleForTable("Vakkal"),
                  buildTitleForTable("Daag"),
                  buildTitleForTable("Weight"),
                  buildTitleForTable("Rate"),
                  buildTitleForTable("Total"),
                ],
              ),
              for(int i = 0 ;i < farmerPattiListPdf.length ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].prodName!),
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].vakkal!),
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].qty!),
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].weight!),
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].rate!),
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].amount!),
                  ],
                ),
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : "Total",),
                  buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : ""),
                  buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[0].totQty!),
                  buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[0].totWeight!),
                  buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : ""),
                  buildTitleForTable(""),
                ],
              ),
              TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable(""),
                    buildTitleForTable("Hamali"),
                    buildTitleForTable("Tolai"),
                    buildTitleForTable("Mo. Rent"),
                    buildTitleForTable("Total"),
                    buildTitleForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].totAmount!),
                  ]
              ),
              TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(""),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].hamali!),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].mapai!),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].motorRent!),
                    buildRowTextForTable("Kharch (-)"),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].netExp!),
                  ]
              ),
              TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable("Bharai"),
                    buildTitleForTable("Varai"),
                    buildTitleForTable("Other exp"),
                    buildTitleForTable("Uchal"),
                    buildTitleForTable("Total"),
                    buildTitleForTable(""),
                  ]
              ),
              TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].bharai!),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].varai!),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].other!),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].uchal!),
                    buildRowTextForTable("Total"),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].netAmount!),
                  ]
              ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),

        ],
      ));
    }
    else{
      int divideValue = farmerPattiListPdf.length ~/ 10;
      int modeValue = farmerPattiListPdf.length % 10;

      if(modeValue==0){
        totalLength = divideValue;
      }
      else {
        totalLength = divideValue + 1;
      }

      for(int i = 0; i<totalLength-1; i++ ) {
        startIndex = i == 0 ? 0 : startIndex + 10;
        endIndex = i == 0 ? 10 : endIndex + 10;

        pdf.addPage(MultiPage(
          pageFormat: PdfPageFormat.letter,
          header: (context) =>
          i == 0 ?
          buildHeader(farmerPattiListPdf[0].pattiDate!,farmerPattiListPdf[0].engFirmName!,
              farmerPattiListPdf[0].firmAddress!, farmerPattiListPdf[0].mobileNo!,farmerPattiListPdf[0].pattiNo!,
              farmerPattiListPdf[0].accountName!,ttf)
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
                    buildTitleForTable("Vakkal"),
                    buildTitleForTable("Daag"),
                    buildTitleForTable("Weight"),
                    buildTitleForTable("Rate"),
                    buildTitleForTable("Total"),
                  ],
                ),
                for(int i = startIndex ;i < endIndex ; i++)
                  TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                    children: [
                      buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].prodName!),
                      buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].vakkal!),
                      buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].qty!),
                      buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].weight!),
                      buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].rate!),
                      buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].amount!),
                    ],
                  ),
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : "Total",),
                    buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : ""),
                    buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[0].totQty!),
                    buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[0].totWeight!),
                    buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : ""),
                    buildTitleForTable(""),
                  ],
                ),
                TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                    children: [
                      buildTitleForTable(""),
                      buildTitleForTable("Hamali"),
                      buildTitleForTable("Tolai"),
                      buildTitleForTable("Mo. Rent"),
                      buildTitleForTable("Total"),
                      buildTitleForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].totAmount!),
                    ]
                ),
                TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                    children: [
                      buildRowTextForTable(""),
                      buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].hamali!),
                      buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].mapai!),
                      buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].motorRent!),
                      buildRowTextForTable("Kharch (-)"),
                      buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].netExp!),
                    ]
                ),
                TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                    children: [
                      buildTitleForTable("Bharai"),
                      buildTitleForTable("Varai"),
                      buildTitleForTable("Other exp"),
                      buildTitleForTable("Uchal"),
                      buildTitleForTable("Total"),
                      buildTitleForTable(""),
                    ]
                ),
                TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                    children: [
                      buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].bharai!),
                      buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].varai!),
                      buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].other!),
                      buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].uchal!),
                      buildRowTextForTable("Total"),
                      buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].netAmount!),
                    ]
                ),
              ],
            )
          ],
        ));
      }

      if(endIndex<farmerPattiListPdf.length){
        startIndex = startIndex + 10;
        endIndex = endIndex + modeValue;
      }

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex == 0 ?
        buildHeader(farmerPattiListPdf[0].pattiDate!,farmerPattiListPdf[0].engFirmName!,
            farmerPattiListPdf[0].firmAddress!, farmerPattiListPdf[0].mobileNo!,farmerPattiListPdf[0].pattiNo!,
            farmerPattiListPdf[0].accountName!,ttf)
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
                  buildTitleForTable("Vakkal"),
                  buildTitleForTable("Daag"),
                  buildTitleForTable("Weight"),
                  buildTitleForTable("Rate"),
                  buildTitleForTable("Total"),
                ],
              ),
              for(int i = startIndex ;i < endIndex ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].prodName!),
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].vakkal!),
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].qty!),
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].weight!),
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].rate!),
                    buildRowTextForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[i].amount!),
                  ],
                ),
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : "Total",),
                  buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : ""),
                  buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[0].totQty!),
                  buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : farmerPattiListPdf[0].totWeight!),
                  buildTitleForTable(farmerPattiListPdf.isEmpty ? "" : ""),
                  buildTitleForTable(""),
                ],
              ),
              TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable(""),
                    buildTitleForTable("Hamali"),
                    buildTitleForTable("Tolai"),
                    buildTitleForTable("Mo. Rent"),
                    buildTitleForTable("Total"),
                    buildTitleForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].totAmount!),
                  ]
              ),
              TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(""),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].hamali!),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].mapai!),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].motorRent!),
                    buildRowTextForTable("Kharch (-)"),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].netExp!),
                  ]
              ),
              TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable("Bharai"),
                    buildTitleForTable("Varai"),
                    buildTitleForTable("Other exp"),
                    buildTitleForTable("Uchal"),
                    buildTitleForTable("Total"),
                    buildTitleForTable(""),
                  ]
              ),
              TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].bharai!),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].varai!),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].other!),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].uchal!),
                    buildRowTextForTable("Total"),
                    buildRowTextForTable(cont.farmerPattiList.isEmpty?"":cont.farmerPattiList[0].netAmount!),
                  ]
              ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
        ],
      ));
    }

    return PdfApi.saveDocument(name: 'Farmer Patti Report.pdf', pdf: pdf);
  }

  ///pdf header
  static Widget buildHeader(String billDate, String customerName,String firmAddress,
      String mobileNo,String billNo,String farmerName,Font ttf) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
          alignment: Alignment.center,
          child:Text(customerName,style: TextStyle(fontWeight: FontWeight.bold,font: ttf))
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
                Text("Patti No. : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(billNo), Spacer(),
                Text("Patti Date : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(billDate),
              ]
          )),
      Padding(
          padding: const EdgeInsets.only(left: 10.0,top: 5.0),
          child:Row(
              children: [
                Text("Farmer Name : ",style: TextStyle(fontWeight: FontWeight.bold,)),
                Text(farmerName,style: TextStyle(font: ttf,))
              ]
          )
      ),
      pw.SizedBox(height: 20),
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
import 'dart:io';

import 'package:customrig/model/base_item.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/utils/helpers.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class PdfService {
  Future<String> createPdf(BaseItem rig) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'CustomRig',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#006492'),
                  ),
                ),

                pw.SizedBox(height: 20),

                //
                pw.Text('RIG DETAILS', style: const pw.TextStyle(fontSize: 10)),
                pw.Text(rig.description ?? ''),
                //
                pw.SizedBox(height: 6),

                pw.Text(
                  'Total Price: ' + formatCurrency(rig.price ?? 0),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#006492'),
                  ),
                ),
                //
                pw.SizedBox(height: 10),

                pw.Table(
                  border: pw.TableBorder.all(width: 1),
                  tableWidth: pw.TableWidth.max,
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Paragraph(
                          text: 'ITEM',
                          padding: const pw.EdgeInsets.all(4),
                          margin: const pw.EdgeInsets.all(4),
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Paragraph(
                          text: 'PRICE',
                          padding: const pw.EdgeInsets.all(4),
                          margin: const pw.EdgeInsets.all(4),
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          textAlign: pw.TextAlign.right,
                        ),
                      ],
                    ),
                    if (rig.cabinet != null) _buildTableRow(rig.cabinet),
                    if (rig.processor != null) _buildTableRow(rig.processor),
                    if (rig.motherboard != null)
                      _buildTableRow(rig.motherboard),
                    if (rig.ram != null) _buildTableRow(rig.ram),
                    if (rig.graphicCard != null)
                      _buildTableRow(rig.graphicCard),
                    if (rig.storage != null) _buildTableRow(rig.storage),
                    if (rig.powerSupply != null)
                      _buildTableRow(rig.powerSupply),
                    if (rig.cooler != null) _buildTableRow(rig.cooler),
                    if (rig.wifiAdapter != null)
                      _buildTableRow(rig.wifiAdapter),
                    if (rig.operatingSystem != null)
                      _buildTableRow(rig.operatingSystem),
                  ],
                ),
              ]);
        },
      ),
    );

    final permissionStatus = await Permission.storage.status;

    if (!permissionStatus.isGranted) {
      await Permission.storage.request();
    }

    Directory? directory = await getExternalStorageDirectory();

    final file = File(
      directory!.path + '/custom_rig' + rig.id! + '.pdf',
    );
    final result = await file.writeAsBytes(await pdf.save());

    return result.path;
  }

  pw.TableRow _buildTableRow(Item? item) {
    return pw.TableRow(
      children: [
        pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Paragraph(
                text: item?.category ?? '',
                padding: const pw.EdgeInsets.only(left: 4, top: 4, bottom: 0),
                margin: const pw.EdgeInsets.only(left: 4, top: 4, bottom: 0),
                style: pw.TextStyle(color: PdfColor.fromHex('#006492')),
              ),
              pw.Paragraph(
                text: item?.title ?? '',
                padding: const pw.EdgeInsets.only(left: 4, top: 0, bottom: 4),
                margin: const pw.EdgeInsets.only(left: 4, top: 0, bottom: 4),
              ),
            ]),
        pw.Paragraph(
          text: formatCurrency(item?.price ?? 0),
          textAlign: pw.TextAlign.right,
          padding: const pw.EdgeInsets.all(4),
          margin: const pw.EdgeInsets.all(4),
        ),
      ],
    );
  }
}

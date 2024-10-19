import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../data.dart';


Future<Uint8List> generateLOTOdraft(PdfPageFormat format, CustomData data) async {
  final pdf = pw.Document(title: 'LOTO Draft');

  // Load SVG as a string from assets
  final String svgHeader = await rootBundle.loadString('assets/loto-header-bars.svg');

  pdf.addPage(
    pw.MultiPage(
      pageFormat: format,  // Use the format passed to the function
      margin: pw.EdgeInsets.all(32),
      header: (pw.Context context) {
        return pw.Container(
          alignment: pw.Alignment.center,
          child: pw.SvgImage(
            svg: svgHeader,  // Use the loaded SVG string
            fit: pw.BoxFit.contain,
            width: double.infinity,
            height: 100,  // Adjust the height as needed
          ),
        );
      },
      build: (pw.Context context) {
        return <pw.Widget>[
          // Your page content goes here
          pw.Text('BLABLABLALBLA'), // Example of using CustomData
        ];
      },
    ),
  );

  // Return the generated PDF as bytes
  return pdf.save();
}
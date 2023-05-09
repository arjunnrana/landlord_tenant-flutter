import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer_null_safe/full_pdf_viewer_scaffold.dart';

class PdfViewer extends StatelessWidget {
  PdfViewer({required this.file, this.invoiceNo});
  String? invoiceNo;
  final File file;

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: const Text('Invoice'),
        ),
        path: file.path);
  }
}

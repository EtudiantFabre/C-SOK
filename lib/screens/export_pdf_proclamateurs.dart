import 'package:c_sok/models/model.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// ignore: must_be_immutable
class PdfPreviewProclamateur extends StatefulWidget {
  String? text;
  PdfPreviewProclamateur(this.text, {Key? key}) : super(key: key);

  @override
  State<PdfPreviewProclamateur> createState() => _PdfPreviewProclamateurState();
}

class _PdfPreviewProclamateurState extends State<PdfPreviewProclamateur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prévisualisation"),
      ),
      body: PdfPreview(
        build: (format) => makePdf(),
      ),
    );
  }

  @override
  void initState() {
    getProclamateurs();
    super.initState();
  }

  List<ProclamateurModel> mesprocs = [];

  pw.Widget PaddedText(final String text,
          {final pw.TextAlign align = pw.TextAlign.left}) =>
      pw.Padding(
        padding: const pw.EdgeInsets.all(10),
        child: pw.Text(
          text,
          textAlign: align,
        ),
      );

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('lib/assets/img1.jpg');
    final Uint8List byteList = bytes.buffer.asUint8List();
    debugPrint('Vraiment');
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Header(
                    text: "Liste des proclamateurs",
                    level: 1,
                  ),
                  pw.Image(
                    pw.MemoryImage(byteList),
                    fit: pw.BoxFit.fitHeight,
                    height: 100,
                    width: 100,
                  )
                ],
              ),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.Paragraph(text: widget.text),
              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColors.black,
                ),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          'NOM',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          'PRENOM',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ...mesprocs.map(
                    (p) => pw.TableRow(
                      children: [
                        pw.Expanded(
                          child: PaddedText(
                            p.nom,
                          ),
                          flex: 2,
                        ),
                        pw.Expanded(
                          child: PaddedText(
                            p.prenom,
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  void getProclamateurs() async {
    await DatabaseRepository.instance.getAllProc().then((value) {
      setState(() {
        mesprocs = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }
}

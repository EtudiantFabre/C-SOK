import 'package:c_sok/models/model.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// ignore: must_be_immutable
class PdfPreviewPage extends StatefulWidget {
  String? text;
  PdfPreviewPage(this.text, {Key? key}) : super(key: key);

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
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
    getGroupes();
    super.initState();
  }

  List<GroupeModel> mesgroupes = [];

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
                    text: "Liste des groupes",
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
                          'Nom',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          'Lieu',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ...mesgroupes.map(
                    (e) => pw.TableRow(
                      children: [
                        pw.Expanded(
                          child: PaddedText(
                            e.nom_gpe,
                          ),
                          flex: 2,
                        ),
                        pw.Expanded(
                          child: PaddedText(
                            e.lieu,
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

  void getGroupes() async {
    await DatabaseRepository.instance.getAllGroupes().then((value) {
      setState(() {
        mesgroupes = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }
}

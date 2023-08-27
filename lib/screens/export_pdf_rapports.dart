import 'package:c_sok/constante.dart';
import 'package:c_sok/models/model.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// ignore: must_be_immutable
class PdfPreviewRapport extends StatefulWidget {
  String? text;
  PdfPreviewRapport(this.text, {Key? key}) : super(key: key);

  @override
  State<PdfPreviewRapport> createState() => _PdfPreviewRapportState();
}

class _PdfPreviewRapportState extends State<PdfPreviewRapport> {
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
    getRapports();
    getGroupes();
    super.initState();
  }

  List<ProclamateurModel> mesprocs = [];
  List<GroupeModel> mesgroupes = [];
  List<RapportModel> mesrapport = [];
  ProclamateurModel? proclamateur;

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
    final ByteData bytes = await rootBundle.load('lib/assets/img7.jpg');
    final Uint8List byteList = bytes.buffer.asUint8List();
    debugPrint(mesrapport.toString());
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
                    text: "Liste des Fiches de Rapports",
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
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          'NOM & PRENOM',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          'PUBLIC',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          'VIDÉOS',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          'HEURES',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          'N. VIS',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          'C. BIBL',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ...mesrapport.map(
                    (r) {
                      getProclamateurById(r.proclamateur);
                      //debugPrint(proclamateur.toString());
                      return pw.TableRow(
                        children: [
                          pw.Expanded(
                            child: PaddedText(
                              capitalizeFirstLetter(
                                  "${proclamateur?.nom ?? ''} ${proclamateur?.prenom ?? ''}"),
                            ),
                          ),
                          pw.Expanded(
                            child: PaddedText(
                              r.publ,
                            ),
                          ),
                          pw.Expanded(
                            child: PaddedText(
                              r.videos,
                            ),
                          ),
                          pw.Expanded(
                            child: PaddedText(
                              r.nbre_heure,
                            ),
                          ),
                          pw.Expanded(
                            child: PaddedText(
                              r.nvle_visite,
                            ),
                          ),
                          pw.Expanded(
                            child: PaddedText(
                              r.cours_bibl,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        color: PdfColors.grey600,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(
                            'TOTAUX PROCL',
                            style: pw.Theme.of(context).header4,
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        color: PdfColors.grey600,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(
                            'TOTAUX PP',
                            style: pw.Theme.of(context).header4,
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        color: PdfColors.grey600,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(
                            'TOTAUX PA',
                            style: pw.Theme.of(context).header4,
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          '0',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  ),
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

  void getGroupes() async {
    await DatabaseRepository.instance.getAllGroupes().then((value) {
      setState(() {
        mesgroupes = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }

  void getRapports() async {
    await DatabaseRepository.instance.getAllRapports().then((value) {
      setState(() {
        mesrapport = value;
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => debugPrint(e.toString()));
  }

  void getProclamateurById(int id) async {
    await DatabaseRepository.instance.getProcById(id).then((value) {
      setState(() {
        proclamateur = value;
      });
    });
  }
}

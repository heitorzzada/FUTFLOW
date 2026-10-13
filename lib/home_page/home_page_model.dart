import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  // State field(s) for E-mail widget.
  FocusNode? eMailFocusNode;
  TextEditingController? eMailTextController;
  String? Function(BuildContext, String?)? eMailTextControllerValidator;
  // State field(s) for Senha widget.
  FocusNode? senhaFocusNode;
  TextEditingController? senhaTextController;
  late bool senhaVisibility;
  String? Function(BuildContext, String?)? senhaTextControllerValidator;
  // State field(s) for SenhaR widget.
  FocusNode? senhaRFocusNode;
  TextEditingController? senhaRTextController;
  late bool senhaRVisibility;
  String? Function(BuildContext, String?)? senhaRTextControllerValidator;

  @override
  void initState(BuildContext context) {
    senhaVisibility = false;
    senhaRVisibility = false;
  }

  @override
  void dispose() {
    nomeFocusNode?.dispose();
    nomeTextController?.dispose();

    eMailFocusNode?.dispose();
    eMailTextController?.dispose();

    senhaFocusNode?.dispose();
    senhaTextController?.dispose();

    senhaRFocusNode?.dispose();
    senhaRTextController?.dispose();
  }
}

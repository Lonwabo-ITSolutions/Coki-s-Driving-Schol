import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddQuizCopyModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  bool optionA = false;

  bool optionB = false;

  bool optionC = false;

  bool optionD = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for WriteAQuestion widget.
  TextEditingController? writeAQuestionController;
  String? Function(BuildContext, String?)? writeAQuestionControllerValidator;
  // State field(s) for Option_A widget.
  TextEditingController? optionAController;
  String? Function(BuildContext, String?)? optionAControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Option_B widget.
  TextEditingController? optionBController;
  String? Function(BuildContext, String?)? optionBControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for Option_C widget.
  TextEditingController? optionCController;
  String? Function(BuildContext, String?)? optionCControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue3;
  // State field(s) for Option_D widget.
  TextEditingController? optionDController;
  String? Function(BuildContext, String?)? optionDControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue4;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  QuizRecord? quizCreateResponse;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    writeAQuestionController?.dispose();
    optionAController?.dispose();
    optionBController?.dispose();
    optionCController?.dispose();
    optionDController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

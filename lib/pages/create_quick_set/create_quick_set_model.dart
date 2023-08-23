import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateQuickSetModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for quizTitle widget.
  TextEditingController? quizTitleController;
  String? Function(BuildContext, String?)? quizTitleControllerValidator;
  // State field(s) for quizDescription widget.
  TextEditingController? quizDescriptionController;
  String? Function(BuildContext, String?)? quizDescriptionControllerValidator;
  // State field(s) for quizTotalQuestion widget.
  TextEditingController? quizTotalQuestionController;
  String? Function(BuildContext, String?)? quizTotalQuestionControllerValidator;
  // State field(s) for quizDuration widget.
  TextEditingController? quizDurationController;
  String? Function(BuildContext, String?)? quizDurationControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    quizTitleController?.dispose();
    quizDescriptionController?.dispose();
    quizTotalQuestionController?.dispose();
    quizDurationController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

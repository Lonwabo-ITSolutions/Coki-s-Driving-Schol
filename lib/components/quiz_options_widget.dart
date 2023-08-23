import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'quiz_options_model.dart';
export 'quiz_options_model.dart';

class QuizOptionsWidget extends StatefulWidget {
  const QuizOptionsWidget({
    Key? key,
    required this.questionNo,
    required this.questionName,
    required this.istrue,
  }) : super(key: key);

  final String? questionNo;
  final String? questionName;
  final bool? istrue;

  @override
  _QuizOptionsWidgetState createState() => _QuizOptionsWidgetState();
}

class _QuizOptionsWidgetState extends State<QuizOptionsWidget> {
  late QuizOptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizOptionsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('QUIZ_OPTIONS_Container_r3xcfwmj_ON_TAP');
        if (widget.istrue!) {
          if (_model.isAnswered != null) {
            logFirebaseEvent('Container_update_widget_state');
            setState(() {
              _model.isAnswered = null;
            });
            logFirebaseEvent('Container_update_app_state');
            setState(() {
              FFAppState().completedQuiz = FFAppState().completedQuiz + -1;
            });
            logFirebaseEvent('Container_update_app_state');
            setState(() {
              FFAppState().score = FFAppState().score + -1;
            });
          } else {
            logFirebaseEvent('Container_update_widget_state');
            setState(() {
              _model.isAnswered = true;
            });
            logFirebaseEvent('Container_update_app_state');
            setState(() {
              FFAppState().completedQuiz = FFAppState().completedQuiz + 1;
            });
            logFirebaseEvent('Container_update_app_state');
            setState(() {
              FFAppState().score = FFAppState().score + 1;
            });
          }
        } else {
          if (_model.isAnswered != null) {
            logFirebaseEvent('Container_update_widget_state');
            setState(() {
              _model.isAnswered = true;
            });
            logFirebaseEvent('Container_update_app_state');
            setState(() {
              FFAppState().completedQuiz = FFAppState().completedQuiz + -1;
            });
            logFirebaseEvent('Container_update_app_state');
            setState(() {
              FFAppState().score = FFAppState().score + -1;
            });
          } else {
            logFirebaseEvent('Container_update_widget_state');
            setState(() {
              _model.isAnswered = false;
            });
            logFirebaseEvent('Container_update_app_state');
            setState(() {
              FFAppState().completedQuiz = FFAppState().completedQuiz + 1;
            });
            logFirebaseEvent('Container_update_app_state');
            setState(() {
              FFAppState().score = FFAppState().score + 1;
            });
          }
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              () {
                if (_model.isAnswered == true) {
                  return Color(0xA9FF5963);
                } else if (_model.isAnswered == false) {
                  return Color(0x716BEE1E);
                } else {
                  return Colors.transparent;
                }
              }(),
              FlutterFlowTheme.of(context).secondaryBackground,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: valueOrDefault<Color>(
                () {
                  if (_model.isAnswered == true) {
                    return Color(0xFFFF5963);
                  } else if (_model.isAnswered == false) {
                    return Color(0xD06BEE1E);
                  } else {
                    return Colors.white;
                  }
                }(),
                FlutterFlowTheme.of(context).secondaryBackground,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 24.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      () {
                        if (_model.isAnswered == true) {
                          return Color(0xFFFF5963);
                        } else if (_model.isAnswered == false) {
                          return Color(0xD06BEE1E);
                        } else {
                          return Colors.transparent;
                        }
                      }(),
                      FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: valueOrDefault<Color>(
                        () {
                          if (_model.isAnswered == true) {
                            return FlutterFlowTheme.of(context).warning;
                          } else if (_model.isAnswered == false) {
                            return FlutterFlowTheme.of(context).primaryText;
                          } else {
                            return Color(0x00000000);
                          }
                        }(),
                        FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      widget.questionNo!,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 15.0,
                          ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: AutoSizeText(
                      widget.questionName!,
                      textAlign: TextAlign.start,
                      maxLines: 6,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Colors.black,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

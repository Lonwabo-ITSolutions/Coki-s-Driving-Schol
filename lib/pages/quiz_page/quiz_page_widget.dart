import '/backend/backend.dart';
import '/components/quiz_options_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'quiz_page_model.dart';
export 'quiz_page_model.dart';

class QuizPageWidget extends StatefulWidget {
  const QuizPageWidget({
    Key? key,
    required this.quizSetRef,
    required this.quizDuration,
    int? pageNavigate,
  })  : this.pageNavigate = pageNavigate ?? 0,
        super(key: key);

  final DocumentReference? quizSetRef;
  final int? quizDuration;
  final int pageNavigate;

  @override
  _QuizPageWidgetState createState() => _QuizPageWidgetState();
}

class _QuizPageWidgetState extends State<QuizPageWidget> {
  late QuizPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'QuizPage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('QUIZ_PAGE_PAGE_QuizPage_ON_INIT_STATE');
      logFirebaseEvent('QuizPage_start_periodic_action');
      _model.instantTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 1000),
        callback: (timer) async {
          logFirebaseEvent('QuizPage_timer');
          _model.timerController.onExecute.add(StopWatchExecute.start);
        },
        startImmediately: true,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<int>(
      future: queryQuizRecordCount(
        queryBuilder: (quizRecord) =>
            quizRecord.where('quiz_set', isEqualTo: widget.quizSetRef),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitRipple(
                  color: FlutterFlowTheme.of(context).warning,
                  size: 50.0,
                ),
              ),
            ),
          );
        }
        int quizPageCount = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primary,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(25.0, 55.0, 25.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 1.0, 0.0),
                        child: Container(
                          height: 30.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                FlutterFlowTheme.of(context).primary,
                                FlutterFlowTheme.of(context).secondary
                              ],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 2.0, 0.0),
                                  child: Icon(
                                    Icons.timelapse,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBtnText,
                                    size: 24.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 0.0, 0.0, 0.0),
                                  child: FlutterFlowTimer(
                                    initialTime: widget.quizDuration!,
                                    getDisplayTime: (value) =>
                                        StopWatchTimer.getDisplayTime(
                                      value,
                                      hours: false,
                                      milliSecond: false,
                                    ),
                                    timer: _model.timerController,
                                    updateStateInterval:
                                        Duration(milliseconds: 1000),
                                    onChanged:
                                        (value, displayTime, shouldUpdate) {
                                      _model.timerMilliseconds = value;
                                      _model.timerValue = displayTime;
                                      if (shouldUpdate) setState(() {});
                                    },
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily: 'Roboto Mono',
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 15.0, 30.0, 5.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Q ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              TextSpan(
                                text: valueOrDefault<String>(
                                  (_model.pageNavigate + 1).toString(),
                                  '0',
                                ),
                                style: TextStyle(),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'QUIZ_PAGE_PAGE_Icon_bymzq8qs_ON_TAP');
                              logFirebaseEvent('Icon_send_email');
                              await launchUrl(Uri(
                                  scheme: 'mailto',
                                  path: 'Lonwabomchumanimbunyuza@gmail.com',
                                  query: {
                                    'subject': 'Coki\'s Quiz App Query',
                                  }
                                      .entries
                                      .map((MapEntry<String, String> e) =>
                                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                      .join('&')));
                            },
                            child: Icon(
                              Icons.help_outline,
                              color: FlutterFlowTheme.of(context).warning,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 0.0),
                    child: Container(
                      width: 485.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primary,
                            FlutterFlowTheme.of(context).secondary
                          ],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(0.0, -1.0),
                          end: AlignmentDirectional(0, 1.0),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          StreamBuilder<List<QuizRecord>>(
                            stream: queryQuizRecord(
                              queryBuilder: (quizRecord) => quizRecord.where(
                                  'quiz_set',
                                  isEqualTo: widget.quizSetRef),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: SpinKitRipple(
                                      color:
                                          FlutterFlowTheme.of(context).warning,
                                      size: 50.0,
                                    ),
                                  ),
                                );
                              }
                              List<QuizRecord> pageViewQuizRecordList =
                                  snapshot.data!;
                              return Container(
                                width: double.infinity,
                                height: 588.0,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 40.0),
                                      child: PageView.builder(
                                        controller:
                                            _model.pageViewController ??=
                                                PageController(
                                                    initialPage: min(
                                                        0,
                                                        pageViewQuizRecordList
                                                                .length -
                                                            1)),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            pageViewQuizRecordList.length,
                                        itemBuilder: (context, pageViewIndex) {
                                          final pageViewQuizRecord =
                                              pageViewQuizRecordList[
                                                  pageViewIndex];
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 0.0, 5.0),
                                                child: LinearPercentIndicator(
                                                  percent:
                                                      valueOrDefault<double>(
                                                    FFAppState().completedQuiz /
                                                        quizPageCount,
                                                    0.0,
                                                  ),
                                                  width: 100.0,
                                                  lineHeight: 9.0,
                                                  animation: true,
                                                  progressColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tertiary,
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .accent4,
                                                  barRadius:
                                                      Radius.circular(0.0),
                                                  padding: EdgeInsets.zero,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        25.0, 24.0, 15.0, 24.0),
                                                child: Text(
                                                  pageViewQuizRecord.question,
                                                  textAlign: TextAlign.justify,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        25.0, 20.0, 25.0, 0.0),
                                                child: ListView(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              QuestionARecord>>(
                                                        stream:
                                                            queryQuestionARecord(
                                                          parent:
                                                              pageViewQuizRecord
                                                                  .reference,
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitRipple(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .warning,
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<QuestionARecord>
                                                              quizOptionsQuestionARecordList =
                                                              snapshot.data!;
                                                          // Return an empty Container when the item does not exist.
                                                          if (snapshot
                                                              .data!.isEmpty) {
                                                            return Container();
                                                          }
                                                          final quizOptionsQuestionARecord =
                                                              quizOptionsQuestionARecordList
                                                                      .isNotEmpty
                                                                  ? quizOptionsQuestionARecordList
                                                                      .first
                                                                  : null;
                                                          return QuizOptionsWidget(
                                                            key: Key(
                                                                'Keyjc0_${pageViewIndex}_of_${pageViewQuizRecordList.length}'),
                                                            questionNo: 'A',
                                                            questionName:
                                                                quizOptionsQuestionARecord!
                                                                    .question,
                                                            istrue:
                                                                quizOptionsQuestionARecord!
                                                                    .isTrue,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  9.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              QuestionBRecord>>(
                                                        stream:
                                                            queryQuestionBRecord(
                                                          parent:
                                                              pageViewQuizRecord
                                                                  .reference,
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitRipple(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .warning,
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<QuestionBRecord>
                                                              quizOptionsQuestionBRecordList =
                                                              snapshot.data!;
                                                          // Return an empty Container when the item does not exist.
                                                          if (snapshot
                                                              .data!.isEmpty) {
                                                            return Container();
                                                          }
                                                          final quizOptionsQuestionBRecord =
                                                              quizOptionsQuestionBRecordList
                                                                      .isNotEmpty
                                                                  ? quizOptionsQuestionBRecordList
                                                                      .first
                                                                  : null;
                                                          return QuizOptionsWidget(
                                                            key: Key(
                                                                'Key2zm_${pageViewIndex}_of_${pageViewQuizRecordList.length}'),
                                                            questionNo: 'B',
                                                            questionName:
                                                                quizOptionsQuestionBRecord!
                                                                    .question,
                                                            istrue:
                                                                quizOptionsQuestionBRecord!
                                                                    .isTrue,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  9.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              QuestionCRecord>>(
                                                        stream:
                                                            queryQuestionCRecord(
                                                          parent:
                                                              pageViewQuizRecord
                                                                  .reference,
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitRipple(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .warning,
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<QuestionCRecord>
                                                              quizOptionsQuestionCRecordList =
                                                              snapshot.data!;
                                                          // Return an empty Container when the item does not exist.
                                                          if (snapshot
                                                              .data!.isEmpty) {
                                                            return Container();
                                                          }
                                                          final quizOptionsQuestionCRecord =
                                                              quizOptionsQuestionCRecordList
                                                                      .isNotEmpty
                                                                  ? quizOptionsQuestionCRecordList
                                                                      .first
                                                                  : null;
                                                          return QuizOptionsWidget(
                                                            key: Key(
                                                                'Keycr8_${pageViewIndex}_of_${pageViewQuizRecordList.length}'),
                                                            questionNo: 'C',
                                                            questionName:
                                                                quizOptionsQuestionCRecord!
                                                                    .question,
                                                            istrue:
                                                                quizOptionsQuestionCRecord!
                                                                    .isTrue,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  9.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              QuestionDRecord>>(
                                                        stream:
                                                            queryQuestionDRecord(
                                                          parent:
                                                              pageViewQuizRecord
                                                                  .reference,
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitRipple(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .warning,
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<QuestionDRecord>
                                                              quizOptionsQuestionDRecordList =
                                                              snapshot.data!;
                                                          // Return an empty Container when the item does not exist.
                                                          if (snapshot
                                                              .data!.isEmpty) {
                                                            return Container();
                                                          }
                                                          final quizOptionsQuestionDRecord =
                                                              quizOptionsQuestionDRecordList
                                                                      .isNotEmpty
                                                                  ? quizOptionsQuestionDRecordList
                                                                      .first
                                                                  : null;
                                                          return QuizOptionsWidget(
                                                            key: Key(
                                                                'Keyeiy_${pageViewIndex}_of_${pageViewQuizRecordList.length}'),
                                                            questionNo: 'D',
                                                            questionName:
                                                                quizOptionsQuestionDRecord!
                                                                    .question,
                                                            istrue:
                                                                quizOptionsQuestionDRecord!
                                                                    .isTrue,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 0.0, 16.0),
                                        child: smooth_page_indicator
                                            .SmoothPageIndicator(
                                          controller:
                                              _model.pageViewController ??=
                                                  PageController(
                                                      initialPage: min(
                                                          0,
                                                          pageViewQuizRecordList
                                                                  .length -
                                                              1)),
                                          count: pageViewQuizRecordList.length,
                                          axisDirection: Axis.horizontal,
                                          onDotClicked: (i) async {
                                            await _model.pageViewController!
                                                .animateToPage(
                                              i,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          effect: smooth_page_indicator
                                              .ExpandingDotsEffect(
                                            expansionFactor: 4.0,
                                            spacing: 5.0,
                                            radius: 20.0,
                                            dotWidth: 10.0,
                                            dotHeight: 8.0,
                                            dotColor:
                                                FlutterFlowTheme.of(context)
                                                    .tertiary,
                                            activeDotColor:
                                                FlutterFlowTheme.of(context)
                                                    .warning,
                                            paintStyle: PaintingStyle.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 0.0, 25.0, 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (FFAppState().completedQuiz > 0)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 7.0, 10.0),
                                    child: FlutterFlowIconButton(
                                      borderRadius: 20.0,
                                      borderWidth: 1.0,
                                      buttonSize: 50.0,
                                      fillColor: Color(0x8B4B39EF),
                                      icon: Icon(
                                        Icons.chevron_left_outlined,
                                        color: Colors.black,
                                        size: 24.0,
                                      ),
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'QUIZ_chevron_left_outlined_ICN_ON_TAP');
                                        logFirebaseEvent(
                                            'IconButton_page_view');
                                        await _model.pageViewController
                                            ?.previousPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                        );
                                        logFirebaseEvent(
                                            'IconButton_update_widget_state');
                                        setState(() {
                                          _model.pageNavigate =
                                              _model.pageNavigate + -1;
                                        });
                                      },
                                    ),
                                  ),
                                if ((FFAppState().completedQuiz >= 0) &&
                                    (FFAppState().completedQuiz <
                                        quizPageCount))
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          7.0, 0.0, 7.0, 10.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'QUIZ_PAGE_PAGE_NEXT_BTN_ON_TAP');
                                          logFirebaseEvent('Button_page_view');
                                          await _model.pageViewController
                                              ?.nextPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.ease,
                                          );
                                          if (quizPageCount !=
                                              _model.pageNavigate) {
                                            logFirebaseEvent(
                                                'Button_update_widget_state');
                                            setState(() {
                                              _model.pageNavigate =
                                                  _model.pageNavigate + 1;
                                            });
                                          }
                                        },
                                        text: 'Next',
                                        options: FFButtonOptions(
                                          height: 45.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium,
                                          elevation: 3.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(12.0),
                                            topLeft: Radius.circular(12.0),
                                            topRight: Radius.circular(0.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (FFAppState().completedQuiz == quizPageCount)
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          7.0, 0.0, 7.0, 10.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'QUIZ_PAGE_PAGE_COMPLETED_BTN_ON_TAP');
                                          logFirebaseEvent(
                                              'Button_navigate_to');

                                          context.goNamed(
                                            'QuizScorePage',
                                            queryParameters: {
                                              'scoreAchieved': serializeParam(
                                                FFAppState().score,
                                                ParamType.int,
                                              ),
                                              'totalQuestions': serializeParam(
                                                quizPageCount,
                                                ParamType.int,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType
                                                        .rightToLeft,
                                              ),
                                            },
                                          );

                                          logFirebaseEvent(
                                              'Button_update_app_state');
                                          FFAppState().update(() {
                                            FFAppState().completedQuiz = 0;
                                          });
                                        },
                                        text: 'Completed',
                                        options: FFButtonOptions(
                                          height: 45.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium,
                                          elevation: 3.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(12.0),
                                            topLeft: Radius.circular(12.0),
                                            topRight: Radius.circular(0.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

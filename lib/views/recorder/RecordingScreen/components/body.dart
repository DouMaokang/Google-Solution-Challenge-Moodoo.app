import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:solution_challenge_2021/models/record.dart';
import 'package:solution_challenge_2021/repositories/record_dao.dart';
import 'package:solution_challenge_2021/views/components/rounded_button.dart';
import 'package:solution_challenge_2021/views/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum RecordPlayState {
  idle,
  recording,
  paused,
  completed,
  play,
  playing,
}

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  RecordPlayState _state = RecordPlayState.idle;  // TODO: set state accordingly

  FlutterSoundRecorder soundRecorder = FlutterSoundRecorder();
  FlutterSoundPlayer soundPlayer = FlutterSoundPlayer();

  CountDownController _countdownController = CountDownController();

  var _sessionId = 1; // TODO: get session id
  var _path = "";

  /// The max length of audio duration in seconds
  var _maxDuration = 59;

  int _messageIndex = 0;
  var _message = ["What makes you happy today", "I am here to hear about it", "Don't worry about anything", "It's okay to pause"];
  Timer _every20s;

  @override
  void initState() {
    super.initState();
    init();
    _startRecorder();

    _every20s = Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (_messageIndex < _message.length - 1) {
        setState(() {
          _messageIndex += 1;
        });
      }
    });
  }

  Future<void> init() async {
    soundRecorder.openAudioSession(
        focus: AudioFocus.requestFocusTransient,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
  }

  @override
  void dispose() {
    super.dispose();
    _releaseRecorderAndPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularCountDownTimer(
              // Countdown duration in Seconds.
              duration: _maxDuration,

              // Countdown initial elapsed Duration in Seconds.
              initialDuration: 0,

              // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
              controller: _countdownController,

              // Width of the Countdown Widget.
              width: MediaQuery.of(context).size.width / 2,

              // Height of the Countdown Widget.
              height: MediaQuery.of(context).size.height / 2,

              // Ring Color for Countdown Widget.
              ringColor: Colors.white.withOpacity(0.3),

              // Ring Gradient for Countdown Widget.
              ringGradient: null,

              // Filling Color for Countdown Widget.
              fillColor: Colors.white,

              // Filling Gradient for Countdown Widget.
              fillGradient: null,

              // Background Color for Countdown Widget.
              backgroundColor: Color(0xff2D8DD7),

              // Background Gradient for Countdown Widget.
              backgroundGradient: null,

              // Border Thickness of the Countdown Ring.
              strokeWidth: 20.0,

              // Begin and end contours with a flat edge and no extension.
              strokeCap: StrokeCap.round,

              // Text Style for Countdown Text.
              textStyle: TextStyle(
                  fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),

              // Format for the Countdown Text.
              textFormat: CountdownTextFormat.MM_SS,

              // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
              isReverse: false,

              // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
              isReverseAnimation: false,

              // Handles visibility of the Countdown Text.
              isTimerTextShown: true,

              // Handles the timer start.
              autoStart: false,

              // This Callback will execute when the Countdown Starts.
              onStart: () {
                // Here, do whatever you want
              },
              // This Callback will execute when the Countdown Ends.
              onComplete: () {
                // Here, do whatever you want
              },
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(32, 0, 32, 64),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _displayedMessage(_message[_messageIndex]),
                    )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
                  child: _actionShow(context),
                )
              ],
            ),
          ),


        ],
      ),
    );
  }

  Widget _displayedMessage(message) {
    return Text(message, key: ValueKey<int>(_messageIndex), style: TextStyle(fontSize: 24, color: Colors.white), textAlign: TextAlign.center,);
  }

  Widget _actionShow(context) {
    switch(_state) {

      case RecordPlayState.recording:
        return Ink(
          decoration: const ShapeDecoration(
            color: kPrimaryColor,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.pause),
            iconSize: 28,
            color: Colors.white,
            onPressed: () {
              _pauseRecorder();
              showModalBottomSheet(
                  backgroundColor: Colors.white.withOpacity(0.6),
                  isScrollControlled: true,
                  enableDrag: false,
                  isDismissible: false,
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      margin: EdgeInsets.all(16),
//                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/group-chat.svg",
                                height: 200,
                              ),
                            ),
                          ),
                          Center(
                            child: RoundedButton(
                                text: "Quit",
                                press: () {Navigator.pop(context);}
                            ),
                          ),

                          Center(
                            child: RoundedButton(
                                text: "Save",
                                press: () {
                                  Navigator.pop(context);
                                  _saveRecording();
                                }
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              );
            },
          ),
        );

      case RecordPlayState.paused:
      case RecordPlayState.idle:
        return Ink(
          decoration: const ShapeDecoration(
            color: kPrimaryColor,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.play_arrow),
            iconSize: 28,
            color: Colors.white,
            onPressed: () {
              _resumeRecorder();
            },
          ),
        );
    }
  }

  /// 开始录音
  _startRecorder() async {
    try {
      // Request microphone permission
      await Permission.microphone.request();
      PermissionStatus status = await Permission.microphone.status;
      print(await Permission.microphone.status);

      print(await Permission.microphone.request().isGranted);

      if (!status.isGranted) {
        throw RecordingPermissionException("Microphone access denied!");
      } else {
        // Start countdown timer
        _countdownController.start();
      }
      // Create directory for storing audio files
      Directory fileDirectory = await getApplicationDocumentsDirectory(); // TODO: use this in production. Only visible to the app
      var time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      String path =
          '${fileDirectory.path}/${soundRecorder.hashCode}-$time${ext[Codec.pcm16.index]}'; // TODO: change file format

      // Start recording
      await soundRecorder.startRecorder(toFile: path,);

      this.setState(() {
        _state = RecordPlayState.recording;
        _path = path;
      });
    } catch (err) {
      print(err);
      setState(() {
        _stopRecorder();
        _state = RecordPlayState.idle;
      });
    }
  }

  /// Pause recording
  _pauseRecorder() async {
    // TODO: implementation
    await soundRecorder.pauseRecorder();
    _countdownController.pause();
    setState(() {
      _state = RecordPlayState.paused;
    });
  }

  /// Resume recording
  _resumeRecorder() async {
    // TODO: implementation
    await soundRecorder.resumeRecorder();
    _countdownController.resume();
    setState(() {
      _state = RecordPlayState.recording;
    });
  }

  /// Stop recording
  _stopRecorder() async {
    try {
      // Stop countdown timer
      _countdownController.pause();
      await soundRecorder.stopRecorder();

    } catch (err) {
      // TODO: catch error
      print('stopRecorder error: $err');
    }
    setState(() {
      _state = RecordPlayState.completed;
    });
  }

  /// Release recorder
  Future<void> _releaseRecorderAndPlayer() async {
    try {
      await soundRecorder.closeAudioSession();
    } catch (e) {
      // TODO: catch error
      print('Released unsuccessful');
      print(e);
    }
  }

  Future<void> _saveRecording() async {
    Record record = new Record(sessionId: _sessionId, filePath: "sdfsdpath");
    var recordId = await RecordDAO.recordDAO.addRecord(record);
    record.id = recordId;
    print(await RecordDAO.recordDAO.getAllRecord());
    var score = await _uploadFile();
    record.score = score;
    await RecordDAO.recordDAO.updateRecordScore(record);
    print(await RecordDAO.recordDAO.getAllRecord());
  }

  Future<double> _uploadFile() async {
    File file = File('$_path');
    var data = await file.readAsBytes();

    List<num> data16 = data.buffer.asInt16List();
    List<double> input = data16.map((i) => i.toDouble()).toList();
    print(input);

    var url = Uri.parse('https://arboreal-cat-308207.et.r.appspot.com/v1/ai/predict');
    var header = {"Content-Type": "application/json"};
    var body = jsonEncode(<String, List>{"pcm": input});

    var response = await http.post(url, headers: header, body: body);
    // Update database
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse["phq8_score"];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Trying again');
      return await _uploadFile();
    }
  }

}




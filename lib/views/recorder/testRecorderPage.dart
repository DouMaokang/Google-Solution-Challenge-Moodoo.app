import 'dart:async';
import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:solution_challenge_2021/views/constants.dart';

enum RecordPlayState {
  idle,
  recording,
  paused,
  completed,
  play,
  playing,
}

class RecorderPage extends StatefulWidget {
  RecorderPage({Key key}) : super(key: key);

  @override
  _RecorderPageState createState() => _RecorderPageState();
}

class _RecorderPageState extends State<RecorderPage> {
  RecordPlayState _state = RecordPlayState.idle;  // TODO: set state accordingly

  StreamSubscription _recorderSubscription;

  String _recorderTxt = '00:00:00';

  double _dbLevel = 0.0;
  FlutterSoundRecorder soundRecorder = FlutterSoundRecorder();
  FlutterSoundPlayer soundPlayer = FlutterSoundPlayer();

  CountDownController _countdownController = CountDownController();

  var _path = "";
  var _duration = 0.0;

  /// The max length of audio duration in seconds
  var _maxDuration = 59;

  @override
  void initState() {
    super.initState();
    init();
    _startRecorder();
  }

  Future<void> _initializeExample(bool withUI) async {
    await soundPlayer.closeAudioSession();

    await soundPlayer.openAudioSession(
        focus: AudioFocus.requestFocusTransient,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);

    await soundPlayer.setSubscriptionDuration(Duration(milliseconds: 30));
    await soundRecorder.setSubscriptionDuration(Duration(milliseconds: 30));
    initializeDateFormatting();
  }

  Future<void> init() async {
    soundRecorder.openAudioSession(
        focus: AudioFocus.requestFocusTransient,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _initializeExample(false);

    if (Platform.isAndroid) {
      // copyAssets();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cancelRecorderSubscriptions();
    _releaseRecorderAndPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.red),
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
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
              ringColor: Colors.grey[300],

              // Ring Gradient for Countdown Widget.
              ringGradient: null,

              // Filling Color for Countdown Widget.
              fillColor: Colors.purpleAccent[100],

              // Filling Gradient for Countdown Widget.
              fillGradient: null,

              // Background Color for Countdown Widget.
              backgroundColor: Colors.purple[500],

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
          _actionShow(context)

        ],
      ),
    );
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
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        child: new Wrap(
                          children: <Widget>[
                            new ListTile(
                                leading: new Icon(Icons.music_note),
                                title: new Text('Music'),
                                onTap: () => {}
                            ),
                            new ListTile(
                              leading: new Icon(Icons.videocam),
                              title: new Text('Video'),
                              onTap: () => {},
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
      print("Start clicked");
      // Request microphone permission
      await Permission.microphone.request();
      print("Start clicked - 1");

      PermissionStatus status = await Permission.microphone.status;
      print("Start clicked - 2");

      print(await Permission.microphone.status);

      print(await Permission.microphone.request().isGranted);

      if (!status.isGranted) {
        throw RecordingPermissionException("未获取到麦克风权限");
      } else {
        // Start countdown timer
        _countdownController.start();
      }
      // Create directory for storing audio files
      Directory fileDirectory = await getExternalStorageDirectory(); // TODO: change the next line. Can be found on the device file system, for debugging only
//      Directory fileDirectory = await getApplicationDocumentsDirectory(); // TODO: use this in production. Only visible to the app
      var time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      String path =
          '${fileDirectory.path}/${soundRecorder.hashCode}-$time${ext[Codec.pcm16WAV.index]}'; // TODO: change file format
      print('complete path $path');

      // Start recording
      // TODO: adjust bitRate and sampleRate to improve sound quality
      await soundRecorder.startRecorder(
        toFile: path,
        codec: Codec.pcm16WAV,
      );

      // 监听录音, TODO: for debugging/logging purpose only
      _recorderSubscription = soundRecorder.onProgress.listen((e) {
        if (e != null && e.duration != null) {
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.duration.inMilliseconds,
              isUtc: true);
          String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
          if (date.second >= _maxDuration) {
            _stopRecorder();
          }
          setState(() {
            _recorderTxt = txt.substring(0, 8);
            _dbLevel = e.decibels;
            print("当前振幅：$_dbLevel");
          });
        }
      });
      this.setState(() {
        _state = RecordPlayState.recording;
        _path = path;
      });
    } catch (err) {
      print(err);
      setState(() {
        _stopRecorder();
        _state = RecordPlayState.idle;
        _cancelRecorderSubscriptions();
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

  /// 结束录音
  _stopRecorder() async {
    try {
      // Stop countdown timer
      _countdownController.pause();
      await soundRecorder.stopRecorder();
      _cancelRecorderSubscriptions();
      // _getDuration(); // TODO: for debugging purpose only, change to log in production
    } catch (err) {
      // TODO: catch error
      print('stopRecorder error: $err');
    }
    setState(() {
      _dbLevel = 0.0;
      _state = RecordPlayState.completed;
    });
  }

  /// 取消录音监听
  void _cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }
  }

  /// 释放录音和播放
  Future<void> _releaseRecorderAndPlayer() async {
    try {
      await soundPlayer.closeAudioSession();
      await soundRecorder.closeAudioSession();
    } catch (e) {
      // TODO: catch error
      print('Released unsuccessful');
      print(e);
    }
  }

  /// Print录音文件秒数
  // TODO: for debugging only
  Future<void> _getDuration() async {
    Duration d = await flutterSoundHelper.duration(_path);
    _duration = d != null ? d.inMilliseconds / 1000.0 : 0.00;
    print("_duration == $_duration");
    var minutes = d.inMinutes;
    var seconds = d.inSeconds % 60;
    var millSecond = d.inMilliseconds % 1000 ~/ 10;
    _recorderTxt = "";

    if (minutes > 9) {
      _recorderTxt = _recorderTxt + "$minutes";
    } else {
      _recorderTxt = _recorderTxt + "0$minutes";
    }

    if (seconds > 9) {
      _recorderTxt = _recorderTxt + ":$seconds";
    } else {
      _recorderTxt = _recorderTxt + ":0$seconds";
    }

    if (millSecond > 9) {
      _recorderTxt = _recorderTxt + ":$millSecond";
    } else {
      _recorderTxt = _recorderTxt + ":0$millSecond";
    }
    print('text $_recorderTxt');
  }
}




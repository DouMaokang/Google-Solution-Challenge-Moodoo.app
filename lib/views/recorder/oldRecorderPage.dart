import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/date_symbol_data_local.dart';

enum RecordPlayState {
  record,
  recording,
  play,
  playing,
}

class RecorderPage extends StatefulWidget {
  RecorderPage({Key key}) : super(key: key);

  @override
  _RecorderPageState createState() => _RecorderPageState();
}

class _RecorderPageState extends State<RecorderPage> {
  RecordPlayState _state = RecordPlayState.record;

  StreamSubscription _recorderSubscription;
  StreamSubscription _playerSubscription;

  // StreamSubscription _dbPeakSubscription;
  FlutterSoundRecorder flutterSound;
  String _recorderTxt = '00:00:00';
  // String _playerTxt = '00:00:00';

  double _dbLevel = 0.0;
  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
  FlutterSoundPlayer playerModule = FlutterSoundPlayer();

  var _path = "";
  var _duration = 0.0;
  var _maxLength = 59.0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> _initializeExample(bool withUI) async {
    await playerModule.closeAudioSession();

    await playerModule.openAudioSession(
        focus: AudioFocus.requestFocusTransient,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);

    await playerModule.setSubscriptionDuration(Duration(milliseconds: 30));
    await recorderModule.setSubscriptionDuration(Duration(milliseconds: 30));
    initializeDateFormatting();
  }

  Future<void> init() async {
    recorderModule.openAudioSession(
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
    _cancelPlayerSubscriptions();
    _releaseFlauto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF0C141F),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          centerTitle: true,
          brightness: Brightness.dark,
          title: Text(
            '录音',
            style: TextStyle(color: Colors.white, fontSize: 18),
          )),
      backgroundColor: Color(0xFF0C141F),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _timeShow(),
          ),
          Positioned(
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).padding.bottom + 15,
              child: _actionShow())
        ],
      ),
    );
  }

  Widget _timeShow() {
    return Column(children: [
      Container(
          width: double.maxFinite,
          height: 120,
          alignment: Alignment.center,
          child: Text(_recorderTxt,
              style: TextStyle(fontSize: 36, color: Colors.white))),
      SizedBox(height: 60),
      CustomPaint(
          size: Size(double.maxFinite, 100),
          painter:
          LCPainter(amplitude: _dbLevel / 2, number: 30 - _dbLevel ~/ 20)),
    ]);
  }

  Widget _actionShow() {
    var _width = 300;
    var _height = _width * 0.8;

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFF1A283B),
        ),
        height: _height,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Offstage(
                offstage: _state == RecordPlayState.play ||
                    _state == RecordPlayState.playing
                    ? false
                    : true,
                child: InkWell(
                    onTap: () {
                      setState(() async {
                        _state = RecordPlayState.record;
                        _path = "";
                        _recorderTxt = "00:00:00";
                        _dbLevel = 0.0;
                        await _stopPlayer();
                        _state = RecordPlayState.record;
                      });
                    },
                    child: Container(
                      width: _width / 3,
                      child: SizedBox(),
                    ))),
            InkWell(
                onTap: () {
                  if (_state == RecordPlayState.record) {
                    _startRecorder();
                  } else if (_state == RecordPlayState.recording) {
                    _stopRecorder();
                  } else if (_state == RecordPlayState.play) {
                    _startPlayer();
                  } else if (_state == RecordPlayState.playing) {
                    _pauseResumePlayer();
                  }
                },
                child: Container(
                  width: _width / 3,
                  padding: EdgeInsets.all(10),
                  child: SizedBox(),
                )),
            Offstage(
                offstage: _state == RecordPlayState.play ||
                    _state == RecordPlayState.playing
                    ? false
                    : true,
                child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: _width / 3,
                      padding: EdgeInsets.all(30),
                      child: SizedBox(),
                    )))
          ]),
          SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Offstage(
                offstage: _state == RecordPlayState.play ||
                    _state == RecordPlayState.playing
                    ? false
                    : true,
                child: InkWell(
                    onTap: () {
                      setState(() async {
                        _state = RecordPlayState.record;
                        _path = "";
                        _recorderTxt = "00:00:00";
                        _dbLevel = 0.0;
                        await _stopPlayer();
                        _state = RecordPlayState.record;
                      });
                    },
                    child: Container(
                        width: _width / 3,
                        alignment: Alignment.center,
                        child: Text(
                          "重录",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )))),
            InkWell(
                onTap: () {
                  if (_state == RecordPlayState.record) {
                    _startRecorder();
                  } else if (_state == RecordPlayState.recording) {
                    _stopRecorder();
                  } else if (_state == RecordPlayState.play) {
                    _startPlayer();
                  } else if (_state == RecordPlayState.playing) {
                    _pauseResumePlayer();
                  }
                },
                child: Container(
                    width: _width / 3,
                    alignment: Alignment.center,
                    child: Text(
                      _state == RecordPlayState.record
                          ? "录音"
                          : _state == RecordPlayState.recording
                          ? "结束"
                          : _state == RecordPlayState.play ? "播放" : "暂停",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ))),
            Offstage(
                offstage: _state == RecordPlayState.play ||
                    _state == RecordPlayState.playing
                    ? false
                    : true,
                child: InkWell(
                    onTap: () {},
                    child: Container(
                        width: _width / 3,
                        alignment: Alignment.center,
                        child: Text(
                          "完成",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )))),
          ])
        ]));
  }

  /// 开始录音
  _startRecorder() async {
    try {
      await Permission.microphone.request();
      PermissionStatus status = await Permission.microphone.status;
      if (!status.isGranted) {
        EasyLoading.showToast("未获取到麦克风权限");
        throw RecordingPermissionException("未获取到麦克风权限");
      }
      print('===>  获取了权限');
      Directory tempDir = await getExternalStorageDirectory(); // TODO: change the next line. Can be found on the device file system, for debugging only
//      Directory tempDir = await getTemporaryDirectory();
      var time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      String path = '${tempDir.path}/${recorderModule.hashCode}-$time${ext[Codec.pcm16.index]}';
      print('===>  准备开始录音');
      await recorderModule.startRecorder(
        toFile: path,
        codec: Codec.pcm16,
      );
      print('===>  开始录音');

      /// 监听录音
//      _recorderSubscription = recorderModule.onProgress.listen((e) {
//        if (e != null && e.duration != null) {
//          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
//              e.duration.inMilliseconds,
//              isUtc: true);
//          String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
//          if (date.second >= _maxLength) {
//            _stopRecorder();
//          }
//          setState(() {
//            _recorderTxt = txt;
//            _dbLevel = e.decibels;
//            print("当前振幅：$_dbLevel");
//          });
//        }
//      });
      this.setState(() {
        _state = RecordPlayState.recording;
        _path = path;
        print("path == $path");
      });
    } catch (err) {
      setState(() {
        _stopRecorder();
        _state = RecordPlayState.record;
        _cancelRecorderSubscriptions();
      });
    }
  }

  /// 结束录音
  _stopRecorder() async {
    try {
      await recorderModule.stopRecorder();
      print('stopRecorder');
      _cancelRecorderSubscriptions();
      _getDuration();
    } catch (err) {
      print('stopRecorder error: $err');
    }
    setState(() {
      _dbLevel = 0.0;
      _state = RecordPlayState.play;
    });
  }

  /// 取消录音监听
  void _cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }
  }

  /// 取消播放监听
  void _cancelPlayerSubscriptions() {
    if (_playerSubscription != null) {
      _playerSubscription.cancel();
      _playerSubscription = null;
    }
  }

  /// 释放录音和播放
  Future<void> _releaseFlauto() async {
    try {
      await playerModule.closeAudioSession();
      await recorderModule.closeAudioSession();
    } catch (e) {
      print('Released unsuccessful');
      print(e);
    }
  }

  /// 获取录音文件秒数
  Future<void> _getDuration() async {
    Duration d = await flutterSoundHelper.duration(_path);
    _duration = d != null ? d.inMilliseconds / 1000.0 : 0.00;
    print("_duration == $_duration");
    var seconds = d.inSeconds % 60;
    var millSecond = d.inMilliseconds % 1000 ~/ 10;
    _recorderTxt = "";
    setState(() {});
  }

  /// 开始播放
  Future<void> _startPlayer() async {
    try {
      if (await _fileExists(_path)) {
        File file = File('$_path');
        var data = await file.readAsBytes();

        List<num> data16 = data.buffer.asInt16List();
        List<double> input = data16.map((i) => i.toDouble()).toList();



        var sampleRate = 16000;
        var windowLength = 512;
        print(windowLength);
        var windowStride = 128;
        print(windowStride);
        var fftSize = 512;
        var numFilter = 26;
        var numCoefs = 13;

//        var features = MFCC.mfccFeats(input, sampleRate, windowLength, windowStride, fftSize, numFilter, numCoefs);


        await playerModule.startPlayer(
            fromURI: _path,
            codec: Codec.pcm16,
            whenFinished: () {
              print('==> 结束播放');
              _stopPlayer();
              setState(() {});
            });
      } else {
        EasyLoading.showToast("未找到文件路径");
        throw RecordingPermissionException("未找到文件路径");
      }

      _cancelPlayerSubscriptions();
      _playerSubscription = playerModule.onProgress.listen((e) {
        if (e != null) {
        }
      });
      setState(() {
        _state = RecordPlayState.playing;
      });
      print('===> 开始播放');
    } catch (err) {
      print('==> 错误: $err');
    }
    setState(() {});
  }

  /// 结束播放
  Future<void> _stopPlayer() async {
    try {
      await playerModule.stopPlayer();
      print('===> 结束播放');
      _cancelPlayerSubscriptions();
    } catch (err) {
      print('==> 错误: $err');
    }
    setState(() {
      _state = RecordPlayState.play;
    });
  }

  /// 暂停/继续播放
  void _pauseResumePlayer() {
    if (playerModule.isPlaying) {
      playerModule.pausePlayer();
      _state = RecordPlayState.play;
      print('===> 暂停播放');
    } else {
      playerModule.resumePlayer();
      _state = RecordPlayState.playing;
      print('===> 继续播放');
    }
    setState(() {});
  }

  /// 判断文件是否存在
  Future<bool> _fileExists(String path) async {
    return await File(path).exists();
  }
}

class LCPainter extends CustomPainter {
  final double amplitude;
  final int number;
  LCPainter({this.amplitude = 100.0, this.number = 20});
  @override
  void paint(Canvas canvas, Size size) {
    var centerY = 0.0;
    var width = 750 / number;

    for (var a = 0; a < 4; a++) {
      var path = Path();
      path.moveTo(0.0, centerY);
      var i = 0;
      while (i < number) {
        path.cubicTo(width * i, centerY, width * (i + 1),
            centerY + amplitude - a * (30), width * (i + 2), centerY);
        path.cubicTo(width * (i + 2), centerY, width * (i + 3),
            centerY - amplitude + a * (30), width * (i + 4), centerY);
        i = i + 4;
      }
      canvas.drawPath(
          path,
          Paint()
            ..color = a == 0 ? Colors.blueAccent : Colors.blueGrey.withAlpha(50)
            ..strokeWidth = a == 0 ? 3.0 : 2.0
            ..maskFilter = MaskFilter.blur(
              BlurStyle.solid,
              5,
            )
            ..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
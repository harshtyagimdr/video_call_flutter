import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class Host extends StatefulWidget {
  @override
  _HostState createState() => _HostState();
}

class _HostState extends State<Host> {
  static TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.blue);
  MediaStream _localStream;

  @override
  void initState() {
    super.initState();
    _handleCameraAndMicPermissions();
    _initAgoraRtcEngine();
  }

  _handleCameraAndMicPermissions() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.microphone]);
  }

  Future<void> _initAgoraRtcEngine() async {
    AgoraRtcEngine.create('xxxxxxxxxxxxxxxxxxxxxxxxx');
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    AgoraRtcEngine.setClientRole(ClientRole.Audience);
    AgoraRtcEngine.enableWebSdkInteroperability(true);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 120,
                child: AgoraRtcEngine.createNativeView( (viweId) {
                  AgoraRtcEngine.setupLocalVideo(viweId, VideoRenderMode.Fit);
                  AgoraRtcEngine.startPreview();
                  AgoraRtcEngine.joinChannel(null, 'flutter', null, 0);
                },key: Key('0')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
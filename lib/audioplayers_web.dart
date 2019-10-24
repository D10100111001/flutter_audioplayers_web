import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class AudioplayersPlugin {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel('xyz.luan/audioplayers',
        const StandardMethodCodec(), registrar.messenger);
    final AudioplayersPlugin instance = AudioplayersPlugin();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'play':
        final String url = call.arguments['url'];
        final bool isLocal = call.arguments['isLocal'];
        final double volume = call.arguments['volume'];
        final int position = call.arguments['position'];
        final bool respectSilence = call.arguments['respectSilence'];
        final bool stayAwake = call.arguments['stayAwake'];
        return play(url);
      case 'loadAll':
        return [];
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details: "The audioplayers plugin for web doesn't implement "
                "the method '${call.method}'");
    }
  }

  int play(String url) {
    final webUrl = 'assets/assets/$url';
    final audioElement = html.AudioElement(webUrl);
    audioElement.play();
    return 0;
  }
}

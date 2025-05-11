import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'video_cache_server_platform_interface.dart';

/// An implementation of [VideoCacheServerPlatform] that uses method channels.
class MethodChannelVideoCacheServer extends VideoCacheServerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('video_cache_server');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

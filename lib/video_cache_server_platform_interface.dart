import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'video_cache_server_method_channel.dart';

abstract class VideoCacheServerPlatform extends PlatformInterface {
  /// Constructs a VideoCacheServerPlatform.
  VideoCacheServerPlatform() : super(token: _token);

  static final Object _token = Object();

  static VideoCacheServerPlatform _instance = MethodChannelVideoCacheServer();

  /// The default instance of [VideoCacheServerPlatform] to use.
  ///
  /// Defaults to [MethodChannelVideoCacheServer].
  static VideoCacheServerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VideoCacheServerPlatform] when
  /// they register themselves.
  static set instance(VideoCacheServerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

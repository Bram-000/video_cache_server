import 'package:flutter_test/flutter_test.dart';
import 'package:video_cache_server/video_cache_server.dart';
import 'package:video_cache_server/video_cache_server_platform_interface.dart';
import 'package:video_cache_server/video_cache_server_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVideoCacheServerPlatform
    with MockPlatformInterfaceMixin
    implements VideoCacheServerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final VideoCacheServerPlatform initialPlatform = VideoCacheServerPlatform.instance;

  test('$MethodChannelVideoCacheServer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVideoCacheServer>());
  });

  /*test('getPlatformVersion', () async {
    VideoCacheServer videoCacheServerPlugin = VideoCacheServer();
    MockVideoCacheServerPlatform fakePlatform = MockVideoCacheServerPlatform();
    VideoCacheServerPlatform.instance = fakePlatform;

    expect(await videoCacheServerPlugin.getPlatformVersion(), '42');
  });*/
}

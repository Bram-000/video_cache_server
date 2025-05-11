#include "include/video_cache_server/video_cache_server_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "video_cache_server_plugin.h"

void VideoCacheServerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  video_cache_server::VideoCacheServerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

import 'package:package_info_plus/package_info_plus.dart';


Future<String?> getAppInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

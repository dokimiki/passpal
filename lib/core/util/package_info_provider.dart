import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Provider for PackageInfo to get app version information
final packageInfoProvider = FutureProvider<PackageInfo>((ref) async {
  return PackageInfo.fromPlatform();
});

/// Provider for app version string
final appVersionProvider = FutureProvider<String>((ref) async {
  final packageInfo = await ref.watch(packageInfoProvider.future);
  return packageInfo.version;
});

/// Provider for app build number
final appBuildNumberProvider = FutureProvider<String>((ref) async {
  final packageInfo = await ref.watch(packageInfoProvider.future);
  return packageInfo.buildNumber;
});

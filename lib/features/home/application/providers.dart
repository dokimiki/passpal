import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/use_cases/get_system_news_use_case.dart';
import '../domain/use_cases/get_received_mail_use_case.dart';
import '../domain/use_cases/get_mail_body_use_case.dart';
import '../domain/use_cases/get_albo_news_use_case.dart';
import '../data/repositories/home_repository_impl.dart';
import '../data/datasources/manabo_system_news_remote_ds.dart';
import '../data/datasources/manabo_received_mail_remote_ds.dart';
import '../data/datasources/manabo_mail_view_remote_ds.dart';
import '../data/datasources/albo_news_remote_ds.dart';
import 'package:passpal/core/network/providers.dart';
import 'package:passpal/core/network/network_target.dart';

part 'providers.g.dart';

// Repository provider
@riverpod
HomeRepositoryImpl homeRepository(Ref ref) {
  final manaboClient = ref.read(networkClientProvider(NetworkTarget.manabo));
  final alboClient = ref.read(networkClientProvider(NetworkTarget.albo));

  return HomeRepositoryImpl(
    systemNewsDs: ManaboSystemNewsRemoteDs(manaboClient),
    receivedMailDs: ManaboReceivedMailRemoteDs(manaboClient),
    mailViewDs: ManaboMailViewRemoteDs(manaboClient),
    alboNewsDs: AlboNewsRemoteDs(alboClient),
  );
}

// Use Cases providers
@riverpod
GetSystemNewsUseCase getSystemNewsUseCase(Ref ref) {
  final repository = ref.read(homeRepositoryProvider);
  return GetSystemNewsUseCase(repository);
}

@riverpod
GetReceivedMailUseCase getReceivedMailUseCase(Ref ref) {
  final repository = ref.read(homeRepositoryProvider);
  return GetReceivedMailUseCase(repository);
}

@riverpod
GetMailBodyUseCase getMailBodyUseCase(Ref ref) {
  final repository = ref.read(homeRepositoryProvider);
  return GetMailBodyUseCase(repository);
}

@riverpod
GetAlboNewsUseCase getAlboNewsUseCase(Ref ref) {
  final repository = ref.read(homeRepositoryProvider);
  return GetAlboNewsUseCase(repository);
}

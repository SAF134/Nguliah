import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/core/router/app_router.dart';
import 'package:nguliah/core/services/notification_service.dart';
import 'package:nguliah/core/theme/app_theme.dart';
import 'package:nguliah/data/database/isar_service.dart';
import 'package:nguliah/features/grades/application/grade_providers.dart';
import 'package:nguliah/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await IsarService.open();

  runApp(
    ProviderScope(
      overrides: [isarProvider.overrideWithValue(isar)],
      child: const NguliahApp(),
    ),
  );
}

/// Widget root aplikasi Nguliah.
class NguliahApp extends ConsumerWidget {
  const NguliahApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final settings = ref.watch(appSettingsStreamProvider).value;
    final localeCode = settings?.localeCode ?? 'id';
    final themeModeStr = settings?.themeMode ?? 'light';
    final themeMode = themeModeStr == 'dark' ? ThemeMode.dark : ThemeMode.light;
    // Aktifkan penjadwalan ulang otomatis saat data berubah/dihapus atau startup.
    ref.watch(notificationAutoSyncProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)?.appTitle ?? 'Nguliah',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: Locale(localeCode),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
    );
  }
}

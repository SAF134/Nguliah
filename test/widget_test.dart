import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nguliah/data/repositories/profile_repository.dart';
import 'package:nguliah/data/repositories/settings_repository.dart';
import 'package:nguliah/main.dart';

import 'features/onboarding_auth_flow_test.dart';

void main() {
  testWidgets('NguliahApp merender layar Splash dengan lokalisasi ID default', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(
            FakeSettingsRepository(),
          ),
          profileRepositoryProvider.overrideWithValue(FakeProfileRepository()),
        ],
        child: const NguliahApp(),
      ),
    );

    expect(find.text('Nguliah'), findsOneWidget);
    expect(find.text('Memuat data akademik...'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
  });
}

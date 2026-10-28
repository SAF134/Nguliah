import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nguliah/core/router/app_routes.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/app_logger.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/features/onboarding/application/onboarding_providers.dart';

/// Layar Splash Screen sesuai PRD.md & DESIGN.md bagian 4, 6.
/// Tampil <= 3 detik, memuat database, lalu mengarahkan ke Onboarding, Masuk, atau Beranda.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _navigationTimer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _scheduleNavigation();
  }

  Future<void> _scheduleNavigation() async {
    try {
      final destination = await ref.read(startupDestinationProvider.future);
      if (!mounted || _navigated) return;
      final disableAnimations = MediaQuery.disableAnimationsOf(context);
      final delay = disableAnimations
          ? Duration.zero
          : AppTokens.durationSplash;

      _navigationTimer = Timer(delay, () {
        if (!mounted || _navigated) return;
        _navigated = true;
        context.go(destination);
      });
    } catch (error, stackTrace) {
      AppLogger.error(
        'Gagal menentukan rute awal di Splash',
        error,
        stackTrace,
      );
      if (!mounted || _navigated) return;
      _navigated = true;
      context.go(AppRoutes.onboarding);
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.screenMargin),
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: disableAnimations ? 1.0 : 0.85,
                end: 1.0,
              ),
              duration: disableAnimations
                  ? Duration.zero
                  : AppTokens.durationSplash,
              curve: AppTokens.curveDefault,
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: AppTokens.space48 + AppTokens.space40,
                    height: AppTokens.space48 + AppTokens.space40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: palette.primary, width: 2),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: palette.primary.withValues(alpha: 0.25),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: AppTokens.space20),
                  Semantics(
                    header: true,
                    child: Text(
                      l10n.appTitle,
                      style: AppTypography.display(palette.text900),
                    ),
                  ),
                  const SizedBox(height: AppTokens.space8),
                  Text(
                    l10n.appTagline,
                    textAlign: TextAlign.center,
                    style: AppTypography.body(palette.text600),
                  ),
                  const SizedBox(height: AppTokens.space32),
                  Semantics(
                    label: l10n.splashLoading,
                    child: SizedBox(
                      width: AppTokens.space24,
                      height: AppTokens.space24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          palette.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTokens.space12),
                  Text(
                    l10n.splashLoading,
                    style: AppTypography.caption(palette.text500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

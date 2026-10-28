import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nguliah/core/router/app_routes.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/features/onboarding/application/onboarding_providers.dart';

@immutable
class _OnboardingSlideData {
  const _OnboardingSlideData({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

/// Layar Onboarding 4 slide (Nilai, Jadwal, Tugas, Acara) sesuai PRD.md & DESIGN.md.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    await markOnboardingCompleted(ref);
    if (!mounted) return;
    context.go(AppRoutes.auth);
  }

  void _nextSlide(int totalSlides) {
    if (_currentIndex < totalSlides - 1) {
      final disableAnimations = MediaQuery.disableAnimationsOf(context);
      if (disableAnimations) {
        _pageController.jumpToPage(_currentIndex + 1);
      } else {
        _pageController.nextPage(
          duration: AppTokens.durationTransition,
          curve: AppTokens.curveDefault,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    final slides = <_OnboardingSlideData>[
      _OnboardingSlideData(
        icon: Icons.workspace_premium_rounded,
        title: l10n.onboardingSlide1Title,
        description: l10n.onboardingSlide1Desc,
      ),
      _OnboardingSlideData(
        icon: Icons.calendar_month_rounded,
        title: l10n.onboardingSlide2Title,
        description: l10n.onboardingSlide2Desc,
      ),
      _OnboardingSlideData(
        icon: Icons.task_alt_rounded,
        title: l10n.onboardingSlide3Title,
        description: l10n.onboardingSlide3Desc,
      ),
      _OnboardingSlideData(
        icon: Icons.event_available_rounded,
        title: l10n.onboardingSlide4Title,
        description: l10n.onboardingSlide4Desc,
      ),
    ];

    final isLastSlide = _currentIndex == slides.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.screenMargin),
          child: Column(
            children: <Widget>[
              const SizedBox(height: AppTokens.space8),
              // App Brand Logo Icon
              Center(
                child: Container(
                  width: AppTokens.space48,
                  height: AppTokens.space48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: palette.primary, width: 1.5),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: palette.primary.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: AppTokens.space12),
              // PageView 4 Slide
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: slides.length,
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  itemBuilder: (context, index) {
                    final slide = slides[index];
                    return Center(
                      child: SingleChildScrollView(
                        child: GlassCard(
                          borderColor: palette.primary,
                          borderWidth: 1.5,
                          padding: const EdgeInsets.all(AppTokens.space24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: AppTokens.space48 * 2,
                                height: AppTokens.space48 * 2,
                                decoration: BoxDecoration(
                                  color: palette.primarySoft,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  slide.icon,
                                  size: AppTokens.space48,
                                  color: palette.primary,
                                ),
                              ),
                              const SizedBox(height: AppTokens.space24),
                              Semantics(
                                header: true,
                                child: Text(
                                  slide.title,
                                  textAlign: TextAlign.center,
                                  style: AppTypography.h1(palette.text900),
                                ),
                              ),
                              const SizedBox(height: AppTokens.space12),
                              Text(
                                slide.description,
                                textAlign: TextAlign.center,
                                style: AppTypography.body(palette.text600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppTokens.space20),
              // Dot Indicator
              Semantics(
                label: l10n.onboardingSlideIndicator(
                  _currentIndex + 1,
                  slides.length,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(slides.length, (index) {
                    final isActive = index == _currentIndex;
                    return AnimatedContainer(
                      duration: disableAnimations
                          ? Duration.zero
                          : AppTokens.durationMicro,
                      curve: AppTokens.curveDefault,
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppTokens.space4,
                      ),
                      width: isActive ? AppTokens.space24 : AppTokens.space8,
                      height: AppTokens.space8,
                      decoration: BoxDecoration(
                        color: isActive ? palette.primary : palette.border,
                        borderRadius: BorderRadius.circular(
                          AppTokens.radiusFull,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: AppTokens.space24),
              // Aksi Utama: Lanjut (Slide 1-3) atau Mulai (Slide 4)
              if (isLastSlide)
                PrimaryButton(
                  label: l10n.actionStart,
                  icon: Icons.check_circle_outline_rounded,
                  onPressed: _finishOnboarding,
                )
              else
                PrimaryButton(
                  label: l10n.actionContinue,
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () => _nextSlide(slides.length),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

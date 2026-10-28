import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nguliah/core/router/app_routes.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/bottom_nav_pill.dart';
import 'package:nguliah/features/auth/presentation/auth_screen.dart';
import 'package:nguliah/features/events/presentation/events_screen.dart';
import 'package:nguliah/features/grades/presentation/grades_screen.dart';
import 'package:nguliah/features/home/presentation/home_screen.dart';
import 'package:nguliah/features/onboarding/presentation/onboarding_screen.dart';
import 'package:nguliah/features/onboarding/presentation/splash_screen.dart';
import 'package:nguliah/features/schedule/presentation/schedule_screen.dart';
import 'package:nguliah/features/settings/presentation/settings_screen.dart';
import 'package:nguliah/features/tasks/presentation/tasks_screen.dart';

/// Provider router aplikasi berbasis go_router sesuai DESIGN.md bagian 4.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _MainShellScaffold(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.grades,
                builder: (context, state) => const GradesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.schedule,
                builder: (context, state) => const ScheduleScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.tasks,
                builder: (context, state) => const TasksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.events,
                builder: (context, state) => const EventsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});

class _MainShellScaffold extends StatelessWidget {
  const _MainShellScaffold({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final items = <BottomNavPillItem>[
      BottomNavPillItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: l10n.navHome,
      ),
      BottomNavPillItem(
        icon: Icons.school_outlined,
        activeIcon: Icons.school_rounded,
        label: l10n.navGrades,
      ),
      BottomNavPillItem(
        icon: Icons.calendar_today_outlined,
        activeIcon: Icons.calendar_today_rounded,
        label: l10n.navSchedule,
      ),
      BottomNavPillItem(
        icon: Icons.check_circle_outline_rounded,
        activeIcon: Icons.check_circle_rounded,
        label: l10n.navTasks,
      ),
      BottomNavPillItem(
        icon: Icons.event_outlined,
        activeIcon: Icons.event_rounded,
        label: l10n.navEvents,
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: BottomNavPill(
        items: items,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

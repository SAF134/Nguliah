import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nguliah/core/services/notification_service.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_fixed_top_header.dart';
import 'package:nguliah/core/widgets/calendar_card.dart';
import 'package:nguliah/core/widgets/confirm_dialog.dart';
import 'package:nguliah/core/widgets/empty_state.dart';
import 'package:nguliah/core/widgets/notification_permission_banner.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/skeleton.dart';
import 'package:nguliah/data/models/academic_event_model.dart';
import 'package:nguliah/data/repositories/event_repository.dart';
import 'package:nguliah/features/events/application/event_providers.dart';
import 'package:nguliah/features/events/presentation/widgets/event_card.dart';
import 'package:nguliah/features/events/presentation/widgets/event_form_sheet.dart';
import 'package:nguliah/features/tasks/application/task_providers.dart';
import 'package:nguliah/features/tasks/presentation/widgets/task_card.dart';

/// Layar Acara Kampus: kalender bulanan, tab Aktif & Selesai (Rekap), CRUD penuh.
class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  Future<void> _openEventForm(
    BuildContext context,
    WidgetRef ref, {
    AcademicEvent? initialEvent,
  }) async {
    final palette = context.palette;
    final l10n = context.l10n;
    final selectedDate = ref.read(selectedEventDateProvider);

    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: palette.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTokens.radiusXl),
        ),
      ),
      builder: (sheetContext) => EventFormSheet(
        initialEvent: initialEvent,
        initialSelectedDate: selectedDate,
        onSave: (event) async {
          await ref.read(eventRepositoryProvider).saveEvent(event);
          if (context.mounted) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(l10n.toastEventSaved)));
          }
        },
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AcademicEvent event,
  ) async {
    final l10n = context.l10n;
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.eventDeleteDialogTitle,
      message: l10n.eventDeleteDialogMessage(event.name),
    );
    if (!confirmed || !context.mounted) return;

    final backup = AcademicEvent(
      id: event.id,
      name: event.name,
      description: event.description,
      location: event.location,
      eventDate: event.eventDate,
      startTimeMinutes: event.startTimeMinutes,
      endTimeMinutes: event.endTimeMinutes,
      isCompleted: event.isCompleted,
      createdAt: event.createdAt,
      updatedAt: event.updatedAt,
    );

    final repo = ref.read(eventRepositoryProvider);
    await repo.deleteEvent(event.id);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
          content: Text(l10n.toastEventDeleted),
          action: SnackBarAction(
            label: l10n.actionUndo,
            onPressed: () => repo.saveEvent(backup),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final allEventsAsync = ref.watch(eventsStreamProvider);
    final filteredEventsAsync = ref.watch(filteredEventsProvider);
    final selectedTab = ref.watch(selectedEventTabProvider);
    final selectedDate = ref.watch(selectedEventDateProvider);
    final focusedMonth = ref.watch(focusedEventMonthProvider);
    final permissionDenied = ref.watch(notificationPermissionDeniedProvider);
    final isCompact = MediaQuery.sizeOf(context).width < 360;
    final margin = isCompact
        ? AppTokens.screenMarginCompact
        : AppTokens.screenMargin;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            const AppFixedTopHeader(),
            Expanded(
              child: allEventsAsync.when(
                loading: () => Padding(
                  padding: EdgeInsets.all(margin),
                  child: const Skeleton(
                    variant: SkeletonVariant.list,
                    itemCount: 3,
                  ),
                ),
                error: (err, _) => EmptyState(
                  icon: Icons.error_outline_rounded,
                  title: l10n.errorLoadData,
                  description: err.toString(),
                  actionLabel: l10n.actionRetry,
                  onAction: () => ref.invalidate(eventsStreamProvider),
                ),
                data: (allEvents) {
                  final activeCount = allEvents
                      .where((e) => !e.isCompleted)
                      .length;
                  final completedCount = allEvents
                      .where((e) => e.isCompleted)
                      .length;
                  final filteredEvents =
                      filteredEventsAsync.value ?? <AcademicEvent>[];

                  return ListView(
                    padding: EdgeInsets.fromLTRB(
                      margin,
                      AppTokens.space8,
                      margin,
                      AppTokens.bottomNavClearance + AppTokens.space48,
                    ),
                    children: <Widget>[
                      if (permissionDenied) ...<Widget>[
                        const NotificationPermissionBanner(),
                        const SizedBox(height: AppTokens.space12),
                      ],
                      CalendarCard(
                        focusedDay: focusedMonth,
                        selectedDay: selectedDate,
                        onDaySelected: (day, focused) {
                          ref
                              .read(focusedEventMonthProvider.notifier)
                              .setMonth(focused);
                          final current = ref.read(selectedEventDateProvider);
                          if (current != null &&
                              TaskDateUtils.isSameCalendarDay(current, day)) {
                            ref
                                .read(selectedEventDateProvider.notifier)
                                .select(null);
                          } else {
                            ref
                                .read(selectedEventDateProvider.notifier)
                                .select(day);
                          }
                        },
                        onPageChanged: (focused) => ref
                            .read(focusedEventMonthProvider.notifier)
                            .setMonth(focused),
                        onClearSelection: () => ref
                            .read(selectedEventDateProvider.notifier)
                            .select(null),
                        markerCountForDay: (day) =>
                            EventTimeUtils.countEventsOnDay(allEvents, day),
                      ),
                      const SizedBox(height: AppTokens.space16),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TaskTabChip(
                              label: '${l10n.eventTabActive} ($activeCount)',
                              isSelected: selectedTab == EventFilterTab.active,
                              onTap: () => ref
                                  .read(selectedEventTabProvider.notifier)
                                  .select(EventFilterTab.active),
                            ),
                          ),
                          const SizedBox(width: AppTokens.space8),
                          Expanded(
                            child: TaskTabChip(
                              label:
                                  '${l10n.eventTabCompleted} ($completedCount)',
                              isSelected:
                                  selectedTab == EventFilterTab.completed,
                              onTap: () => ref
                                  .read(selectedEventTabProvider.notifier)
                                  .select(EventFilterTab.completed),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTokens.space16),
                      if (filteredEvents.isEmpty)
                        EmptyState(
                          icon: selectedTab == EventFilterTab.active
                              ? Icons.event_available_outlined
                              : Icons.history_edu_rounded,
                          title: selectedTab == EventFilterTab.active
                              ? l10n.emptyEventsTitle
                              : l10n.emptyCompletedEventsTitle,
                          description: selectedTab == EventFilterTab.active
                              ? l10n.emptyEventsDescription
                              : l10n.emptyCompletedEventsDescription,
                          actionLabel: selectedTab == EventFilterTab.active
                              ? l10n.actionAddEvent
                              : null,
                          onAction: selectedTab == EventFilterTab.active
                              ? () => _openEventForm(context, ref)
                              : null,
                        )
                      else ...<Widget>[
                        for (final event in filteredEvents) ...<Widget>[
                          EventCard(
                            event: event,
                            onEdit: () => _openEventForm(
                              context,
                              ref,
                              initialEvent: event,
                            ),
                            onDelete: () => _confirmDelete(context, ref, event),
                          ),
                          const SizedBox(height: AppTokens.cardGap),
                        ],
                        if (selectedTab == EventFilterTab.active) ...<Widget>[
                          const SizedBox(height: AppTokens.space12),
                          PrimaryButton(
                            label: l10n.actionAddEvent,
                            icon: Icons.add_rounded,
                            onPressed: () => _openEventForm(context, ref),
                          ),
                        ],
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

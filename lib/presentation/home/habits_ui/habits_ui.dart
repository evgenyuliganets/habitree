import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitree/core/constants/app_icons/home_icons.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/domain/entities/habit_status/habit_status.dart';
import 'package:habitree/presentation/home/habits_ui/components/empty_habits.dart';
import 'package:habitree/presentation/home/habits_ui/provider/habits_by_date_notifier.dart';
import 'package:habitree/presentation/home/week_day/provider/week_notifier.dart';
import 'package:habitree/routes/route_paths.dart';
import 'package:habitree/shared/extensions/date_extensions.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HabitsUi extends ConsumerStatefulWidget {
  const HabitsUi({super.key});

  @override
  ConsumerState<HabitsUi> createState() => _HabitsUiState();
}

class _HabitsUiState extends ConsumerState<HabitsUi> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(habitsByDateProvider);
    final weekDayState = ref.watch(weekProvider);
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(RoutePaths.createHabit);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: context.themeExtension.grayBorder15,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              context.t.home.createGoal,
              style: context.headlineMedium.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
        state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) {
            final fakeHabits = HabitStatus.fakeList(4);
            return Skeletonizer(
              child: _HabitsGridUi(
                habits: fakeHabits,
              ),
            );
          },
          error: (e) => Center(child: Text('😢 ${e.message}')),
          loaded: (loaded) {
            final habits = loaded.habits;
            return _HabitsGridUi(
              isToday: weekDayState.selectedDate.isToday,
              habits: habits,
            );
          },
        ),
      ],
    );
  }
}

class _HabitsGridUi extends StatelessWidget {
  const _HabitsGridUi({required this.habits, this.isToday = false});

  final List<HabitStatus> habits;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    if (habits.isEmpty) {
      return EmptyHabitsUi(isToday: isToday);
    }

    return GridView.builder(
      shrinkWrap: true,
      padding:  EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.w,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1.1,
      ),
      itemCount: habits.length,
      itemBuilder: (_, index) {
        final habit = habits[index];
        return HabitCard(habit: habit);
      },
    );
  }
}

class HabitCard extends ConsumerWidget {
  const HabitCard({required this.habit, super.key});

  final HabitStatus habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = habit.completed;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: InkWell(
        key: ValueKey(habit.completed),
        onTap: () {
          ref.read(habitsByDateProvider.notifier).toggleHabit(
                habit,
                ref.read(weekProvider).selectedDate,
              );
        },
        child: Container(
          decoration: BoxDecoration(
            color: habit.color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isCompleted
                  ? context.themeExtension.borderColor
                  : context.themeExtension.grayBorder30,
              width: 1.w,
            ),
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    habit.emoji,
                    style: context.displayMedium.copyWith(
                      fontSize: 50.sp,
                      height: 1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.topRight,
                    child: Skeleton.replace(
                      replacement: Bone.icon(size: 34.w),
                      child: SvgPicture.asset(
                        HomeIcons.done,
                        width: 34.w,
                        height: 34.w,
                        colorFilter: ColorFilter.mode(
                          isCompleted
                              ? context.themeExtension.borderColor
                              : context.themeExtension.grayBorder30,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.w),
              const Spacer(),
              Text(
                habit.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.bodyLarge.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.w),
              Text(
                _formatTimeAndSchedule(habit, context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimeAndSchedule(HabitStatus habit, BuildContext context) {
    final timeStr = habit.time.format(context);

    String schedule;
    if (habit.isDaily) {
      schedule = t.habit.every_day;
    } else if (habit.repeatDays.isEmpty) {
      schedule = t.habit.one_time;
    } else {
      final localizedDays =
          habit.repeatDays.map(_localizedShortDayName).join(', ');
      schedule = localizedDays;
    }

    return t.habit.time_schedule(time: timeStr, schedule: schedule);
  }

  String _localizedShortDayName(String englishDay) {
    final weekdayMap = {
      'monday': DateFormat.E('uk').dateSymbols.SHORTWEEKDAYS[1],
      'tuesday': DateFormat.E('uk').dateSymbols.SHORTWEEKDAYS[2],
      'wednesday': DateFormat.E('uk').dateSymbols.SHORTWEEKDAYS[3],
      'thursday': DateFormat.E('uk').dateSymbols.SHORTWEEKDAYS[4],
      'friday': DateFormat.E('uk').dateSymbols.SHORTWEEKDAYS[5],
      'saturday': DateFormat.E('uk').dateSymbols.SHORTWEEKDAYS[6],
      'sunday': DateFormat.E('uk').dateSymbols.SHORTWEEKDAYS[0],
    };

    return weekdayMap[englishDay.toLowerCase()] ?? englishDay;
  }
}

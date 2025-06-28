import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/home/habits_ui/provider/habits_by_date_notifier.dart';
import 'package:habitree/presentation/home/week_day/provider/week_notifier.dart';
import 'package:intl/intl.dart';

class WeekUi extends ConsumerStatefulWidget {
  const WeekUi({super.key});

  @override
  ConsumerState<WeekUi> createState() => _WeekUiState();
}

class _WeekUiState extends ConsumerState<WeekUi> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedIndex = ref.read(weekProvider).selectedIndex;
      final chipWidth = 72.w + 8.w; // chip + horizontal padding
      final offset = (selectedIndex - 1) * chipWidth;

      if (selectedIndex > 1) {
        _scrollController.jumpTo(offset);
      }
      if (!mounted) return;
      final date = ref.read(weekProvider).weekDates[selectedIndex];
      Future.delayed(Duration.zero, () {
        // Ensure the habits for the selected date are loaded
        // after the week UI is built and scrolled to the correct position.
        if (!mounted) return;
        ref.read(habitsByDateProvider.notifier).loadInitial(date);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(weekProvider);
    final notifier = ref.read(weekProvider.notifier);

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: List.generate(state.weekDates.length, (index) {
          final date = state.weekDates[index];
          final label = toBeginningOfSentenceCase(
            DateFormat.EEEE(Localizations.localeOf(context).languageCode)
                .format(date),
          );
          final isSelected = index == state.selectedIndex;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: SizedBox(
              height: 38.h,
              child: RawChip(
                color: context.theme.colorScheme.surface.matColor,
                label: SizedBox(
                  child: Center(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleMedium.copyWith(
                        fontSize: 15.sp,
                        color: context.themeExtension.borderColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                selected: isSelected,
                onSelected: (_) {
                  notifier.selectIndex(index);
                  final date = state.weekDates[index];
                  ref.read(habitsByDateProvider.notifier).loadInitial(date);
                },
                side: BorderSide(
                  color:
                      // context.themeExtension.borderColor,
                      isSelected
                          ? context.themeExtension.borderColor
                          : context.themeExtension.lightGrayColor,
                  width: 1.8.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                labelPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                showCheckmark: false,
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

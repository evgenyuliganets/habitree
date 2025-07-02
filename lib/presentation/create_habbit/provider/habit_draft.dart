import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/core/theme/habbit_colors.dart';
import 'package:habitree/data/models/habit/create_habit.dart';
import 'package:habitree/domain/entities/habit/habit.dart';
import 'package:habitree/presentation/create_habbit/provider/utils/default_habit_icons.dart';
import 'package:habitree/shared/extensions/hex_color_extension.dart';
import 'package:habitree/shared/extensions/time_of_day_extensions.dart';

part 'habit_draft.freezed.dart';

@freezed
class HabitDraft with _$HabitDraft {
  const factory HabitDraft({
    @Default(DefaultHabitIcons.defaultIcon) String emoji,
    @Default(HabitColors.defaultColor) Color color,
    @Default('') String title,
    @Default(<Weekday>[]) List<Weekday> repeatDays,
    @Default(null) bool? isDaily,
    @Default(null) bool? isOneTime,
    @Default(null) TimeOfDay? time,
    @Default(null) HabitTerm? term,
  }) = _HabitDraft;
}

extension HabitDraftDtoMapper on HabitDraft {
  CreateHabitDto toDto() {
    return CreateHabitDto(
      title: title,
      emoji: emoji,
      color: color.toHex(),
      repeatDays: weekDaysToJson(repeatDays),
      isDaily: isDaily ?? false,
      isOneTime: isOneTime ?? false,
      timeOfDay: (time ?? const TimeOfDay(hour: 9, minute: 0)).formatString(),
      term: term?.name ?? HabitTerm.week.name,
    );
  }
}

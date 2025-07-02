import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/domain/entities/habit/habit.dart';
import 'package:habitree/presentation/create_habbit/components/choose_color_dialog.dart';
import 'package:habitree/presentation/create_habbit/components/choose_frequency_dialog.dart';
import 'package:habitree/presentation/create_habbit/components/choose_icon_dialog.dart';
import 'package:habitree/presentation/create_habbit/components/choose_schedule_dialog.dart';
import 'package:habitree/presentation/create_habbit/components/choose_term_dialog.dart';
import 'package:habitree/presentation/create_habbit/components/choose_time_dialog.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';
import 'package:habitree/routes/route_paths.dart';
import 'package:habitree/shared/widgets/static/double_circle.dart';

class HabitCreationFillingPage extends ConsumerStatefulWidget {
  const HabitCreationFillingPage({super.key});

  static const String path = RoutePaths.habitCreationFilling;

  @override
  ConsumerState<HabitCreationFillingPage> createState() =>
      _HabitCreationFillingPageState();
}

class _HabitCreationFillingPageState
    extends ConsumerState<HabitCreationFillingPage> {
  final textEditingController = TextEditingController();
  int length = 6;
  int currentDialogIndex = 0;
  final _formKey = GlobalKey<FormState>();
  bool showErrors = false;

  void showNextDialog(BuildContext context) {
    if (currentDialogIndex < length - 1) {
      currentDialogIndex++;
      Navigator.of(context).pop();
      switch (currentDialogIndex) {
        case 0:
          showChooseColorDialog(context, showNextDialog);
        case 1:
          showChooseIconDialog(context, showNextDialog);
        case 2:
          showChooseScheduleCDialog(context, showNextDialog);
        case 3:
          showChooseFrequencyDialog(context, showNextDialog);
        case 4:
          showChooseTimeDialog(context, showNextDialog);
        case 5:
          showChooseTermDialog(context, showNextDialog);
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  String? getScheduleText({
    required List<Weekday> repeatDays,
    required bool? isDaily,
  }) {
    if (true == isDaily) {
      return t.habitCreationFilling.dailyLabel;
    } else if (repeatDays.isEmpty) {
      return null;
    } else {
      final locale = Localizations.localeOf(context);
      return repeatDays
          .map(
            (e) => repeatDays.length > 1
                ? e.getLabel(locale)
                : e.getFullLabel(locale),
          )
          .join(', ');
    }
  }

  String? getFrequencyText({bool? isOneTime}) {
    if (isOneTime == null) return null;
    return isOneTime
        ? context.t.habitCreationFilling.goalOnce
        : context.t.habitCreationFilling.goalLongTerm;
  }

  String? getTimeText(TimeOfDay? time) {
    if (time == null) return null;
    return time.format(context);
  }

  String? getTermText(HabitTerm? term) {
    if (term == null) return null;
    return term.title(context.t);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habitDraft = ref.watch(createHabitProvider);
    var textIsEmpty = textEditingController.text.isEmpty;
    final isDaily = habitDraft.isDaily;
    final repeatDays = habitDraft.repeatDays;
    final repeatDaysIsEmpty = repeatDays.isEmpty;
    final isOneTime = habitDraft.isOneTime;
    final time = habitDraft.time;
    final term = habitDraft.term;

    var isEmpty = textIsEmpty ||
        (isDaily == null || repeatDaysIsEmpty) ||
        isOneTime == null ||
        time == null ||
        term == null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.habitCreationFilling.title,
          style: context.headlineLarge.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text(
                  context.t.habitCreationFilling.subtitle,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.themeExtension.grayColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                _FillElement(
                  title: context.t.habitCreationFilling.nameLabel,
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: context.t.habitCreationFilling.nameHint,
                    ),
                    validator: (value) {
                      if (showErrors &&
                          (value == null || value.trim().isEmpty)) {
                        return context.t.habitCreationFilling.nameHint;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 32.h),
                _FillElement(
                  title: context.t.habitCreationFilling.pickColorIconLabel,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _LocalInputField(
                        text: context.t.habitCreationFilling.color,
                        currentDialogIndex: currentDialogIndex,
                        showNextDialog: (context) {
                          currentDialogIndex = 0;
                          showChooseColorDialog(context, showNextDialog);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: DoubleCircle(
                          color: habitDraft.color,
                          size: 16.w,
                          padding: 4.w,
                        ),
                      ),
                      const Spacer(),
                      _LocalInputField(
                        text: context.t.habitCreationFilling.icon,
                        currentDialogIndex: currentDialogIndex,
                        showNextDialog: (context) {
                          currentDialogIndex = 1;
                          showChooseIconDialog(context, showNextDialog);
                        },
                        showError: showErrors && habitDraft.emoji.isEmpty,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          habitDraft.emoji,
                          style: context.displayMedium.copyWith(
                            fontSize: 40.sp,
                            height: 22 / 40,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                _FillElement(
                  title: context.t.habitCreationFilling.frequencyLabel,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LocalInputField(
                        borderRadius: BorderRadius.circular(12.r),
                        text: getScheduleText(
                              repeatDays: repeatDays,
                              isDaily: isDaily,
                            ) ??
                            context.t.habitCreationFilling.repeatDaysLabel,
                        currentDialogIndex: currentDialogIndex,
                        showNextDialog: (context) {
                          currentDialogIndex = 2;
                          showChooseScheduleCDialog(context, showNextDialog);
                        },
                        mainAxisAlignment: MainAxisAlignment.start,
                        showError: showErrors &&
                            (repeatDaysIsEmpty || isDaily == null),
                      ),
                      SizedBox(height: 16.h),
                      _LocalInputField(
                        borderRadius: BorderRadius.circular(12.r),
                        text: getFrequencyText(isOneTime: isOneTime) ??
                            context.t.habitCreationFilling.selectFrequency,
                        currentDialogIndex: currentDialogIndex,
                        showNextDialog: (context) {
                          currentDialogIndex = 3;
                          showChooseFrequencyDialog(context, showNextDialog);
                        },
                        mainAxisAlignment: MainAxisAlignment.start,
                        showError: showErrors && isOneTime == null,
                      ),
                      SizedBox(height: 16.h),
                      _LocalInputField(
                        borderRadius: BorderRadius.circular(12.r),
                        text: getTimeText(time) ??
                            context.t.habitCreationFilling.selectTime,
                        currentDialogIndex: currentDialogIndex,
                        showNextDialog: (context) {
                          currentDialogIndex = 4;
                          showChooseTimeDialog(context, showNextDialog);
                        },
                        mainAxisAlignment: MainAxisAlignment.start,
                        showError: showErrors && time == null,
                      ),
                      SizedBox(height: 16.h),
                      _LocalInputField(
                        borderRadius: BorderRadius.circular(12.r),
                        text: getTermText(term) ??
                            context.t.habitCreationFilling.selectTerm,
                        currentDialogIndex: currentDialogIndex,
                        showNextDialog: (context) {
                          currentDialogIndex = 5;
                          showChooseTermDialog(context, showNextDialog);
                        },
                        mainAxisAlignment: MainAxisAlignment.start,
                        showError: showErrors && term == null,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      showErrors = true;
                      _formKey.currentState?.validate();
                      textIsEmpty = textEditingController.text.isEmpty;
                      isEmpty = textIsEmpty ||
                          (isDaily == null || repeatDaysIsEmpty) ||
                          isOneTime == null ||
                          time == null ||
                          term == null;
                    });

                    if (isEmpty) return;

                    ref.read(createHabitProvider.notifier).submit(
                          textEditingController.text.trim(),
                        );
                  },
                  child: Text(context.t.general.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FillElement extends StatelessWidget {
  const _FillElement({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16.h),
        child,
      ],
    );
  }
}

class _LocalInputField extends StatelessWidget {
  const _LocalInputField({
    required this.currentDialogIndex,
    required this.showNextDialog,
    required this.text,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.borderRadius,
    this.showError = false,
  });

  final int currentDialogIndex;
  final String text;
  final MainAxisAlignment mainAxisAlignment;
  final BorderRadius? borderRadius;
  final bool showError;

  final void Function(BuildContext) showNextDialog;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => showNextDialog(context),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(20.r),
              border: Border.all(
                color: showError
                    ? context.theme.colorScheme.error
                    : context.themeExtension.borderColor,
              ),
            ),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: context.headlineMedium.copyWith(
                    fontSize: 15.sp,
                    height: 22 / 15,
                    fontWeight: FontWeight.w400,
                    color: showError ? context.theme.colorScheme.error : null,
                  ),
                ),
                SizedBox(width: 4.w),
                if (mainAxisAlignment == MainAxisAlignment.start)
                  const Spacer(),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22.w,
                  color: context.themeExtension.grayColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

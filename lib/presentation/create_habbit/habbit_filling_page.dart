import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/create_habbit/components/choose_color_dialog.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';
import 'package:habitree/routes/route_paths.dart';
import 'package:habitree/shared/widgets/static/double_circle.dart';

class HabitCreationFillingPage extends ConsumerWidget {
  const HabitCreationFillingPage({super.key});

  static const String path = RoutePaths.habitCreationFilling;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitDraft = ref.watch(createHabitProvider);

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
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
            Text(
              context.t.habitCreationFilling.nameLabel,
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16.h),
            TextField(
              decoration: InputDecoration(
                hintText: context.t.habitCreationFilling.nameHint,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              context.t.habitCreationFilling.pickColorIconLabel,
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 100.h,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      showChooseColorDialog(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: context.themeExtension.borderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.t.habitCreationFilling.color,
                            textAlign: TextAlign.center,
                            style: context.headlineMedium.copyWith(
                              fontSize: 15.sp,
                              height: 22 / 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 22.w,
                            color: context.themeExtension.grayColor,
                          ),
                        ],
                      ),
                    ),
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
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: context.themeExtension.borderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.t.habitCreationFilling.icon,
                            textAlign: TextAlign.center,
                            style: context.headlineMedium.copyWith(
                              fontSize: 15.sp,
                              height: 22 / 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 22.w,
                            color: context.themeExtension.grayColor,
                          ),
                        ],
                      ),
                    ),
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
          ],
        ),
      ),
    );
  }
}

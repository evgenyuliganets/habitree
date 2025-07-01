import 'dart:async';

import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/core/theme/habbit_colors.dart';
import 'package:habitree/routes/route_paths.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  static const String path = RoutePaths.createHabit;

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  int _colorIndex = 0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1, milliseconds: 300), (_) {
      setState(() {
        _colorIndex = (_colorIndex + 1) % HabitColors.values.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = HabitColors.values[_colorIndex];
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              height: 145.w,
              width: 165.w,
              decoration: BoxDecoration(
                color: currentColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            context.t.createHabitStart.title,
            style: context.headlineLarge.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            context.t.createHabitStart.subtitle,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: context.themeExtension.grayColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Text(t.createHabitStart.chooseTemplate),
                ),
                SizedBox(height: 16.h),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RoutePaths.habitCreationFilling);
                  },
                  child: Text(t.createHabitStart.createCustom),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

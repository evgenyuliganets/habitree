import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitree/core/constants/app_icons/dashboard_icons.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t.bottomNav;
    return BottomNavigationBar(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            DashboardIcons.home,
            width: 35.w,
            colorFilter: ColorFilter.mode(
              currentIndex == 0
                  ? context.themeExtension.borderColor
                  : context.themeExtension.grayColor,
              BlendMode.srcIn,
            ),
          ),
          label: t.home,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            DashboardIcons.calendar,
            width: 35.w,
            colorFilter: ColorFilter.mode(
              currentIndex == 1
                  ? context.themeExtension.borderColor
                  : context.themeExtension.grayColor,
              BlendMode.srcIn,
            ),
          ),
          label: t.calendar,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            DashboardIcons.stats,
            width: 35.w,
            colorFilter: ColorFilter.mode(
              currentIndex == 2
                  ? context.themeExtension.borderColor
                  : context.themeExtension.grayColor,
              BlendMode.srcIn,
            ),
          ),
          label: t.stats,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            DashboardIcons.profile,
            width: 35.w,
            colorFilter: ColorFilter.mode(
              currentIndex == 3
                  ? context.themeExtension.borderColor
                  : context.themeExtension.grayColor,
              BlendMode.srcIn,
            ),
          ),
          label: t.profile,
        ),
      ],
    );
  }
}

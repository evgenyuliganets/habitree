import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/core/theme/extensions/theme_extension.dart';
import 'package:habitree/i18n/strings.g.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const supportedLocales = AppLocale.values;
    final items = supportedLocales
        .map(
          (e) => DropdownMenuItem<AppLocale>(
            value: e,
            child: Text(
              e.languageCode.toUpperCase(),
              textAlign: TextAlign.center,
              style: textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
        .toList();
    return Container(
      width: 120.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonFormField<AppLocale>(
         items: items,
        selectedItemBuilder: (context) => items
            .map(
              (e) => Center(
                child: Text(
                  (e.child as Text).data!,
                  textAlign: TextAlign.center,
                  style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
            .toList(),
        padding: EdgeInsets.symmetric(vertical: 5.w),
        value: LocaleSettings.currentLocale,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
          size: 20.w,
        ),
        decoration: InputDecoration(
          filled: false,
           border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (change) {
          if (change != null) {
            LocaleSettings.setLocale(change);
          }
        },
      ),
    );
  }
}

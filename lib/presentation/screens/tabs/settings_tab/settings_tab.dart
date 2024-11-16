import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/my_text_styles.dart';
import 'package:todo_app/provider/lang_provider.dart';
import 'package:todo_app/provider/theme_provider.dart';
import '../../../../core/strings_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});
  @override
  State<SettingsTab> createState() => SettingsTabState();
}

class SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.theme,
            style: AppLightStyles.settingsItemLabelTextStyle
                ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          SizedBox(
            height: 17,
          ),
          Container(
            height: 48,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).indicatorColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Text(
                  context.watch<ThemeProvider>().isLightTheme()
                      ?  AppLocalizations.of(context)!.light
                      :  AppLocalizations.of(context)!.dark,
                  style: AppLightStyles.itemViewStyle,
                ),
                Spacer(),
                DropdownButton<String>(
                  iconDisabledColor: Colors.transparent,
                  iconEnabledColor: ColorsManager.black,
                  style: AppLightStyles.dropDownItemStyle,
                  elevation: 0,
                  padding: EdgeInsets.all(0),
                  isExpanded: false,
                  items: <String>[
              AppLocalizations.of(context)!.light,
              AppLocalizations.of(context)!.dark,
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: AppLightStyles.dropDownItemStyle,
                      ),
                    );
                  }).toList(),
                  underline: SizedBox.shrink(),
                  onChanged: (newTheme) {
                    context.read<ThemeProvider>().updateAppTheme(
                        newTheme ==  AppLocalizations.of(context)!.light ? ThemeMode.light : ThemeMode.dark);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Text( AppLocalizations.of(context)!.language,
              style: AppLightStyles.settingsItemLabelTextStyle?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              )),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 48,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).indicatorColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Text(
                  context.read<LangProvider>().isLangEnglish()
                      ? AppLocalizations.of(context)!.english
                      : AppLocalizations.of(context)!.arabic,
                  style: AppLightStyles.itemViewStyle,
                ),
                Spacer(),
                DropdownButton<String>(
                  style: GoogleFonts.poppins(
                    color: ColorsManager.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                  elevation: 0,
                  padding: EdgeInsets.all(0),
                  isExpanded: false,
                  items: <String>[
    AppLocalizations.of(context)!.english,
    AppLocalizations.of(context)!.arabic,
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: AppLightStyles.dropDownItemStyle,
                      ),
                    );
                  }).toList(),
                  underline: SizedBox.shrink(),
                  onChanged: (newLanguage) {
                    context
                        .read<LangProvider>()
                        .updateLang(newLanguage ==  AppLocalizations.of(context)!.english ? 'en' : 'ar');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/my_text_styles.dart';

import '../../../../core/strings_manager.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String? selectedTheme ='Light';
  String? selectedLanguage='English' ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsManager.theme,
            style:AppLightStyles.settingsItemLabelTextStyle,
          ),
          SizedBox(
            height: 17,
          ),
          Container(
            height: 48,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Text(
                  selectedTheme ?? '',
                  style: AppLightStyles.itemViewStyle,
                ),
                Spacer(),
                DropdownButton<String>(
                  iconDisabledColor: Colors.transparent,
                  iconEnabledColor: Colors.black,
                  style:AppLightStyles.dropDownItemStyle,
                  elevation: 0,
                  padding: EdgeInsets.all(0),
                  isExpanded: false,
                  value: selectedTheme,
                  items: <String>[
                    'Light',
                    'Dark',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: AppLightStyles.dropDownItemStyle,),
                    );
                  }).toList(),
                  underline: SizedBox.shrink(),
                  onChanged: (newTheme) {
                    setState(() {
                      selectedTheme = newTheme;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            StringsManager.language,
            style: AppLightStyles.settingsItemLabelTextStyle,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 48,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Text(
                  selectedLanguage ?? '',
                  style: AppLightStyles.itemViewStyle,
                ),
                Spacer(),
                DropdownButton<String>(
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                  elevation: 0,
                  padding: EdgeInsets.all(0),
                  isExpanded: false,
                  value: selectedLanguage,
                  items: <String>[
                    'English',
                    'Arabic',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: AppLightStyles.dropDownItemStyle,),
                    );
                  }).toList(),
                  underline: SizedBox.shrink(),
                  onChanged: (newLanguage) {
                    setState(() {
                      selectedLanguage = newLanguage;
                    });
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
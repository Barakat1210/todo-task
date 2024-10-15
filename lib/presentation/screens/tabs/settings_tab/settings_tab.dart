import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/strings_manager.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String? selectedTheme ;
  String? selectedLanguage ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsManager.theme,
            style: Theme.of(context).textTheme.labelSmall,
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
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                  ),
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
                  value: selectedTheme,
                  items: <String>[
                    'Light',
                    'Dark',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
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
            style: Theme.of(context).textTheme.labelSmall,
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
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                  ),
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
                      child: Text(value),
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
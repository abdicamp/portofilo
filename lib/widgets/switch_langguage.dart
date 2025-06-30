import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSwitchToggle extends StatefulWidget {
  const LanguageSwitchToggle({Key? key}) : super(key: key);

  @override
  State<LanguageSwitchToggle> createState() => _LanguageSwitchToggleState();
}

class _LanguageSwitchToggleState extends State<LanguageSwitchToggle> {
  bool isEnglish = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Sinkronkan dengan context.locale
    setState(() {
      isEnglish = context.locale.languageCode == 'en';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 70,
      height: 30.0,
      value: isEnglish,
      borderRadius: 20.0,
      activeColor: Colors.blueAccent,
      inactiveColor: Colors.grey.shade300,
      activeText: "EN",
      inactiveText: "ID",
      showOnOff: true,
      onToggle: (val) {
        setState(() {
          isEnglish = val;
          context.setLocale(Locale(isEnglish ? 'en' : 'id'));
        });
      },
    );
  }
}

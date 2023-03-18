import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ABSIR/widgets/settings_tile.dart';

import 'home_page.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "الإعدادات",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              SettingsTile(
                color: Color.fromARGB(255, 51, 105, 148),
                icon: Ionicons.person_circle_outline,
                title: "إعدادات الحساب",
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              SettingsTile(
                color: Color.fromARGB(255, 144, 55, 164),
                icon: Ionicons.pencil_outline,
                title: "التنبيهات",
                onTap: () {},
              ),
              const SizedBox(
                height: 40,
              ),
              SettingsTile(
                color: Color.fromARGB(255, 44, 139, 179),
                icon: Ionicons.moon_outline,
                title: "عن التطبيق",
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              SettingsTile(
                color: Color.fromARGB(255, 109, 20, 125),
                icon: Ionicons.language_outline,
                title: "المساعدة",
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).popUntil(ModalRoute.withName('/root'));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: SettingsTile(
                  color: Color.fromARGB(255, 160, 13, 168),
                  icon: Ionicons.volume_medium,
                  title: "إعدادات الصوت",
                  onTap: () {
                    
                   
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SettingsTile(
                color: Color.fromARGB(255, 206, 30, 130),
                icon: Ionicons.log_out_outline,
                title: "تسجيل الخروج",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

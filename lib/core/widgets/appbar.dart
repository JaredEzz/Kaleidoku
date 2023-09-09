import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaleidoku/core/styles/text_styles.dart';
import 'package:kaleidoku/features/welcome_screen/screens/welcome_screen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenuButton;
  final bool showSettingsButton;

  const MyAppBar({
    Key? key,
    required this.title,
    this.showMenuButton = true,
    this.showSettingsButton = true,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight * 2); // Updated height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles().lThick.copyWith(color: Colors.black),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      leading: showMenuButton
          ? IconButton(
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const WelcomeScreen()),
                    (route) => false);
              },
            )
          : null,
      actions: showSettingsButton
          ? [
              const Padding(
                padding: EdgeInsets.only(
                  right: 12.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 12.0,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              ),
            ]
          : [],
      elevation: 0,
    );
  }
}

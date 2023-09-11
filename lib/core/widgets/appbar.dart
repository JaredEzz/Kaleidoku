import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaleidoku/core/styles/text_styles.dart';
import 'package:kaleidoku/features/levels_screen/screens/levels_screen.dart';
import 'package:kaleidoku/features/settings_screen/screens/settings_screen.dart';

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
        style: AppTextStyles().lThick.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      leading: showMenuButton
          ? IconButton(
              icon: Icon(
                Icons.home_outlined,
                color: Theme.of(context).iconTheme.color,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const LevelsScreen()),
                    (route) => false);
              },
            )
          : null,
      actions: showSettingsButton
          ? [
              Padding(
                padding: const EdgeInsets.only(
                  right: 12.0,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Theme.of(context).iconTheme.color,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SettingsScreen()),
                        (route) => false);
                  },
                ),
              ),
            ]
          : [],
      elevation: 0,
    );
  }
}

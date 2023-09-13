import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:kaleidoku/core/styles/sizes.dart';
import 'package:kaleidoku/core/styles/text_styles.dart';
import 'package:kaleidoku/core/utils/logger.dart';
import 'package:kaleidoku/core/utils/validators.dart';
import 'package:kaleidoku/core/widgets/app_button.dart';
import 'package:kaleidoku/core/widgets/appbar.dart';
import 'package:kaleidoku/features/settings_screen/cubits/cubit/app_settings_cubit.dart';
import 'package:kaleidoku/features/settings_screen/widgets/notification_switch.dart';
import 'package:kaleidoku/features/settings_screen/widgets/theme_switch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
          title: 'Settings', showMenuButton: true, showSettingsButton: false),
      body: SettingsScreenBody(),
    );
  }
}

class SettingsScreenBody extends StatefulWidget {
  const SettingsScreenBody({super.key});

  @override
  State<SettingsScreenBody> createState() => _SettingsScreenBodyState();
}

class _SettingsScreenBodyState extends State<SettingsScreenBody> {
  final _feedbackController = TextEditingController();
  String feedbackSubject = 'Other';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<AppSettingsCubit>().getAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PaddingSizes.mdl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("App Settings", style: AppTextStyles().lThick),
            const SizedBox(height: PaddingSizes.mdl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Theme", style: AppTextStyles().mThick),
                const SizedBox(width: PaddingSizes.xxs),
                BlocBuilder<AppSettingsCubit, AppSettingsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                        success: (appSettings) {
                          return ThemeSwitch(appSettingsModel: appSettings);
                        },
                        orElse: () => const SizedBox.shrink());
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notifications", style: AppTextStyles().mThick),
                const SizedBox(width: PaddingSizes.xxs),
                BlocBuilder<AppSettingsCubit, AppSettingsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                        success: (appSettings) {
                          return NotificationSwitch(
                              appSettingsModel: appSettings);
                        },
                        orElse: () => const SizedBox.shrink());
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: PaddingSizes.xxs),
                BlocBuilder<AppSettingsCubit, AppSettingsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                        success: (appSettings) {
                          return Visibility(
                              visible: appSettings.isNotificationsOn,
                              maintainState: true,
                              maintainAnimation: true,
                              child: AnimatedOpacity(
                                opacity:
                                    appSettings.isNotificationsOn ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 500),
                                child: TextButton(
                                    onPressed: () {
                                      DatePicker.showTimePicker(context,
                                          showSecondsColumn: false,
                                          showTitleActions: true,
                                          onConfirm: (date) {
                                        logger.d('confirm $date');
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    //TODO: convert date time to only time
                                    child: Text(
                                      appSettings.notificationsTime.toString(),
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    )),
                              ));
                        },
                        orElse: () => const SizedBox.shrink());
                  },
                ),
              ],
            ),
            const SizedBox(height: PaddingSizes.mdl),
            Text("Feedback", style: AppTextStyles().lThick),
            const SizedBox(height: PaddingSizes.mdl),
            Text('Request Help', style: AppTextStyles().mThick),
            const SizedBox(height: PaddingSizes.xs),
            DropdownButtonFormField(
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
                hint: const Text('Type of request'),
                items: const [
                  DropdownMenuItem(
                      value: 'Help using the product',
                      child: Text('Help using the product')),
                  DropdownMenuItem(
                      value: 'Report an issue', child: Text('Report an issue')),
                  DropdownMenuItem(
                      value: 'Improvement Request',
                      child: Text('Improvement Request')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: ((value) {
                  feedbackSubject = value!;
                })),
            const SizedBox(height: PaddingSizes.xs),
            TextFormField(
              validator: validateField,
              controller: _feedbackController,
              maxLines: 6,
              decoration: const InputDecoration(
                  hintText: 'How can we help you?',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: PaddingSizes.sm, horizontal: PaddingSizes.sm),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  )),
            ),
            const SizedBox(height: PaddingSizes.sm),
            isLoading
                ? const CircularProgressIndicator()
                : AppButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        final Email email = Email(
                          body: _feedbackController.text.trim(),
                          subject: feedbackSubject,
                          recipients: ['jaredezzethasson@gmail.com'],
                          isHTML: false,
                        );

                        try {
                          await FlutterEmailSender.send(email);
                        } catch (e) {
                          if (e is PlatformException &&
                              e.code == "not_available") {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("No email clients available!"),
                              ),
                            );
                          } else {
                            rethrow;
                          }
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    title: 'Submit',
                  )
          ],
        ),
      ),
    );
  }
}

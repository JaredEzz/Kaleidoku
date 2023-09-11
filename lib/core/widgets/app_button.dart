import 'package:flutter/material.dart';
import 'package:kaleidoku/core/styles/sizes.dart';
import 'package:kaleidoku/core/utils/extensions/context.dart';

/// Standard [Button Widget] for use within the app
class AppButton extends StatelessWidget {
  const AppButton({
    required this.onTap,
    required this.title,
    this.color,
    this.titleWidget,
    this.titleColor,
    this.fontSize,
    this.width,
    this.height,
    this.padding,
    this.isSecondayColor = false,
    this.loading = false,
    this.enabled = true,
    this.boxDecoration,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final String title;
  final double? width;
  final double? height;
  final Color? color;
  final Color? titleColor;
  final bool isSecondayColor;
  final double? fontSize;
  final Widget? titleWidget;
  final bool loading;
  final bool enabled;
  final BoxDecoration? boxDecoration;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? () {} : onTap,
      child: ClipRRect(
        borderRadius: kStandardBorderRadius,
        child: Container(
          width:
              width ?? MediaQuery.sizeOf(context).width * kDefaultButtonWidth,
          height: height,
          decoration: boxDecoration ??
              BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: (color ?? Theme.of(context).colorScheme.primary)
                          .withOpacity((onTap != null && enabled) ? 1 : 0.2)),
                  color: isSecondayColor
                      ? null
                      : (color ?? context.primaryColor)
                          .withOpacity((onTap != null && enabled) ? 1 : 0.5),
                  borderRadius: kStandardBorderRadius),
          padding: padding ??
              const EdgeInsets.symmetric(
                  horizontal: PaddingSizes.sm, vertical: PaddingSizes.xs),
          child: Center(
            child: loading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(title,
                            textAlign: TextAlign.center,
                            style: textStyle ??
                                context.textStyles.sThick.copyWith(
                                  fontSize: fontSize,
                                  color: isSecondayColor
                                      ? titleColor ?? context.primaryColor
                                      : titleColor ?? Colors.white,
                                )),
                      ),
                      if (titleWidget != null) ...[
                        const SizedBox(width: PaddingSizes.xs),
                        titleWidget!
                      ]
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

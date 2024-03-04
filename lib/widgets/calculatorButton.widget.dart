import 'package:flutter/widgets.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:fly_ui/views/widgets/containers/container.widget.dart';
import 'package:fly_ui/views/widgets/inkWell.widget.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CalculatorButtonWidget extends StatelessWidget {
  const CalculatorButtonWidget({
    super.key,
    required this.value,
    required this.onPressed,
    required this.height,
    required this.width,
    this.color,
    this.backgroundColor,
    this.disabled = false,
  });

  final dynamic value;
  final Function onPressed;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? color;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FlyInkWell(
      onTap: disabled ? null : onPressed,
      child: Opacity(
        opacity: disabled ? 0.5 : 1,
        child: SizedBox(
          width: width,
          height: height,
          child: FlyContainer(
            color: backgroundColor,
            child: Center(
              child: value is String
                  ? AutoSizeText(
                      value,
                      style: Get.textTheme.headlineLarge!.copyWith(
                        color: color,
                        fontSize: 25.sp,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    )
                  : Icon(
                      value,
                      color: color,
                      size: 25.sp,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

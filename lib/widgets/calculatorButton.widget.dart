import 'package:flutter/widgets.dart';
import 'package:fly_ui/views/widgets/containers/container.widget.dart';
import 'package:fly_ui/views/widgets/inkWell.widget.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.value,
    required this.onPressed,
    required this.height,
    required this.width,
    this.color,
    this.backgroundColor,
  });

  final dynamic value;
  final Function onPressed;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    print('$value => $width');

    return SizedBox(
      width: width,
      height: height,
      child: FlyInkWell(
        onTap: onPressed,
        child: FlyContainer(
          color: backgroundColor,
          child: Center(
            child: value is String
                ? AutoSizeText(
                    value,
                    style: Get.textTheme.headlineLarge!.copyWith(color: color),
                    maxLines: 1,
                    minFontSize: 15,
                    maxFontSize: Get.textTheme.headlineLarge!.fontSize!,
                  )
                : Icon(
                    value,
                    color: color,
                    size: 30,
                  ),
          ),
        ),
      ),
    );
  }
}

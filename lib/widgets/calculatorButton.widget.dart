
import 'package:flutter/widgets.dart';
import 'package:fly_ui/views/widgets/buttons/circalButton.widget.dart';
import 'package:fly_ui/views/widgets/buttons/circalTextButton.widget.dart';
import 'package:get/get.dart';


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
    return SizedBox(
      width: width,
      height: height,
      child: value is String
          ? FlyTextCircleButton(
              color: backgroundColor,
              borderColor: color,
              onPressed: onPressed,
              child: Text(
                value,
                style: Get.textTheme.headlineSmall!
                    .copyWith(height: 1.4, color: color),
              ),
            )
          : FlyCircleButton(
              icon: value,
              onPressed: onPressed,
              color: backgroundColor,
              colorIcon: color,
            ),
    );
  }
}

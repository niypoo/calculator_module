
import 'package:flutter/widgets.dart';
import 'package:fly_ui/views/widgets/buttons/circalTextButton.widget.dart';
import 'package:get/get.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.value,
    required this.onPressed,
  });

  final String value;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlyTextCircleButton(
      onPressed: onPressed,
      child: Text(
        value,
        style: Get.textTheme.headlineLarge!.copyWith(height: 1.4),
      ),
    );
  }
}

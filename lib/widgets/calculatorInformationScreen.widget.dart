import 'package:flutter/material.dart';
import 'package:fly_ui/views/widgets/containers/container.widget.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CalculatorInformationScreenWidget extends StatelessWidget {
  const CalculatorInformationScreenWidget({
    super.key,
    required this.number,
    this.title,
    this.label,
    this.hint,
  });

  final String number;
  final String? label;
  final Widget? title;
  final Widget? hint;

  @override
  Widget build(BuildContext context) {
    return FlyContainer(
      child: SizedBox(
        height: Get.height * 0.25,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Number
            Flexible(
              child: AutoSizeText.rich(
                TextSpan(
                  text: number,
                  children: [
                    if (label != null) const TextSpan(text: ' '),
                    if (label != null)
                      TextSpan(
                        text: label,
                        style: Get.theme.textTheme.labelLarge
                            ?.copyWith(fontWeight: FontWeight.w300),
                      ),
                  ],
                ),
                style:
                    Get.theme.textTheme.headlineLarge!.copyWith(fontSize: 60),
                maxLines: 1,
              ),
            ),

            // title
            if (title != null) title!,

            // hint
            if (hint != null) hint!,
          ],
        ),
      ),
    );
  }
}

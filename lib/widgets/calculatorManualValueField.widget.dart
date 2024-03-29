import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:app_configuration_service/appInfo.config.dart';
import 'package:flutter/material.dart';
import 'package:fly_ui/views/widgets/buttons/elevatedButton.widget.dart';
import 'package:fly_ui/views/widgets/buttons/iconButton.widget.dart';
import 'package:fly_ui/views/widgets/buttons/textButton.widget.dart';
import 'package:fly_ui/views/widgets/textField.widget.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class CalculatorManualValueFieldWidget extends StatelessWidget {
  const CalculatorManualValueFieldWidget({
    Key? key,
    this.controller,
    this.label,
    this.onConfirm,
    this.onReset,
  }) : super(key: key);

  final TextEditingController? controller;
  final Function? onConfirm;
  final Function? onReset;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: AppConfigService.to.space!.m),
            child: FlyTextField(
              controller: controller,
              labelText: label,
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
              onFieldSubmitted: (_) => onConfirm!(),
              suffix: [
                FlyIconButton.scaffold(
                  icon: UniconsLine.times,
                  onPressed: onReset,
                ),
              ],
            ),
          ),
          FlyElevatedButton.primary(
            title: 'Confirm'.tr,
            onPressed: onConfirm,
          ),
          FlyTextButton(
            title: 'Cancel'.tr,
            onTap: () => Get.back(),
          )
        ],
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int? decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange!) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}

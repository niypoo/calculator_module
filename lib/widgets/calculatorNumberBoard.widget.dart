import 'package:calculator_module/widgets/calculatorButton.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:vibration_helper/vibration.helper.dart';

class CalculatorNumberBoardWidget extends StatefulWidget {
  const CalculatorNumberBoardWidget({
    super.key,
    required this.initValue,
    required this.onChange,
    required this.onSave,
    this.fractionDigits = 2,
  });

  final double initValue;
  final int fractionDigits;
  final Function(double value) onChange;
  final Function onSave;

  @override
  State<CalculatorNumberBoardWidget> createState() =>
      _CalculatorNumberBoardWidgetState();
}

class _CalculatorNumberBoardWidgetState
    extends State<CalculatorNumberBoardWidget> {
  bool enableDouble = false;

  @override
  void initState() {
    super.initState();
  }

  void onCalculatorChange(String value) {
    // define old value
    String oldValue = '';

    // if double is enabled
    if (enableDouble) {
      // get decimal number
      double x = widget.initValue.toDouble() - widget.initValue.toInt();

      // if decimal less then 0
      oldValue = x <= 0
          // get only init numbers and add dot
          ? '${widget.initValue.toInt()}.'
          // get the full number
          : widget.initValue.toDouble().toString();
    } else {
      // add new number to full number
      oldValue = widget.initValue.toInt().toString();
    }

    // define new value
    String newValue =
        double.parse('$oldValue$value').toStringAsFixed(widget.fractionDigits);

    // callback
    widget.onChange(double.parse(newValue));

    VibrationHelper.haptic();
  }

  void onDoubleEnableTap() {
    setState(() {
      enableDouble = !enableDouble;
    });
    VibrationHelper.haptic();
  }

  void onClearTap() {
    enableDouble = false;
    String newValue = '0.0';
    widget.onChange(double.parse(newValue));
    VibrationHelper.haptic();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      final maxHeight = ((constraints.maxHeight - 15) / 4);
      final maxWidth = (constraints.maxWidth - 30) / 4;

      return Row(
        children: [
          Expanded(
            child: Wrap(
              runSpacing: 5,
              spacing: 10,
              children: [
                CalculatorButtonWidget(
                  value: '9',
                  onPressed: () => onCalculatorChange('9'),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '8',
                  onPressed: () => onCalculatorChange('8'),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '7',
                  onPressed: () => onCalculatorChange('7'),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '6',
                  onPressed: () => onCalculatorChange('6'),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '5',
                  onPressed: () => onCalculatorChange('5'),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '4',
                  onPressed: () => onCalculatorChange('4'),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '3',
                  onPressed: () => onCalculatorChange('3'),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '2',
                  onPressed: () => onCalculatorChange('2'),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '1',
                  onPressed: () => onCalculatorChange('1'),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  backgroundColor:
                      enableDouble ? Get.theme.colorScheme.secondary : null,
                  color: enableDouble ? Get.theme.secondaryHeaderColor : null,
                  value: '.',
                  onPressed: onDoubleEnableTap,
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '0',
                  onPressed: () => onCalculatorChange('0'),
                  height: maxHeight,
                  width: (maxWidth + 5) * 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              CalculatorButtonWidget(
                value: UniconsLine.times,
                onPressed: onClearTap,
                height: maxHeight,
                width: maxWidth,
                backgroundColor: Colors.red[400],
                color: Get.theme.secondaryHeaderColor,
              ),
              const SizedBox(height: 5),
              CalculatorButtonWidget(
                backgroundColor: Get.theme.primaryColor,
                color: Get.theme.secondaryHeaderColor,
                value: UniconsLine.check,
                onPressed: widget.onSave,
                height: (maxHeight + 3) * 3,
                width: maxWidth,
              ),
            ],
          ),
        ],
      );
    });
  }
}

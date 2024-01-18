import 'package:calculator_module/widgets/calculatorButton.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
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

  final num initValue;
  final int fractionDigits;
  final Function(num value) onChange;
  final Function onSave;

  @override
  State<CalculatorNumberBoardWidget> createState() =>
      _CalculatorNumberBoardWidgetState();
}

class _CalculatorNumberBoardWidgetState
    extends State<CalculatorNumberBoardWidget> {
  String current = '0';
  bool enableDouble = false;

  @override
  void initState() {
    current = widget.initValue.toString();
    super.initState();
  }

  void onCalculatorChange(String value) {
    print('[[[[current $current]]]]');
    // add new number to full number
    current = '$current$value';

    // callback
    widget.onChange(num.parse(current));
    print('[[[[fractionDigits ${num.parse(current)}]]]]');
    VibrationHelper.haptic();
  }

  void onDoubleEnableTap() {
    setState(() {
      enableDouble = !enableDouble;
      if (enableDouble) {
        if (!current.contains('.')) current = '$current.';
      } else {
        current = current.replaceFirst('.', '');
      }
    });
    VibrationHelper.haptic();
  }

  void onRemoveTap() {
    print('[[[[current $current]]]]');
    if (current.isEmpty) return onClearTap();

    current = current.substring(0, current.length - 1);

    // in case last dicmal has remove @ remove . also
    if (current.substring(current.length - 1) == '.') {
      current = current.substring(0, current.length - 1);
    }

    print('[[[[substring $current]]]]');
    // callback
    widget.onChange(num.parse(current.isEmpty ? '0' : current));
  }

  void onClearTap() {
    enableDouble = false;
    current = '0';
    widget.onChange(num.parse(current));
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
              runSpacing: 5.sp,
              spacing: 5.sp,
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
          SizedBox(width: 5.sp),
          Column(
            children: [
              CalculatorButtonWidget(
                value: UniconsLine.cancel,
                onPressed: onRemoveTap,
                height: maxHeight,
                width: maxWidth,
              ),
              SizedBox(height: 5.sp),
              CalculatorButtonWidget(
                value: 'C',
                onPressed: onClearTap,
                height: maxHeight,
                width: maxWidth,
                backgroundColor: Colors.red[400],
                color: Get.theme.secondaryHeaderColor,
              ),
              SizedBox(height: 5.sp),
              CalculatorButtonWidget(
                backgroundColor: Get.theme.primaryColor,
                color: Get.theme.secondaryHeaderColor,
                value: UniconsLine.check,
                onPressed: widget.onSave,
                height: (maxHeight * 2),
                width: maxWidth,
              ),
            ],
          ),
        ],
      );
    });
  }
}

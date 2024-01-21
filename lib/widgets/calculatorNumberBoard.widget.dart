import 'package:calculator_module/widgets/calculatorButton.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fly_ui/extensions/responsive.extension.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class CalculatorNumberBoardWidget extends StatefulWidget {
  const CalculatorNumberBoardWidget({
    super.key,
    required this.initValue,
    required this.onChange,
    required this.onSave,
    this.fractionDigits = 2,
    this.maxLength = 9,
  });

  final num initValue;
  final int fractionDigits;
  final int maxLength;
  final Function(num value) onChange;
  final Function onSave;

  @override
  State<CalculatorNumberBoardWidget> createState() =>
      _CalculatorNumberBoardWidgetState();
}

class _CalculatorNumberBoardWidgetState
    extends State<CalculatorNumberBoardWidget> {
  //current number of calculator
  String current = '0';

  // decimale
  bool enableDecimale = false;

  @override
  void initState() {
    current = widget.initValue.toString();
    super.initState();
  }

  // max length is reached
  bool get isMaxLimit => widget.maxLength <= current.length;

  // if decimal enabled and fractionDigits reach out the limit
  bool get isFractionLimit =>
      current.contains('.') &&
      current.split('.')[1].length <= widget.fractionDigits;

  // ADD Integer to number of calculator
  void addInteger(int value) {
    // max length is reached
    if (isMaxLimit) return;

    // if decimal enabled and fractionDigits reach out the limit
    if (isFractionLimit) return;

    // add new number to full number
    current = '$current$value';

    // callback
    widget.onChange(num.parse(current));
  }

  // Enable Decimal and add
  void onEnableDecimal() {
    setState(() {
      enableDecimale = !enableDecimale;
    });

    // if enabled
    if (enableDecimale) {
      // check if there . if not add .
      if (!current.contains('.')) current = '$current.';
    }
  }

  // remove last chractor of calculator
  void remove() {
    // skip
    if (current.isEmpty) return clear();

    // remove last chracter
    current = current.substring(0, current.length - 1);

    // in case last dicmal has remove @ remove . also
    if (current.isNotEmpty && current.substring(current.length - 1) == '.') {
      current = current.substring(0, current.length - 1);
    }

    // callback
    widget.onChange(num.parse(current.isEmpty ? '0' : current));
  }

  // clear whole number of calculator
  void clear() {
    setState(() {
      enableDecimale = false;
    });
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
                  onPressed: () => addInteger(9),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '8',
                  onPressed: () => addInteger(8),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '7',
                  onPressed: () => addInteger(7),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '6',
                  onPressed: () => addInteger(6),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '5',
                  onPressed: () => addInteger(5),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '4',
                  onPressed: () => addInteger(4),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '3',
                  onPressed: () => addInteger(3),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '2',
                  onPressed: () => addInteger(2),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '1',
                  onPressed: () => addInteger(1),
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  backgroundColor:
                      enableDecimale ? Get.theme.colorScheme.secondary : null,
                  color: enableDecimale ? Get.theme.secondaryHeaderColor : null,
                  value: '.',
                  onPressed: onEnableDecimal,
                  height: maxHeight,
                  width: maxWidth,
                ),
                CalculatorButtonWidget(
                  value: '0',
                  onPressed: () => addInteger(0),
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
                onPressed: remove,
                height: maxHeight,
                width: maxWidth,
              ),
              SizedBox(height: 5.sp),
              CalculatorButtonWidget(
                value: 'C',
                onPressed: clear,
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

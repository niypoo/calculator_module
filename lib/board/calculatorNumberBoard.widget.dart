import 'package:calculator_module/widgets/calculatorButton.widget.dart';
import 'package:flutter/widgets.dart';
import 'package:unicons/unicons.dart';



class CalculatorNumberBoardWidget extends StatefulWidget {
  const CalculatorNumberBoardWidget({
    super.key,
    required this.initValue,
    required this.onChange,
    this.fractionDigits = 2,
  });

  final double initValue;
  final int fractionDigits;
  final Function(double value) onChange;

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
  }

  void onDoubleEnableTap() {
    enableDouble = true;
  }

  void onClearTap() {
    enableDouble = false;
    String newValue = '0.0';
    widget.onChange(double.parse(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      final maxHeight = ((constraints.maxHeight - 15) / 4);
      final maxWidth = (constraints.maxWidth - 30) / 3;

      return Wrap(
        runSpacing: 5,
        spacing: 10,
        children: [
          CalculatorButton(
            value: '9',
            onPressed: () => onCalculatorChange('1'),
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: '8',
            onPressed: () => onCalculatorChange('8'),
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: '7',
            onPressed: () => onCalculatorChange('7'),
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: '6',
            onPressed: () => onCalculatorChange('6'),
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: '5',
            onPressed: () => onCalculatorChange('5'),
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: '4',
            onPressed: () => onCalculatorChange('4'),
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: '3',
            onPressed: () => onCalculatorChange('3'),
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: '2',
            onPressed: () => onCalculatorChange('2'),
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: '1',
            onPressed: () => onCalculatorChange('1'),
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: UniconsLine.cancel,
            onPressed: onClearTap,
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: '0',
            onPressed: () => onCalculatorChange('0'),
            height: maxHeight,
            width: maxWidth,
          ),
          CalculatorButton(
            value: '.',
            onPressed: onDoubleEnableTap,
            height: maxHeight,
            width: maxWidth,
          ),
        ],
      );
    });
  }
}

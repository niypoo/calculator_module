import 'package:calculator_module/widgets/calculatorButton.widget.dart';
import 'package:flutter/widgets.dart';

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
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2,
      crossAxisCount: 3,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      children: [
        CalculatorButton(
          value: '9',
          onPressed: () => onCalculatorChange('1'),
        ),
        CalculatorButton(
          value: '8',
          onPressed: () => onCalculatorChange('8'),
        ),
        CalculatorButton(
          value: '7',
          onPressed: () => onCalculatorChange('7'),
        ),
        CalculatorButton(
          value: '6',
          onPressed: () => onCalculatorChange('6'),
        ),
        CalculatorButton(
          value: '5',
          onPressed: () => onCalculatorChange('5'),
        ),
        CalculatorButton(
          value: '4',
          onPressed: () => onCalculatorChange('4'),
        ),
        CalculatorButton(
          value: '3',
          onPressed: () => onCalculatorChange('3'),
        ),
        CalculatorButton(
          value: '2',
          onPressed: () => onCalculatorChange('2'),
        ),
        CalculatorButton(
          value: '1',
          onPressed: () => onCalculatorChange('1'),
        ),
        CalculatorButton(
          value: 'C',
          onPressed: onClearTap,
        ),
        CalculatorButton(
          value: '0',
          onPressed: () => onCalculatorChange('0'),
        ),
        CalculatorButton(
          value: '.',
          onPressed: onDoubleEnableTap,
        ),
      ],
    );
  }
}

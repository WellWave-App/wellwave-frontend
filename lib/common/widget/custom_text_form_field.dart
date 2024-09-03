import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String? suffixText;
  final TextInputType? keyboardType;

  CustomTextFormField({
    required this.labelText,
    this.suffixText,
    this.keyboardType,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      inputFormatters: _getInputFormatters(),
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixText: widget.suffixText,
        labelStyle: _isFocused
            ? Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.bluegrayColor,
                )
            : Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.grayColor,
                ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.grayColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        suffixStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.darkgrayColor,
            ),
      ),
    );
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (widget.keyboardType == TextInputType.number) {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ];
    }

    return null;
  }
}

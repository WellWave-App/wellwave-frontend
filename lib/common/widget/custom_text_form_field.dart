import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? suffixText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String initialValue;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.suffixText,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.initialValue = '',
    this.inputFormatters,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: _controller,
      keyboardType: widget.keyboardType,
      inputFormatters: _getInputFormatters(),
      style: Theme.of(context).textTheme.titleSmall,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.darkgrayColor,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: widget.suffixText,
        labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.bluegrayColor,
            ),
        suffixStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.darkgrayColor,
            ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.grayColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        filled: true,
        fillColor: AppColors.whiteColor,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  List<TextInputFormatter>? _getInputFormatters() {
    List<TextInputFormatter>? formatters = widget.inputFormatters;

    if (widget.keyboardType == TextInputType.number) {
      formatters = (formatters ?? [])
        ..add(FilteringTextInputFormatter.digitsOnly);
    }

    return formatters;
  }
}

import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final int maxLines;
  final TextEditingController controller;
  final Function validation;

  const CustomInput({
    Key? key,
    required this.label,
    required this.maxLines,
    required this.controller,
    required this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      validator: (value) => validation.call(value),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1)),
        focusColor: Theme.of(context).colorScheme.primary,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
      ),
    );
  }
}

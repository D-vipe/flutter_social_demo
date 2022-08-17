// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:email_validator/email_validator.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/app/uikit/form_elements/custom_input.dart';

class BottomSheetForm extends StatefulWidget {
  final Function sendForm;
  const BottomSheetForm({Key? key, required this.sendForm}) : super(key: key);

  @override
  State<BottomSheetForm> createState() => _BottomSheetFormState();
}

class _BottomSheetFormState extends State<BottomSheetForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerComment = TextEditingController();

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return AppDictionary.fillInput;
    } else {
      return EmailValidator.validate(value) ? null : AppDictionary.wrongEmail;
    }
  }

  String? emptyValueValidator(value) {
    if (value == null || value.isEmpty) {
      return AppDictionary.fillInput;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        color: AppColors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomInput(
                  label: AppDictionary.name,
                  controller: _controllerName,
                  validation: emptyValueValidator,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                CustomInput(
                  label: AppDictionary.email,
                  controller: _controllerEmail,
                  validation: emailValidator,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                CustomInput(
                  label: AppDictionary.comment,
                  controller: _controllerComment,
                  validation: emptyValueValidator,
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_formKey.currentState!.validate()) {
                        widget.sendForm(_controllerName.text,
                            _controllerEmail.text, _controllerComment.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      AppDictionary.send,
                      style: AppTextStyle.comforta16W400
                          .apply(color: AppColors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

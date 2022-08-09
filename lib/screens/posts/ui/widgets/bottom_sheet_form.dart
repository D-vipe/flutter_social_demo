// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:email_validator/email_validator.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';

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
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppDictionary.fillInput;
                    }
                    return null;
                  },
                  controller: _controllerName,
                  decoration: const InputDecoration(
                    labelText: AppDictionary.name,
                    floatingLabelStyle: TextStyle(color: AppColors.mainTheme),
                    border: OutlineInputBorder(),
                    focusColor: AppColors.mainTheme,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.mainTheme, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppDictionary.fillInput;
                    } else {
                      return EmailValidator.validate(value)
                          ? null
                          : AppDictionary.wrongEmail;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: AppDictionary.email,
                    floatingLabelStyle: TextStyle(color: AppColors.mainTheme),
                    border: OutlineInputBorder(),
                    focusColor: AppColors.mainTheme,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.mainTheme, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 3,
                  controller: _controllerComment,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppDictionary.fillInput;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: AppDictionary.comment,
                    floatingLabelStyle: TextStyle(color: AppColors.mainTheme),
                    border: OutlineInputBorder(),
                    focusColor: AppColors.mainTheme,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.mainTheme, width: 2),
                    ),
                  ),
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
                    style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.mainTheme),
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

// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, strict_top_level_inference, file_names
import 'package:flutter/material.dart';

class InnerShadowTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String title;
  final TextInputType keyboardType;
  final bool readOnly;
  final void Function() onTap;
  var validator;
  String? validatorText;
  int? maxLines;
  double? width;
  int? maxLength;
  TextInputAction? textInputAction;
  Widget? suffixIcon;
  Function(String)? onChanged;
  InnerShadowTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.title,
      required this.keyboardType,
      required this.readOnly,
      required this.onTap,
      this.validator,
      this.validatorText,
      this.maxLines,
      this.width,
      this.maxLength,
      this.textInputAction,
      this.suffixIcon,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
                fontFamily: "Geist",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff414651)),
          ),
        ),
        Container(
          width: width,
          decoration: BoxDecoration(
            color: const Color(0xffe7eef3),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: -const Offset(5, 5),
                blurRadius: 6,
                spreadRadius: 1,
              ),
              const BoxShadow(
                color: Color(0xFFBFC9D5),
                offset: Offset(4.5, 4.5),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: TextFormField(
            onChanged: onChanged,
            textInputAction: textInputAction,
            maxLength: maxLength,
            maxLines: maxLines,
            validator: validator ??
                (value) {
                  if (value == null || value.trim().isEmpty) {
                    return validatorText;
                  }
                  return null;
                },
            onTap: onTap,
            readOnly: readOnly,
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: TextStyle(
                  fontFamily: "Geist",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8B9EB0)),
              filled: true,
              fillColor: Colors.white,
             // fillColor: const Color(0xffe7eef3),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(
              fontSize: 14,
              fontFamily: "Geist",
            ),
          ),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_text.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.textController,
    this.prefix,
    this.onChanged,
    this.validator,
    this.textInputType = TextInputType.name,
    this.textCapitalization = TextCapitalization.words,
    this.inputFormatters,
  }) : super(key: key);

  final String hintText;
  final String? prefix;
  final TextEditingController textController;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          cursorColor: Colors.teal,
          validator: validator,
          onChanged: onChanged,
          controller: textController,
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: prefix != null
                ? Container(
                    padding: const EdgeInsets.only(top: .5),
                    width: 30,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        text: prefix ?? '',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.teal,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.teal,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.teal,
              ),
            ),

          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

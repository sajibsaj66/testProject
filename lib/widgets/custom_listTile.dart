import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    this.subTitle,
    this.anotherSubTitle,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final String? anotherSubTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: CustomText(
        text: title,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        textColor: Colors.teal,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomText(
            text: subTitle!,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textColor: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomText(
            text: subTitle!,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            textColor: Colors.grey,
          ),
        ],
      ),
      onTap: onPressed,
    );
  }
}

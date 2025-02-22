import 'package:flutter/material.dart';

class MyTextfieldWidget extends StatelessWidget {
  MyTextfieldWidget(
      {super.key,
      this.controller,
      this.hintText,
      this.labelText,
      this.keyboardType});
  TextEditingController? controller = TextEditingController();
  String? labelText;
  String? hintText;
  TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          label: Text(labelText ?? 'Enter text'),
          hintText: hintText ?? 'Enter text',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }
}

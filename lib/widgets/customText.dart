// ignore: file_names
import "package:flutter/material.dart";

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.hint,
      this.icon,
      this.onTap,
      this.readOnly = false,
      this.onChanged,
      this.controller});

  final String hint;
  final IconData? icon;
  final void Function()? onTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            suffixIcon: InkWell(
                onTap: onTap,
                child: Icon(
                  icon,
                  color: Colors.white,
                )),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
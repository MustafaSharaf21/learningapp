
import 'package:flutter/material.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton({super.key,this.text, required this.onTap});
  final String? text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 150,
        decoration: BoxDecoration(
          color: const Color(0xFF399679),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(text!,style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500
          ),),
        ),
      ),
    );
  }

}

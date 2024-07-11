import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
  });
  final String title;
  final void Function()? onTap;
  final Icon? icon;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(colors: [Color(0xff67B26F), Color(0xff4ca2cd)]),
            border: Border.all(color: Colors.blue)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: widget.icon,
              ),
            Text(
              widget.title.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

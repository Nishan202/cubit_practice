import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onClick;
  final bool loading;
  const CustomButton({super.key, required this.title, this.loading=false, required this.onClick});

  static ButtonStyle buttonPrimary = OutlinedButton.styleFrom(
    foregroundColor: Colors.green,
    side: const BorderSide(color: Colors.green),
    minimumSize: const Size(335, 45),
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50))
    )
);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xff002967),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(child: loading ? const CircularProgressIndicator(strokeWidth: 3, color: Colors.white,) : Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),),
      ),
    );
  }
}
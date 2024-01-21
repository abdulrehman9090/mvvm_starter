import 'package:flutter/material.dart';
import 'package:mvvm_theme_switching/res/AppColors.dart';
import 'package:mvvm_theme_switching/utils/LoggerHelpers.dart';

class CustomButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPress;
  final String text;
  const CustomButton({super.key, required this.loading, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          height: 50,
          width: 130,
          decoration: BoxDecoration(
              color: resolveCustomColor(context: context, lightColor: AppColors.primaryColorLight, darkColor: AppColors.primaryColorDark),
              borderRadius: BorderRadius.circular(100)
          ),
          child: loading ? const Center(child: SizedBox( height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white,))) : Center(child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))
      ),
    );
  }
}

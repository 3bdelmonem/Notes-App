import 'package:flutter/material.dart';

showLoading(BuildContext context) {
     showDialog(
      barrierDismissible: false,
      barrierColor: Color(0xFF0F0F1E).withOpacity(0.9),
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Center(child: CircularProgressIndicator(color: Color(0xFF6034A6), strokeWidth: 6,))
        );
      },
    );
  }
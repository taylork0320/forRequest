import 'package:flutter/material.dart';

import '../styles/color_styles.dart';

class CommonTimePicker extends StatelessWidget {
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeSelected;

  const CommonTimePicker({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: selectedTime,
        );
        if (picked != null) {
          onTimeSelected(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: ColorStyles.primaryBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${selectedTime.format(context)}',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}

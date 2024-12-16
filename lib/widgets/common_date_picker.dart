import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../styles/color_styles.dart';

class CommonDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CommonDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2025),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: ColorStyles.primaryBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          DateFormat('yyyy. MM. dd').format(selectedDate),
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

import 'package:flutter/material.dart';

import '../enums/experiment_type.dart';
import '../styles/color_styles.dart';

// 단일 태그 아이템을 위한 위젯
class TagItem extends StatelessWidget {
  final String text;
  final ExperimentType type;
  final bool isPrimary; // 첫 번째 아이템 여부
  final bool isLarge;

  const TagItem({
    super.key,
    required this.text,
    required this.type,
    this.isPrimary = false,
    this.isLarge = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: isLarge
                ? ColorStyles.primaryBlue
                : isPrimary
                    ? type.tagBackgroundColor
                    : ColorStyles.tagBackground,
            borderRadius: BorderRadius.circular(isLarge ? 24 : 15)),
        padding: EdgeInsets.symmetric(
            vertical: isLarge ? 14 : 4,
            horizontal: isLarge ? 16 : 6,
        ),
        child: Text(
          isLarge ? text : '#$text',
          style: TextStyle(
              fontSize: isLarge ? 14 : 9,
              color: isLarge
                  ? Colors.white
                  : isPrimary
                      ? type.tagForegroundColor
                      : ColorStyles.tagForeground),
        )
    );
  }
}

// 태그 목록을 관리하는 위젯
class TagList extends StatelessWidget {
  final List<String> tags;
  final ExperimentType type;
  final bool isLarge;

  const TagList({
    super.key,
    required this.tags,
    required this.type,
    this.isLarge = false
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: isLarge ? 8 : 5,
      runSpacing: 5,
      children: List.generate(
        tags.length,
            (index) => TagItem(
          text: tags[index],
          type: type,
          isPrimary: index == 0,
          isLarge: isLarge,
        ),
      ),
    );
  }
}
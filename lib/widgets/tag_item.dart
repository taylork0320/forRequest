import 'package:flutter/material.dart';

import '../enums/experiment_type.dart';
import '../styles/color_styles.dart';

// 단일 태그 아이템을 위한 위젯
class TagItem extends StatelessWidget {
  final String text;
  final ExperimentType type;
  final bool isPrimary; // 첫 번째 아이템 여부

  const TagItem({
    super.key,
    required this.text,
    required this.type,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: isPrimary ? type.tagBackgroundColor : ColorStyles.tagBackground,
            borderRadius: BorderRadius.circular(15)
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Text(
          '#$text',
          style: TextStyle(
              fontSize: 9,
              color: isPrimary ? type.tagForegroundColor : ColorStyles.tagForeground
          ),
        )
    );
  }
}

// 태그 목록을 관리하는 위젯
class TagList extends StatelessWidget {
  final List<String> tags;
  final ExperimentType type;

  const TagList({
    super.key,
    required this.tags,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: List.generate(
        tags.length,
            (index) => TagItem(
          text: tags[index],
          type: type,
          isPrimary: index == 0,
        ),
      ),
    );
  }
}
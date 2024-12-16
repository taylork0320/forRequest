import 'package:flutter/material.dart';
import 'package:sasimee/widgets/tag_item.dart';

import '../../../enums/experiment_type.dart';
import '../../../styles/color_styles.dart';

class PerformItem extends StatelessWidget {
  final String title; //TODO: Perform 데이터로 변경

  const PerformItem({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container( // 실험 주체 사진 등록
            width: double.infinity,
            height: 46,
            color: ColorStyles.tagBackground,
          ),
          const SizedBox(height: 10,),
          Text('One-line Explanation',
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: ColorStyles.gray80
            ),
          ),
          const SizedBox(height: 3,),
          Text(title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.2
            ),
          ),
          const SizedBox(height: 10,),
          Text('성남시 복정동',
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: ColorStyles.gray70
            ),
          ),
          const SizedBox(height: 10,),
          const TagList(
              type: ExperimentType.perform,
              tags: ['수행형', '친구랑']
          )
        ],
      ),
    );
  }
}
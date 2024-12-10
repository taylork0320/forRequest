import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/widgets/tag_item.dart';

import '../../../enums/experiment_type.dart';
import '../../../styles/color_styles.dart';

class PerformLargeItem extends StatelessWidget {
  final String title; //TODO: Perform 데이터로 변경

  const PerformLargeItem({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _basicInformationLayout(),
          const Divider(thickness: 0.5, height: 0.5, color: ColorStyles.dividerBackground,),
          _bottomAdditionalInformationLayout()
        ],
      ),
    );
  }

  Widget _basicInformationLayout() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '㈜네심이',
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: ColorStyles.subText
            ),
          ),
          const SizedBox(height: 7,),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 10,),
          const TagList(
              type: ExperimentType.perform,
              tags: ['수행형', '20대', '성별무관', '사회적 행동', '심리']
          )
        ],
      ),
    );
  }

  Widget _bottomAdditionalInformationLayout() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(
        children: [
          Text(
            '경기도 성남시 수정구 복정동 · ',
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: ColorStyles.subText
            ),
          ),
          const Text(
            '건',
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: ColorStyles.primaryBlue
            ),
          ),
          const SizedBox(width: 4,),
          Text(
            'price'.tr(
              namedArgs: {"price": NumberFormat('###,###').format(10000)}
            ),
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: ColorStyles.subText
            ),
          ),
        ],
      ),
    );
  }
}

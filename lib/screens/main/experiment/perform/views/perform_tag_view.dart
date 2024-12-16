import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../enums/experiment_type.dart';
import '../../../../../widgets/tag_item.dart';

class PerformTagView extends StatelessWidget {
  const PerformTagView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32,),
            Text("perform_tag_list".tr(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20
              ),
            ),
            const SizedBox(height: 32,),
            /// 대상 성별
            Text("target_gender".tr(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 8,),
            const TagList(
              type: ExperimentType.perform,
              tags: ['성별무관'],
              isLarge: true,
            ),
            const SizedBox(height: 32,),
            /// 대상 연령대
            Text("target_age_group".tr(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 8,),
            const TagList(
              type: ExperimentType.perform,
              tags: ['20대'],
              isLarge: true,
            ),
            const SizedBox(height: 32,),
            /// 실험 참여 유형
            Text("participant_type".tr(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 8,),
            const TagList(
              type: ExperimentType.perform,
              tags: ['나홀로'],
              isLarge: true,
            ),
            const SizedBox(height: 32,),
            /// 실험 주제
            Text("perform_topic".tr(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 8,),
            const TagList(
              type: ExperimentType.perform,
              tags: ['심리', '감정', '행복'],
              isLarge: true,
            ),
            const SizedBox(height: 32,),
            /// 지역
            Text("area".tr(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 8,),
            const TagList(
              type: ExperimentType.perform,
              tags: ['경기'],
              isLarge: true,
            ),
            const SizedBox(height: 136,)
          ],
        ),
      ),
    );
  }
}
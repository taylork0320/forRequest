import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../styles/color_styles.dart';

class PerformDetailView extends StatelessWidget {
  const PerformDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32,),
            _performConditionLayout(),
            const SizedBox(height: 32,),
            const Divider(height: 1, color:  ColorStyles.dividerBackground,),
            const SizedBox(height: 32,),
            _detailContent(),
            const SizedBox(height: 72,),
          ],
        ),
      ),
    );
  }

  Widget _performConditionLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("perform_condition".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),
        ),
        const SizedBox(height: 32,),
        Row( // 급여
          children: [
            SizedBox(
              width: 90,
              child: Text("salary".tr(),
                style: const TextStyle(
                    color: ColorStyles.hintText,
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            ),
            Text('price'.tr(
                namedArgs: {"price": NumberFormat('###,###').format(10000)}
              ),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14
              ),
            ),
          ],
        ),
        const SizedBox(height: 12,),
        Row( // 급여
          children: [
            SizedBox(
              width: 90,
              child: Text("perform_period".tr(),
                style: const TextStyle(
                    color: ColorStyles.hintText,
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            ),
            Text('date'.tr(
                namedArgs: {"date": 7.toString()}
            ),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14
              ),
            ),
          ],
        ),
        const SizedBox(height: 12,),
        Row( // 시간
          children: [
            SizedBox(
              width: 90,
              child: Text("perform_time".tr(),
                style: const TextStyle(
                    color: ColorStyles.hintText,
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            ),
            Text('time'.tr(
                namedArgs: {"startTime": "09", "endTime": "18"}
            ),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _detailContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("perform_detail_content".tr(),
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20
          ),
        ),
        const SizedBox(height: 32,),
        Text(
          "perform_detail_content_example".tr(),
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 14,
              height: 1.5),
        ),
      ],
    );
  }
}
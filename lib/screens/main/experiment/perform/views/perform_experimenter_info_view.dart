import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/styles/icons.dart';

import '../../../../../styles/color_styles.dart';

class PerformExperimenterInfoView extends StatelessWidget {
  const PerformExperimenterInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32,),
          Text(
            "survey_experimenter_information".tr(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(height: 32,),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 130,
                    child: PngImages.exPerimenterExample,
                  ),
                  const Divider(height: 1, color: ColorStyles.dividerBackground,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 22, horizontal: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "가천대학교 연구실",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                        const SizedBox(height: 12,),
                        Text(
                          "경기도 성남시 수정구 성남대로 1342",
                          style: const TextStyle(
                              color: ColorStyles.subText,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
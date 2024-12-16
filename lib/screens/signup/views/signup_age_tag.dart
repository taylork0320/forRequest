import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/screens/signup/signup_tag_viewmodel.dart';

import '../../../enums/age_group.dart';
import '../../../widgets/selectable_tag_list.dart';

class SignupAgeTag extends StatelessWidget {
  const SignupAgeTag({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignupTagViewModel>(context);
    final groups = AgeGroup.values.map((e) => e.label).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'signup_age_title'.tr(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 54),
          SizedBox(
            width: double.infinity,
            child: SelectableTagList(
              items: groups,
              isMultiSelect: false,
              initialSelection: viewModel.selectedAgeGroups, // 이전 선택값 전달
              onSelectionChanged: (selectedItems) {
                viewModel.setSelectedAgeGroups(selectedItems);
              },
            ),
          ),
        ],
      ),
    );
  }
}
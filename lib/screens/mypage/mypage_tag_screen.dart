import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/enums/age_group.dart';
import 'package:sasimee/enums/area_group.dart';
import 'package:sasimee/enums/gender_group.dart';
import 'package:sasimee/enums/subject_group.dart';
import 'package:sasimee/enums/tag_type.dart';
import 'package:sasimee/enums/type_group.dart';
import 'package:sasimee/screens/mypage/mypage_tag_viewmodel.dart';
import 'package:sasimee/styles/color_styles.dart';
import 'package:sasimee/widgets/selectable_tag_list.dart';

class MypageTagScreen extends StatefulWidget {
  static String routeName = "/mypage/tag";

  const MypageTagScreen({super.key});

  @override
  State<MypageTagScreen> createState() => _MypageTagScreenState();
}

class _MypageTagScreenState extends State<MypageTagScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MypageTagViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('tag_management'.tr())),
        body: Builder(builder: (context) {
          final viewModel = Provider.of<MypageTagViewModel>(context);

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 36,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'tag_age'.tr(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          SelectableTagList(
                            items: AgeGroup.values.map((e) => e.label).toList(),
                            type: TagType.experiment,
                            isMultiSelect: false,
                            initialSelection: viewModel.selectedAgeGroups,
                            onSelectionChanged: (values) =>
                                viewModel.setSelectedAgeGroups(values),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'tag_area'.tr(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          SelectableTagList(
                            items:
                                AreaGroup.values.map((e) => e.label).toList(),
                            type: TagType.experiment,
                            isMultiSelect: true,
                            initialSelection: viewModel.selectedAreaGroups,
                            onSelectionChanged: (values) =>
                                viewModel.setSelectedAreaGroups(values),
                            canPreview: true,
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'tag_type'.tr(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          SelectableTagList(
                            items:
                                TypeGroup.values.map((e) => e.label).toList(),
                            type: TagType.experiment,
                            isMultiSelect: false,
                            initialSelection: viewModel.selectedTypeGroups,
                            onSelectionChanged: (values) =>
                                viewModel.setSelectedTypeGroups(values),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'tag_gender'.tr(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          SelectableTagList(
                            items:
                                GenderGroup.values.map((e) => e.label).toList(),
                            type: TagType.experiment,
                            isMultiSelect: false,
                            initialSelection: viewModel.selectedGenderGroups,
                            onSelectionChanged: (values) =>
                                viewModel.setSelectedGenderGroups(values),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'tag_subject'.tr(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          SelectableTagList(
                            items: SubjectGroup.values
                                .map((e) => e.label)
                                .toList(),
                            type: TagType.experiment,
                            isMultiSelect: false,
                            initialSelection: viewModel.selectedSubjectGroups,
                            onSelectionChanged: (values) =>
                                viewModel.setSelectedSubjectGroups(values),
                            canPreview: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 24,
                  ),
                  child: Consumer<MypageTagViewModel>(
                      builder: (context, viewModel, _) {
                    return ElevatedButton(
                        onPressed: () async {
                          if (!viewModel.isButtonEnabled) return;

                          final result = await viewModel.done();
                          if (!context.mounted) return;

                          if (result) {
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 0),
                          backgroundColor: viewModel.isButtonEnabled
                              ? ColorStyles.primaryBlue
                              : ColorStyles.dividerBackground,
                        ),
                        child: Text('enter_complete'.tr()));
                  }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

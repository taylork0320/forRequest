import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/enums/age_group.dart';
import 'package:sasimee/enums/gender_group.dart';
import 'package:sasimee/enums/subject_group.dart';
import 'package:sasimee/enums/tag_type.dart';
import 'package:sasimee/screens/main/experiment/survey/survey_inspect_screen.dart';
import 'package:sasimee/widgets/common_time_picker.dart';
import 'package:sasimee/widgets/outline_text_field.dart';

import '../../../../styles/color_styles.dart';
import '../../../../styles/icons.dart';
import '../../../../widgets/common_date_picker.dart';
import '../../../../widgets/selectable_tag_list.dart';

class SurveyCreateScreen extends StatefulWidget {
  static String routeName = "/survey-create";

  const SurveyCreateScreen({
    super.key,
  });

  @override
  State<SurveyCreateScreen> createState() => _SurveyCreateScreenState();
}

class _SurveyCreateScreenState extends State<SurveyCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: _surveyInformationLayout(),
            ),
            const Divider(thickness: 8, color: ColorStyles.layoutBackground,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: _experimenterInfoLayout(),
            ),
            const SizedBox(height: 72,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: _doneButton(),
            ),
            const SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }

  Widget _surveyInformationLayout() {
    TextEditingController titleController = TextEditingController();
    final FocusNode titleFocusNode = FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 설문 제목
        Text("survey_title".tr(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        OutlineTextField(
            textEditingController: titleController,
            focusNode: titleFocusNode
        ),
        const SizedBox(height: 32,),
        /// 대상 성별
        Text("target_gender".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          width: double.infinity,
          child: SelectableTagList(
            type: TagType.experiment,
            items: GenderGroup.getGenderTagList(),
            isMultiSelect: true,
            initialSelection: [],
            onSelectionChanged: (selectedItems) {
              [];
            },
          ),
        ),
        const SizedBox(height: 32,),
        /// 대상 연령대
        Text("target_age_group".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          width: double.infinity,
          child: SelectableTagList(
            type: TagType.experiment,
            items: AgeGroup.getAgeTagList(),
            isMultiSelect: true,
            initialSelection: [],
            onSelectionChanged: (selectedItems) {
              [];
            },
          ),
        ),
        const SizedBox(height: 32,),
        /// 설문 주제
        Text("survey_topic".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: SelectableTagList(
              type: TagType.experiment,
              items: SubjectGroup.getSubjectTagList(),
              isMultiSelect: true,
              initialSelection: [],
              onSelectionChanged: (selectedItems) {
                [];
              },
              canPreview: true,
            ),
          ),
        ),
        const SizedBox(height: 32,),
        /// 설문 기간
        Text("survey_period".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        _surveyPeriodLayout(),
        const SizedBox(height: 32,),
        /// 설문 주소
        Text("survey_link".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        Text("survey_link_guide".tr(),
          style: const TextStyle(
            color: ColorStyles.hintText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            // 실험 작성 화면으로 이동
            Navigator.of(context).pushNamed(SurveyInspectScreen.routeName);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorStyles.dividerBackground),
              color: ColorStyles.textFieldBackground,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            height: 50,
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                IconButton(onPressed: (){
                  //TODO: 설문 검수 화면으로 이동
                }, icon: SvgIcons.arrowRight),
              ],
            ),
          ),
        ),
        const SizedBox(height: 37,)
      ],
    );
  }

  Widget _surveyPeriodLayout() {
    DateTime startDateTime = DateTime.now();
    DateTime endDateTime = DateTime.now();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: ColorStyles.dividerBackground),
        borderRadius: BorderRadius.circular(12),
        color: ColorStyles.layoutBackground
      ),
      child: Column(
        children: [
          _buildDateTimeRow(
            label: 'start_date'.tr(),
            dateTime: startDateTime,
            onDateSelected: (date) {
              setState(() {
                startDateTime = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  startDateTime.hour,
                  startDateTime.minute,
                );
              });
            },
            onTimeSelected: (time) {
              setState(() {
                startDateTime = DateTime(
                  startDateTime.year,
                  startDateTime.month,
                  startDateTime.day,
                  time.hour,
                  time.minute,
                );
              });
            },
          ),
          const Divider(height: 1),
          _buildDateTimeRow(
            label: 'end_date'.tr(),
            dateTime: endDateTime,
            onDateSelected: (date) {
              setState(() {
                endDateTime = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  endDateTime.hour,
                  endDateTime.minute,
                );
              });
            },
            onTimeSelected: (time) {
              setState(() {
                endDateTime = DateTime(
                  endDateTime.year,
                  endDateTime.month,
                  endDateTime.day,
                  time.hour,
                  time.minute,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeRow({
    required String label,
    required DateTime dateTime,
    required Function(DateTime) onDateSelected,
    required Function(TimeOfDay) onTimeSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 9, top: 6, bottom: 6),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 26),
          CommonDatePicker(
            selectedDate: dateTime,
            onDateSelected: onDateSelected,
          ),
          const SizedBox(width: 4),
          CommonTimePicker(
            selectedTime: TimeOfDay.fromDateTime(dateTime),
            onTimeSelected: onTimeSelected,
          ),
        ],
      ),
    );
  }

  Widget _experimenterInfoLayout() {
    TextEditingController titleController = TextEditingController();
    final FocusNode titleFocusNode = FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32,),
        Text("survey_experimenter_information".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 32,),
        Text("survey_experimenter_name".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6,),
        Text("survey_experimenter_guide".tr(),
          style: const TextStyle(
            color: ColorStyles.hintText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8,),
        OutlineTextField(
            textEditingController: titleController,
            focusNode: titleFocusNode
        ),
      ],
    );
  }

  //TODO: 실험 등록 진행
  Widget _doneButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: ColorStyles.primaryBlue,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text("done".tr(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
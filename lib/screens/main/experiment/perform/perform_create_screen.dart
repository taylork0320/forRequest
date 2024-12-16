import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/enums/age_group.dart';
import 'package:sasimee/enums/gender_group.dart';
import 'package:sasimee/enums/subject_group.dart';
import 'package:sasimee/enums/tag_type.dart';
import 'package:sasimee/enums/type_group.dart';
import 'package:sasimee/widgets/common_time_picker.dart';
import 'package:sasimee/widgets/outline_text_field.dart';

import '../../../../styles/color_styles.dart';
import '../../../../styles/icons.dart';
import '../../../../widgets/common_date_picker.dart';
import '../../../../widgets/selectable_tag_list.dart';

class PerformCreateScreen extends StatefulWidget {
  static String routeName = "/perform-create";

  const PerformCreateScreen({
    super.key,
  });

  @override
  State<PerformCreateScreen> createState() => _PerformCreateScreenState();
}

class _PerformCreateScreenState extends State<PerformCreateScreen> {
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

    TextEditingController explainController = TextEditingController();
    final FocusNode explainFocusNode = FocusNode();

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
        /// 실험 참여 유형
        Text("participant_type".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorStyles.textFieldBackground
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("participant_guide_title".tr(),
                  style: const TextStyle(
                    color: ColorStyles.hintText,
                    fontWeight: FontWeight.w600,
                    fontSize: 14
                  ),
                ),
                const SizedBox(height: 8,),
                Text("participant_guide_content".tr(),
                  style: const TextStyle(
                      color: ColorStyles.hintText,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 2),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 12,),
        SizedBox(
          width: double.infinity,
          child: SelectableTagList(
            type: TagType.experiment,
            items: TypeGroup.getParticipantTypeTagList(),
            isMultiSelect: true,
            initialSelection: [],
            onSelectionChanged: (selectedItems) {
              [];
            },
          ),
        ),
        const SizedBox(height: 32,),
        /// 실험 주제
        Text("perform_topic".tr(),
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
        /// 실험 기간 & 시간
        _performPeriodLayout(),
        const SizedBox(height: 32,),
        /// 급여
        Text("salary".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        Text("salary_guide".tr(),
          style: const TextStyle(
            color: ColorStyles.hintText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorStyles.dividerBackground),
            color: ColorStyles.textFieldBackground,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 50,
          child: Row(
            children: [
              Expanded(child: SizedBox()),
              Text('원',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 16
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 54,),
        /// 자세한 설명
        Text("perform_detail_explain".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        OutlineTextField(
          textEditingController: explainController,
          focusNode: explainFocusNode,
          maxLines: 4,
          hintText: 'perform_detail_hint'.tr(),
        ),
        const SizedBox(height: 32,)
      ],
    );
  }

  Widget _performPeriodLayout() {
    DateTime startDateTime = DateTime.now();
    DateTime endDateTime = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 실험 기간
        Text("perform_period".tr(),
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black
            )
        ),
        const SizedBox(height: 6,),
        _buildDateRow(startDateTime, endDateTime),
        const SizedBox(height: 32,),
        /// 실험 시간
        Text("perform_time".tr(),
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black
            )
        ),
        const SizedBox(height: 6,),
        _buildTimeRow(startDateTime, endDateTime)
      ],
    );
  }

  Widget _buildDateRow(DateTime startDateTime, DateTime endDateTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("start".tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorStyles.hintText
                  )
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: CommonDatePicker(
                  selectedDate: startDateTime,
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
                ),
              ),
            ],
          ),
        ),
        const Text(" ~ ",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.black
            )
        ),
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("end".tr(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorStyles.hintText
                  )
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: CommonDatePicker(
                  selectedDate: endDateTime,
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeRow(DateTime startDateTime, DateTime endDateTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("start".tr(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorStyles.hintText
                  )
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: CommonTimePicker(
                  selectedTime: TimeOfDay.fromDateTime(startDateTime),
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
              ),
            ],
          ),
        ),
        const Text(" ~ ",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.black
            )
        ),
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("end".tr(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorStyles.hintText
                  )
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: CommonTimePicker(
                  selectedTime: TimeOfDay.fromDateTime(endDateTime),
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 실험자 정보
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
        /// 실험자 이름
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
        const SizedBox(height: 58,),
        /// 사진
        Text("picture".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6,),
        Text("picture_guide".tr(),
          style: const TextStyle(
            color: ColorStyles.hintText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8,),
        //TODO: 사진 등록 진행
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorStyles.textFieldBackground,
            borderRadius: BorderRadius.circular(10)
          ),
          child: SvgIcons.imageAdd,
        ),
        const SizedBox(height: 36,),
        /// 주소
        Text("address".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorStyles.dividerBackground),
            color: ColorStyles.textFieldBackground,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 50,
          child: Row(
            children: [
              Expanded(child: SizedBox()),
              IconButton(onPressed: (){}, icon: Icon(Icons.search))
            ],
          ),
        ),
        const SizedBox(height: 6,),
        Text("selected_address_tag".tr(),
          style: const TextStyle(
            color: ColorStyles.hintText,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8,),
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
import 'package:flutter/material.dart';
import 'package:sasimee/enums/tag_type.dart';

import '../styles/color_styles.dart';

class SelectableTagList extends StatefulWidget {
  final TagType type;
  final List<String> items;
  final bool isMultiSelect;
  final Function(List<String>) onSelectionChanged;
  final List<String> initialSelection; // 초기 선택값
  final bool canPreview;

  const SelectableTagList({
    super.key,
    this.type = TagType.signup,
    required this.items,
    required this.isMultiSelect,
    required this.onSelectionChanged,
    this.initialSelection = const [], // 기본값은 빈 리스트
    this.canPreview = false // 더보기 버튼을 지원하는 경우
  });

  @override
  State<SelectableTagList> createState() => _SelectableTagListState();
}

class _SelectableTagListState extends State<SelectableTagList> {
  late Set<String> _selectedItems = {};
  final int _maxVisibleItems = 8;

  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _selectedItems = Set.from(widget.initialSelection);
  }

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSignupType = widget.type == TagType.signup;
    final displayItems = _isExpanded.value == true
        ? widget.items
        : widget.items.take(_maxVisibleItems).toList();
    final showExpandButton = (widget.items.length > _maxVisibleItems) && widget.canPreview;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: isSignupType ? 8 : 6,
          runSpacing: isSignupType ? 18 : 8,
          children: displayItems.map((item) {
            final isSelected = _selectedItems.contains(item);
            return ChoiceChip(
              label: Text(item),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (widget.isMultiSelect) {
                    if (selected) {
                      _selectedItems.add(item);
                    } else {
                      _selectedItems.remove(item);
                    }
                  } else {
                    _selectedItems.clear();
                    if (selected) {
                      _selectedItems.add(item);
                    }
                  }
                  widget.onSelectionChanged(_selectedItems.toList());
                });
              },
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              showCheckmark: false,
              labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? Colors.white : ColorStyles.primaryBlue
              ),
              selectedColor: ColorStyles.primaryBlue,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(color: ColorStyles.primaryBlue),
              ),
            );
          }).toList(),
        ),
        if (showExpandButton)
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded.value = !_isExpanded.value;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isExpanded.value ? '접기' : '더보기',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                Icon(
                  _isExpanded.value
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
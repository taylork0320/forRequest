import 'package:flutter/material.dart';

import '../styles/color_styles.dart';

class SelectableTagList extends StatefulWidget {
  final List<String> items;
  final bool isMultiSelect;
  final Function(List<String>) onSelectionChanged;
  final List<String> initialSelection; // 초기 선택값

  const SelectableTagList({
    super.key,
    required this.items,
    required this.isMultiSelect,
    required this.onSelectionChanged,
    this.initialSelection = const [], // 기본값은 빈 리스트
  });

  @override
  State<SelectableTagList> createState() => _SelectableTagListState();
}

class _SelectableTagListState extends State<SelectableTagList> {
  late Set<String> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _selectedItems = Set.from(widget.initialSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 18,
      children: widget.items.map((item) {
        final isSelected = _selectedItems.contains(item);
        return ChoiceChip(
          label: Text(item),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (widget.isMultiSelect) { // 복수 선택
                if (selected) {
                  _selectedItems.add(item);
                } else {
                  _selectedItems.remove(item);
                }
              } else { // 단일 선택
                _selectedItems.clear();
                if (selected) {
                  _selectedItems.add(item);
                }
              }
              print('selectItem: $item');
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
    );
  }
}
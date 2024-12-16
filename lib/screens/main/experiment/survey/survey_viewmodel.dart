import 'package:flutter/widgets.dart';

class SurveyViewModel with ChangeNotifier {
  final TextEditingController _titleController = TextEditingController();
  get titleController => _titleController;

  final FocusNode _titleFocusNode = FocusNode();
  get titleFocusNode => _titleFocusNode;
}
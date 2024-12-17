import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/screens/login/login_screen.dart';
import 'package:sasimee/screens/mypage/mypage_profile_viewmodel.dart';
import 'package:sasimee/styles/color_styles.dart';
import 'package:sasimee/widgets/common_text_field.dart';

class MypageProfileScreen extends StatefulWidget {
  static String routeName = "/mypage/profile";

  const MypageProfileScreen({super.key});

  @override
  State<MypageProfileScreen> createState() => _MypageProfileScreenState();
}

class _MypageProfileScreenState extends State<MypageProfileScreen> {
  late final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return ChangeNotifierProvider(
      create: (_) => MypageProfileViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('profile_management'.tr()),
        ),
        body: Builder(builder: (context) {
          final viewModel = Provider.of<MypageProfileViewModel>(context);

          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: mediaQuery.size.height -
                    mediaQuery.padding.top -
                    mediaQuery.padding.bottom -
                    kToolbarHeight,
                padding: const EdgeInsets.only(
                  left: 32,
                  top: 58,
                  right: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorStyles.progressBarBackground),
                          alignment: Alignment.center,
                          clipBehavior: Clip.hardEdge,
                          child: Consumer<MypageProfileViewModel>(
                            builder: (context, viewModel, _) {
                              final url = viewModel.profileUrl;

                              if (url == null) {
                                return SvgPicture.asset(
                                    'assets/images/icons/ic_user_55.svg');
                              }

                              if (url.startsWith('http')) {
                                // Network url
                                return SvgPicture.asset(
                                    'assets/images/icons/ic_user_55.svg');
                              } else {
                                return Image.file(
                                  File(url),
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                );
                              }
                            },
                          ),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image == null) return;

                                viewModel.profileUrl = image.path;
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorStyles.primaryBlue,
                                ),
                                child: SvgPicture.asset(
                                    'assets/images/icons/ic_pen.svg'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    CommonTextField(
                      textEditingController: viewModel.emailController,
                      type: TextFieldType.email,
                      focusNode: viewModel.emailFocusNode,
                      showPrefix: false,
                    ),
                    const SizedBox(height: 20),
                    CommonTextField(
                      textEditingController: viewModel.nameController,
                      type: TextFieldType.name,
                      focusNode: viewModel.nameFocusNode,
                      showPrefix: false,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CommonTextField(
                      textEditingController: viewModel.mobileNumberController,
                      type: TextFieldType.mobileNumber,
                      focusNode: viewModel.mobileNumberFocusNode,
                      showPrefix: false,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Consumer<MypageProfileViewModel>(
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
                    const SizedBox(height: 73),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.routeName, (route) => false);
                      },
                      child: Text(
                        'logout'.tr(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xfff25a5a),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xfff25a5a),
                        ),
                      ),
                    ),
                    const SizedBox(height: 11),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

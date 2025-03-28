import 'package:civix_teams/constants.dart';
import 'package:civix_teams/features/update_status/presentation/views/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateStatusViewBody extends StatelessWidget {
  const UpdateStatusViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kVerticalPadding,
      ),
      child: SingleChildScrollView(
        child: Column(children: [MultiImagePickerScreen()]),
      ),
    );
  }
}

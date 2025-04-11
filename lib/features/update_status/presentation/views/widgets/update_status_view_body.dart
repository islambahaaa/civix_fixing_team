import 'package:civix_teams/constants.dart';
import 'package:civix_teams/core/widgets/custom_button.dart';
import 'package:civix_teams/features/update_status/presentation/views/widgets/description_field.dart';
import 'package:civix_teams/features/update_status/presentation/views/widgets/image_picker_widget.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateStatusViewBody extends StatefulWidget {
  const UpdateStatusViewBody({super.key});

  @override
  State<UpdateStatusViewBody> createState() => _UpdateStatusViewBodyState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
late String description;

class _UpdateStatusViewBodyState extends State<UpdateStatusViewBody> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kVerticalPadding,
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              MultiImagePickerScreen(
                onImagePicked: (images) {
                  //update cubit
                },
              ),
              SizedBox(height: 16),
              CustomDescriptionField(
                onSaved: (value) {
                  description = value!;
                },
              ),
              SizedBox(height: 8),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    //to do implement submit
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                text: S.of(context).submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

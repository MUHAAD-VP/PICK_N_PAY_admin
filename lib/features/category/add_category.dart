import 'package:flutter/material.dart';
import 'package:pick_n_pay/common_widget/custom_alert_dialog.dart';
import 'package:pick_n_pay/common_widget/custom_button.dart';
import 'package:pick_n_pay/common_widget/custom_image_picker_button.dart';
import 'package:pick_n_pay/common_widget/custom_text_formfield.dart';
import 'package:pick_n_pay/util/value_validator.dart';

class AddCategory extends StatelessWidget {
  AddCategory({
    super.key,
  });
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Add Category',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add category Image',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomImagePickerButton(
            height: 150,
            width: 150,
            onPick: (file) {},
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Add category Name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
              labelText: 'Category Name',
              controller: _categoryNameController,
              validator: notEmptyValidator),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            inverse: true,
            onPressed: () {},
            label: 'Add Category',
          )
        ],
      ),
    );
  }
}

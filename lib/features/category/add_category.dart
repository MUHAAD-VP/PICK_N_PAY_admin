import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_n_pay/common_widget/custom_alert_dialog.dart';
import 'package:pick_n_pay/common_widget/custom_image_picker_button.dart';
import 'package:pick_n_pay/common_widget/custom_text_formfield.dart';
import 'package:pick_n_pay/util/value_validator.dart';

import 'categories_bloc/categories_bloc.dart';

class AddCategory extends StatefulWidget {
  final Map? categorieDetails;
  const AddCategory({
    super.key,
    this.categorieDetails,
  });

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _categoryNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PlatformFile? coverImage;

  @override
  void initState() {
    if (widget.categorieDetails != null) {
      _categoryNameController.text = widget.categorieDetails!['name'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return CustomAlertDialog(
          title: 'Add Category',
          content: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add category Image',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomImagePickerButton(
                  height: 150,
                  width: 150,
                  selectedImage: widget.categorieDetails?['image_url'],
                  onPick: (file) {
                    coverImage = file;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Add category Name',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  isLoading: state is CategoriesLoadingState,
                  labelText: 'Category Name',
                  controller: _categoryNameController,
                  validator: notEmptyValidator,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          primaryButton: 'Save',
          onPrimaryPressed: () {
            if (_formKey.currentState!.validate() &&
                ((coverImage != null) || widget.categorieDetails != null)) {
              Map<String, dynamic> details = {
                'name': _categoryNameController.text.trim(),
              };

              if (coverImage != null) {
                details['image'] = coverImage!.bytes;
                details['image_name'] = coverImage!.name;
              }

              if (widget.categorieDetails != null) {
                BlocProvider.of<CategoriesBloc>(context).add(
                  EditCategorieEvent(
                    categorieId: widget.categorieDetails!['id'],
                    categorieDetails: details,
                  ),
                );
              } else {
                BlocProvider.of<CategoriesBloc>(context).add(
                  AddCategorieEvent(
                    categorieDetails: details,
                  ),
                );
              }
            }
          },
        );
      },
    );
  }
}

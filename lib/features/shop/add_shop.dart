import 'package:flutter/material.dart';
import 'package:pick_n_pay/common_widget/custom_alert_dialog.dart';
import 'package:pick_n_pay/common_widget/custom_button.dart';
import 'package:pick_n_pay/common_widget/custom_image_picker_button.dart';
import 'package:pick_n_pay/common_widget/custom_text_formfield.dart';
import 'package:pick_n_pay/util/value_validator.dart';

class AddShop extends StatelessWidget {
  AddShop({
    super.key,
  });
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _buildingNoController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Add Shop',
      content: Flexible(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Shop Image',
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
                'Add Shop Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                  labelText: 'Shop Name',
                  controller: _shopNameController,
                  validator: notEmptyValidator),
              // Building no
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Building No.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                  labelText: 'Enter building No.',
                  controller: _buildingNoController,
                  validator: notEmptyValidator),

              // street name
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Street Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                  labelText: 'Enter street name',
                  controller: _streetNameController,
                  validator: notEmptyValidator),

              // City
              const SizedBox(
                height: 20,
              ),
              const Text(
                'City Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                  labelText: 'Enter city name',
                  controller: _cityController,
                  validator: notEmptyValidator),

              // District

              const SizedBox(
                height: 20,
              ),
              const Text(
                'District Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                  labelText: 'Enter District name',
                  controller: _districtController,
                  validator: notEmptyValidator),

              // State

              const SizedBox(
                height: 20,
              ),
              const Text(
                'State Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                  labelText: 'Enter State name',
                  controller: _stateController,
                  validator: notEmptyValidator),

              // pincode

              const SizedBox(
                height: 20,
              ),
              const Text(
                'Pincode',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                  labelText: 'Enter Pincode',
                  controller: _pincodeController,
                  validator: pincodeValidator),

              // phone no
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Phone Number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                  labelText: 'Enter Phone number',
                  controller: _phoneNoController,
                  validator: phoneNumberValidator),

              // email

              const SizedBox(
                height: 20,
              ),
              const Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                  labelText: 'Enter email',
                  controller: _emailController,
                  validator: emailValidator),

              // location

              const SizedBox(
                height: 20,
              ),
              const Text(
                'Location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                  labelText: 'Enter location',
                  controller: _locationController,
                  validator: notEmptyValidator),

              const SizedBox(
                height: 30,
              ),
              CustomButton(
                inverse: true,
                onPressed: () {},
                label: 'Add Shop',
              )
            ],
          ),
        ),
      ),
    );
  }
}

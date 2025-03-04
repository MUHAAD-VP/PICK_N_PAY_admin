import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../common_widget/custom_alert_dialog.dart';
import '../../common_widget/custom_button.dart';
import '../../common_widget/custom_image_picker_button.dart';
import '../../common_widget/custom_map.dart';
import '../../common_widget/custom_text_formfield.dart';
import '../../util/value_validator.dart';
import 'shop_bloc/shop_bloc.dart';

class AddEditShop extends StatefulWidget {
  final Map? shopDetails;
  const AddEditShop({super.key, this.shopDetails});

  @override
  State<AddEditShop> createState() => _AddEditShopState();
}

class _AddEditShopState extends State<AddEditShop> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contectEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _addresslineController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PlatformFile? coverImage;

  LatLng? _selectedLocation;

  @override
  void initState() {
    if (widget.shopDetails != null) {
      _nameController.text = widget.shopDetails!['name'];
      _phoneController.text = widget.shopDetails!['phone'];
      _descriptionController.text = widget.shopDetails!['description'];
      _stateController.text = widget.shopDetails!['state'];
      _districtController.text = widget.shopDetails!['district'];
      _placeController.text = widget.shopDetails!['place'];
      _pincodeController.text = widget.shopDetails!['pincode'];
      _addresslineController.text = widget.shopDetails!['address_line'];
      _contectEmailController.text = widget.shopDetails!['contact_email'];

      if (widget.shopDetails!['location'] != null) {
        _selectedLocation = LatLng(widget.shopDetails!['location_latitude'],
            widget.shopDetails!['location_longitude']);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopBloc, ShopState>(
      listener: (context, state) {
        if (state is ShopSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return CustomAlertDialog(
          isLoading: state is ShopLoadingState,
          title: "Add PetStore",
          content: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    "Pet Store Details",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomImagePickerButton(
                    width: double.infinity,
                    height: 200,
                    selectedImage: widget.shopDetails?['image_url'],
                    onPick: (pick) {
                      coverImage = pick;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    validator: notEmptyValidator,
                    controller: _nameController,
                    isLoading: state is ShopLoadingState,
                    labelText: 'Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    label: _selectedLocation != null
                        ? 'Change Location'
                        : 'Select Location',
                    iconData: Icons.location_on_sharp,
                    onPressed: () async {
                      LatLng? tempLocation = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CustomMap(
                            selectedLocation: _selectedLocation,
                          ),
                        ),
                      );

                      if (tempLocation != null) {
                        _selectedLocation = tempLocation;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    validator: notEmptyValidator,
                    controller: _descriptionController,
                    isLoading: state is ShopLoadingState,
                    labelText: 'Description',
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    validator: notEmptyValidator,
                    controller: _stateController,
                    isLoading: state is ShopLoadingState,
                    labelText: 'State',
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    validator: notEmptyValidator,
                    controller: _districtController,
                    isLoading: state is ShopLoadingState,
                    labelText: 'District',
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    validator: notEmptyValidator,
                    controller: _placeController,
                    isLoading: state is ShopLoadingState,
                    labelText: 'Place',
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    validator: numericValidator,
                    controller: _pincodeController,
                    isLoading: state is ShopLoadingState,
                    labelText: 'Pincode',
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    validator: notEmptyValidator,
                    controller: _addresslineController,
                    isLoading: state is ShopLoadingState,
                    labelText: 'Address Line',
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Contact Details",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    validator: phoneNumberValidator,
                    controller: _phoneController,
                    labelText: 'Phone',
                    isLoading: state is ShopLoadingState,
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    validator: emailValidator,
                    controller: _contectEmailController,
                    labelText: 'Email',
                    isLoading: state is ShopLoadingState,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (widget.shopDetails == null)
                    Text(
                      "Login Details",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  if (widget.shopDetails == null)
                    SizedBox(
                      height: 10,
                    ),
                  if (widget.shopDetails == null)
                    CustomTextFormField(
                      isLoading: state is ShopLoadingState,
                      controller: _emailController,
                      labelText: 'Email',
                      validator: emailValidator,
                    ),
                  if (widget.shopDetails == null)
                    SizedBox(
                      height: 10,
                    ),
                  if (widget.shopDetails == null)
                    CustomTextFormField(
                      isLoading: state is ShopLoadingState,
                      controller: _passwordController,
                      labelText: 'Passsword',
                      validator: passwordValidator,
                    ),
                ],
              ),
            ),
          ),
          onPrimaryPressed: () {
            if (_formKey.currentState!.validate() &&
                ((coverImage != null) || widget.shopDetails != null)) {
              Map<String, dynamic> details = {
                'name': _nameController.text.trim(),
                'description': _descriptionController.text.trim(),
                'email': _emailController.text.trim(),
                'password': _passwordController.text.trim(),
                'contact_email': _contectEmailController.text.trim(),
                'phone': _phoneController.text.trim(),
                'state': _stateController.text.trim(),
                'district': _districtController.text.trim(),
                'place': _placeController.text.trim(),
                'pincode': _pincodeController.text.trim(),
                'address_line': _addresslineController.text.trim(),
                'location': _selectedLocation != null
                    ? 'POINT(${_selectedLocation?.longitude} ${_selectedLocation?.latitude})'
                    : null,
                'location_longitude': _selectedLocation?.longitude,
                'location_latitude': _selectedLocation?.latitude,
              };

              if (coverImage != null) {
                details['image'] = coverImage!.bytes;
                details['image_name'] = coverImage!.name;
              }

              if (widget.shopDetails != null) {
                BlocProvider.of<ShopBloc>(context).add(
                  EditShopEvent(
                    shopId: widget.shopDetails!['id'],
                    shopDetails: details,
                  ),
                );
              } else {
                BlocProvider.of<ShopBloc>(context).add(
                  AddShopEvent(
                    shopDetails: details,
                  ),
                );
              }
            }
          },
          primaryButton: 'Save Changes',
        );
      },
    );
  }
}

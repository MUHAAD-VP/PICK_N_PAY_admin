import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:pick_n_pay/common_widget/custom_button.dart';
import 'package:pick_n_pay/common_widget/custom_search.dart';
import 'package:pick_n_pay/features/category/add_category.dart';
import 'package:pick_n_pay/features/category/category_card.dart';
import 'package:pick_n_pay/theme/app_theme.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../util/check_login.dart';
import 'categories_bloc/categories_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoriesBloc _categoriesBloc = CategoriesBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map> _categories = [];

  @override
  void initState() {
    checkLogin(context);
    getCategories();
    super.initState();
  }

  void getCategories() {
    _categoriesBloc.add(GetAllCategoriesEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _categoriesBloc,
      child: BlocConsumer<CategoriesBloc, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getCategories();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is CategoriesGetSuccessState) {
            _categories = state.categories;
            Logger().w(_categories);
            setState(() {});
          } else if (state is CategoriesSuccessState) {
            getCategories();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: secondaryColor),
                    ),
                    const Spacer(),
                    Expanded(
                      child: CustomSearch(
                        onSearch: (p0) {
                          params['query'] = p0;
                          getCategories();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      inverse: true,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: _categoriesBloc,
                            child: AddCategory(),
                          ),
                        );
                      },
                      label: 'Add Category',
                      iconData: Icons.add,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                if (state is CategoriesLoadingState)
                  const Center(child: CircularProgressIndicator()),
                if (state is CategoriesGetSuccessState && _categories.isEmpty)
                  const Center(child: Text('No Categories Found')),
                if (state is CategoriesGetSuccessState &&
                    _categories.isNotEmpty)
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(
                      _categories.length,
                      (index) => CategoryCard(
                        imageUrl: _categories[index]['image_url'],
                        categoryName: _categories[index]['name'],
                        onEdit: () {
                          showDialog(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: _categoriesBloc,
                              child: AddCategory(
                                categorieDetails: _categories[index],
                              ),
                            ),
                          );
                        },
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                              title: 'Delete Categorie?',
                              description:
                                  'Deletion will fail if there are records under this categorie',
                              primaryButton: 'Delete',
                              onPrimaryPressed: () {
                                _categoriesBloc.add(
                                  DeleteCategorieEvent(
                                    categorieId: _categories[index]['id'],
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              secondaryButton: 'Cancel',
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

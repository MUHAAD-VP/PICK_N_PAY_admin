import 'package:flutter/material.dart';
import 'package:pick_n_pay/common_widget/custom_button.dart';
import 'package:pick_n_pay/common_widget/custom_search.dart';
import 'package:pick_n_pay/features/category/add_category.dart';
import 'package:pick_n_pay/features/category/category_card.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String searchQuery = '';

  final List<Map<String, String>> categories = [
    {
      'imageUrl':
          'https://st.depositphotos.com/1064024/1951/i/950/depositphotos_19515627-stock-photo-assortment-of-fresh-vegetables.jpg',
      'categoryName': 'Vegetables',
    },
    {
      'imageUrl':
          'https://www.mooringspark.org/hubfs/bigstock-Fresh-Fruits-assorted-Fruits-C-365480089.jpg',
      'categoryName': 'Fruits',
    },
    // Add more categories here
  ];

  void onSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<Map<String, String>> get filteredCategories {
    return categories
        .where((category) => category['categoryName']!
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Expanded(
                child: CustomSearch(
                  onSearch: (p0) {},
                ),
              ),
              const SizedBox(width: 10),
              CustomButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddCategory(),
                  );
                },
                label: 'Add Category',
                iconData: Icons.add,
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CategoryCard(
                imageUrl: filteredCategories[index]['imageUrl']!,
                categoryName: filteredCategories[index]['categoryName']!,
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemCount: filteredCategories.length,
            ),
          ),
        ],
      ),
    );
  }
}

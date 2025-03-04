import 'package:flutter/material.dart';
import 'package:pick_n_pay/common_widget/custom_button.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  final Function() onEdit, onDelete;

  const CategoryCard(
      {super.key,
      required this.imageUrl,
      required this.categoryName,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Material(
        elevation: 5,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                categoryName,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                spacing: 10,
                children: [
                  CustomButton(onPressed: onEdit, label: 'Edit'),
                  CustomButton(onPressed: onDelete, label: 'Delete'),
                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     backgroundColor: Colors.orange,
                  //   ),
                  //   onPressed: onEdit,
                  //   child: Text(
                  //     'Edit',
                  //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  //           color: Colors.white,
                  //         ),
                  //   ),
                  // ),
                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     backgroundColor: Colors.red,
                  //   ),
                  //   onPressed: onEdit,
                  //   child: Text(
                  //     'Delete',
                  //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  //           color: Colors.white,
                  //         ),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

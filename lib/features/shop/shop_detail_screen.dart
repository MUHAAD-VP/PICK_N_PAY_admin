import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pick_n_pay/common_widget/width_bound.dart';
import 'package:pick_n_pay/util/format_function.dart';

import '../../common_widget/custom_map.dart';
import '../../common_widget/text_link.dart';

class ShopDetailScreen extends StatelessWidget {
  final Map shopDetails;

  const ShopDetailScreen({super.key, required this.shopDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Shop Details'),
      ),
      body: WidthBound(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shop Image
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Colors.black12),
                    image: DecorationImage(
                      image: NetworkImage(shopDetails['image_url']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Shop Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Shop Name
                      Text(
                        shopDetails['name'],
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(height: 10),

                      // Address Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text('Address: ${formatAddress(shopDetails)}'),
                          const SizedBox(height: 5),
                          TextLink(
                            text: shopDetails['location'] != null
                                ? 'View Location'
                                : 'Not Selected',
                            onPressed: () {
                              if (shopDetails['location'] != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CustomMap(
                                      selectedLocation: LatLng(
                                        shopDetails['location_latitude'],
                                        shopDetails['location_longitude'],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Information',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: Colors.black54),
                              const SizedBox(width: 8),
                              Text(shopDetails['phone']),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.email, color: Colors.black54),
                              const SizedBox(width: 8),
                              Text(shopDetails['contact_email']),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              shopDetails['description'] ?? 'No description available.',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Available Items
            Text(
              'Available Items',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: shopDetails['items']?.length ?? 0,
              itemBuilder: (context, index) {
                final item = shopDetails['items'][index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item['image_url']),
                    ),
                    title: Text(item['name']),
                    subtitle: Text(item['category']),
                    trailing: Text(
                      '₹${item['price']}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

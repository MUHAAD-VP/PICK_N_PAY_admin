import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample order details
    final orderDetails = {
      'orderId': '#ORD123456',
      'userName': 'John Doe',
      'shopName': 'Tech Store',
      'shopId': 'SHOP789',
      'status': 'Processing',
      'pickupTime': '3:00 PM',
    };

    // Sample ordered items
    final List<Map<String, dynamic>> orderedItems = [
      {
        'name': 'Laptop',
        'image':
            'https://m.media-amazon.com/images/I/71TN45+oJ0L._AC_SL1500_.jpg',
        'count': 1,
        'price': 1200.0,
      },
      {
        'name': 'Mouse',
        'image':
            'https://i5.walmartimages.com/asr/2359c3f8-611d-40c4-88ab-49d4695dfd5f.5b26b18ccda9066176d9e3346f969843.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff',
        'count': 2,
        'price': 25.0,
      },
      {
        'name': 'Keyboard',
        'image': 'https://m.media-amazon.com/images/I/81SLAR9MnxS.jpg',
        'count': 1,
        'price': 50.0,
      },
    ];

    // Calculate total price
    double totalPrice = orderedItems.fold(
        0, (sum, item) => sum + (item['count'] * item['price']));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${orderDetails['orderId']}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
            ),
            Text('User Name: ${orderDetails['userName']}',
                style: Theme.of(context).textTheme.bodyLarge),
            Text('Shop Name: ${orderDetails['shopName']}',
                style: Theme.of(context).textTheme.bodyLarge),
            Text('Shop ID: ${orderDetails['shopId']}',
                style: Theme.of(context).textTheme.bodyLarge),
            Text('Status: ${orderDetails['status']}',
                style: Theme.of(context).textTheme.bodyLarge),
            Text('Pickup Time: ${orderDetails['pickupTime']}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            Text(
              'Ordered Items:',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: orderedItems.length,
                itemBuilder: (context, index) {
                  final item = orderedItems[index];
                  final itemTotal = item['count'] * item['price'];

                  return Material(
                    child: ListTile(
                      leading: Image.network(item['image'],
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(
                        item['name'],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Count: ${item['count']} | Price: ₹${item['price']}'),
                      trailing: Text(
                        'Total: ₹${itemTotal.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total Amount: ₹${totalPrice.toStringAsFixed(2)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

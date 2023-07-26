import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      initialRoute: '/',
      routes: {
        '/': (context) => ProductListScreen(),
        '/productDetail': (context) => const ProductDetailScreen(),
      },
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'name': 'Hiệu sách nhỏ ở Paris', 'imageURL': 'https://thecuriousweirdo.com/wp-content/uploads/2021/07/20210709_162512-585x775.jpg', 'price':40.000},
    {'name': 'Bố con cá gai', 'imageURL': 'https://salt.tikicdn.com/cache/750x750/ts/product/e4/c3/63/41905b18347002a2831fc869e8da5c50.jpg.webp','price':15.000},
    {'name': 'Bụi sao', 'imageURL': 'https://salt.tikicdn.com/cache/750x750/ts/product/16/3f/eb/9e8cf6eb2e30dd9e982780106101d1f4.jpg.webp','price':52.200},
  ];

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(products[index]['imageURL']), // Đặt hình ảnh vào đây
            title: Text(products[index]['name']),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/productDetail',
                arguments: products[index],
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Đây là chi tiết sản phẩm: ${product['name']}', style: const TextStyle(fontSize: 18),),
            const SizedBox(height: 20),
            Text('Giá: \$${product['price']}', style: const TextStyle(fontSize: 18),),
            const SizedBox(height: 20),
            Image.network(
              product['imageURL'], // Use the image URL from the selected product
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

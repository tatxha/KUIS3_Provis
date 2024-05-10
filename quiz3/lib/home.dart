import 'package:flutter/material.dart';
import 'package:quiz3/detail_product.dart';
import 'package:quiz3/chart.dart';
import 'package:quiz3/model/product.dart';
import 'package:quiz3/provider/product_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
  
    // Mendapatkan informasi tentang ukuran layar perangkat
    final screenWidth = MediaQuery.of(context).size.width;

    // Menghitung lebar widget responsif
    final productWidth = (screenWidth - 24) / 2; // Mengurangi margin dari total lebar layar

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Produk"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search products...', // Teks hint untuk input field
              prefixIcon: Icon(Icons.search), // Icon pencarian di sebelah kiri input field
              border: OutlineInputBorder(), // Atur border input field
            ),
            onChanged: (value) {
              // Logika pencarian produk bisa diimplementasikan di sini
            },
          ),
        ),
        Expanded(
          child: Consumer<ProductProvider>(
            builder: (context, value, _) {
              if(value.products.isEmpty){
                return Center(child: CircularProgressIndicator());
              }
              else{
                return GridView.count(
                  crossAxisCount: 2, // biar setiap row hanya nampilin 2 produk
                  childAspectRatio: productWidth / (productWidth + 100), // atur tinggi rownya
                  // loop data produk
                  children: value.products.map((product) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: product),
                          ),
                        );
                      },
                      child: Container(
                        width: productWidth,
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Atur warna latar belakang sesuai kebutuhan
                          borderRadius: BorderRadius.circular(10), // Atur border radius sesuai kebutuhan
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: productWidth * 0.7, // Mengambil 70% dari lebar kolom
                              height: productWidth * 0.7,
                              child: Image.network(
                                product.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 1, // Atur jumlah maksimum baris menjadi 2
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    '\$${product.price}',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(height: 8.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      bool productExists = value.isProductExists(product.id);
                                      if (!productExists) {
                                        value.add(product);

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Added to Chart successfully'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Product already exists in the chart'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text('Add to Cart'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ],
    ),

    );
  }
}
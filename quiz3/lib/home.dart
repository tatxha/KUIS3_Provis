import 'package:flutter/material.dart';
import 'package:quiz3/auth/auth.dart';
import 'package:quiz3/detail_product.dart';
import 'package:quiz3/chart.dart';
import 'package:quiz3/model/product.dart';
import 'package:quiz3/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  AuthService auth = AuthService();
  String _token = "";

  @override
  void initState() {
    super.initState();
    _fetchToken();
  }

  Future<void> _fetchToken() async {
    // Fetch the token asynchronously
    _token = await auth.getToken();
    // Once token is fetched, trigger a rebuild of the widget tree
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final value = Provider.of<ProductProvider>(context);

    if (value.products.isEmpty) {
      value.fetchData();
    }
  
    // Mendapatkan informasi tentang ukuran layar perangkat
    final screenWidth = MediaQuery.of(context).size.width;

    // Menghitung lebar widget responsif
    final productWidth = (screenWidth - 24) / 2; // Mengurangi margin dari total lebar layar

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Barayafoods"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search foods...', // Teks hint untuk input field
              prefixIcon: Icon(Icons.search), // Icon pencarian di sebelah kiri input field
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            onChanged: (value) {
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
                                ProductProvider.url + "items_image/" + product.id,
                                headers: <String, String>{
                                  'accept': 'application/json',
                                  'Authorization': 'Bearer $_token',
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(child: CircularProgressIndicator());
                                },
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
                                    'Rp${product.price}',
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
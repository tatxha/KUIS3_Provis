import 'package:flutter/material.dart';
import 'package:quiz3/auth/auth.dart';
import 'package:quiz3/main.dart';
import 'package:quiz3/model/cart.dart';
import 'package:quiz3/model/product.dart';
import 'package:quiz3/provider/cart_provider.dart';
import 'package:quiz3/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({Key? key, required this.product}) : super(key: key);

  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    var value = context.watch<ProductProvider>();

    var cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.network(
                ProductProvider.url + "items_image/" + product.id,
                headers: <String, String>{
                  'accept': 'application/json',
                  'Authorization': 'Bearer ${auth.getToken()}',
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                fit: BoxFit.contain,
              )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.only(right: 8.0),
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      child: Text(
                                        'Rp${product.price}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Description:',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            product.description,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Detail Information:',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5.0),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      child: Text(
                                        'Location:',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Expanded(child:
                                    Container(                                     child: Text(
                                        'Loyem Ipcum',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      child: Text(
                                        'Message:',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Expanded(child:
                                    Container(                                     
                                      child: Text(
                                        'Loyem Ipcum',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      child: Text(
                                        'Type:',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Expanded(child:
                                    Container(                                     child: Text(
                                        'Loyem Ipcum',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              onPressed: () async {
                bool productExists = cart.isProductExists(product.id);
                if (!productExists) {
                  var id = await auth.getId();
                  cart.add(context, Cart(item_id: product.id, user_id: id, quantity: '1', id: ''));

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to Cart successfully'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Food already exists in the cart. Go to cart to add quantity'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: Text(
                'Add to Cart',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            SizedBox(height: 30,),
            // Add more details here
          ],
        ),
      ),
    );
  }
}


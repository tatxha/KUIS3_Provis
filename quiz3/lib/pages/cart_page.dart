import 'package:flutter/material.dart';
import 'package:quiz3/auth/auth.dart';
import 'package:quiz3/pages/detail_product_page.dart';
import 'package:quiz3/main.dart';
import 'package:quiz3/model/cart.dart';
import 'package:quiz3/provider/cart_provider.dart';
import 'package:quiz3/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:quiz3/model/product.dart';
import 'package:quiz3/provider/status_provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool fetched = false;

  int _selectedIndex = 0;
  int quantity = 1;
  int totalPrice = 0;

  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";

  @override
  void initState() {
    super.initState();
    _fetchToken();
  }

  Future<void> _fetchToken() async {
    // Fetch the token asynchronously
    _token = await auth.getToken();
    _user_id = await auth.getId();
    // Once token is fetched, trigger a rebuild of the widget tree
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var value = context.watch<CartProvider>();
    var productvalue = context.watch<ProductProvider>();
    var status = context.watch<StatusProvider>();

    totalPrice = value.cart.fold(
      0,
      (previousValue, cartItem) =>
          previousValue +
          int.parse(productvalue.allProducts.firstWhere(
            (product) => product.id == cartItem.item_id,
          ).price) * int.parse(cartItem.quantity),
    );

    String statusMsg(){
      if(value.cart.isEmpty && status.current.status == "belum_bayar"){
        return "Your cart is empty";
      }
      else if(status.current.status == "belum_bayar"){
        return "Waiting for payment";
      }
      else if(status.current.status == "sudah_bayar"){
        return "Waiting for confirmation";
      }
      else if(status.current.status == "pesanan_diterima"){
        return "Resto accepted";
      }
      else if(status.current.status == "pesanan_ditolak"){
        return "Resto rejected";
      }
      else if(status.current.status == "pesanaan_diantar"){
        return "Driver on the way";
      }
      else if(status.current.status == "pesanan_selesai"){
        return "Order completed";
      }

      return "";
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false, // Tambahkan baris ini
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Text(
                          statusMsg(),
                          style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            children: [
                              Text('Total: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                              Text('Rp$totalPrice', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                            ],
                          ),
                      ),
                      Expanded(child:
                        Visibility(
                          child: ElevatedButton(
                            onPressed: () {
                              if(value.cart.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Your cart is empty'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                          
                              if(status.current.status == "belum_bayar" && !value.cart.isEmpty){
                                status.pay();
                              }
                            },
                            child: Text((status.current.status == "belum_bayar" ? 'Pay Now' : 'Paid')),
                          ),
                          visible: !value.cart.isEmpty,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Visibility(
                        child: ElevatedButton(
                          onPressed: () {
                            status.accept();
                            value.removeAll();
                          },
                          child: Text('Accept'),
                        ),
                        visible: status.current.status == "sudah_bayar",
                      ),
                      SizedBox(width: 10,),
                      Visibility(
                        child: ElevatedButton(
                          onPressed: () {
                            status.reject();
                            value.removeAll();
                          },
                          child: Text('Reject'),
                        ),
                        visible: status.current.status == "sudah_bayar",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.items.length,
              itemBuilder: (context, index) {
                final product = value.items.firstWhere((product) => product.id == value.items[index].id);
                final cartItem = value.cart.firstWhere((cartItem) => cartItem.id == value.cart[index].id);
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
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
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
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
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
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(
                                        product.title,
                                        maxLines: 2, // Atur jumlah maksimum baris menjadi 2
                                      overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Row(children: [
                                            Text('Total: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                            Text('Rp${int.parse(product.price) * int.parse(cartItem.quantity)}', style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Expanded(child: 
                                        Container(
                                          child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Container(
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                                // decoration: BoxDecoration(
                                                //   borderRadius: BorderRadius.circular(5.0)
                                                // ),
                                                child: Icon(Icons.remove),
                                              ),
                                              onPressed: () {
                                                int qty = int.parse(cartItem.quantity) - 1;
                                                value.remove(context, cartItem.id);
                                                if(qty > 0)
                                                  value.add(context, Cart(item_id: product.id, user_id: _user_id, quantity: qty.toString(), id: ''));
                                              },
                                            ),
                                            Text(
                                              '${cartItem.quantity}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            IconButton(
                                              icon: Container(
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                                // decoration: BoxDecoration(
                                                //   borderRadius: BorderRadius.circular(5.0)
                                                // ),
                                                child: Icon(Icons.add),
                                              ),
                                              onPressed: () {
                                                int qty = int.parse(cartItem.quantity) + 1;
                                                value.remove(context, cartItem.id);
                                                value.add(context, Cart(item_id: product.id, user_id: _user_id, quantity: qty.toString(), id: ''));
                                              },
                                            ),
                                          ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        value.remove(context, cartItem.id);
                                      },
                                      child: Text('Delete', style: TextStyle(fontSize: 20),),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
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

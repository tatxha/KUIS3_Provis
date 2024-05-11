import 'package:flutter/material.dart';
import 'package:quiz3/main.dart';
import 'package:quiz3/provider/cart_provider.dart';
import 'package:quiz3/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:quiz3/model/product.dart';
import 'package:quiz3/provider/status_provider.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int _selectedIndex = 0;
  int quantity = 1;
  // double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    var value = context.watch<ProductProvider>();
    var cart = context.watch<CartProvider>();
    var status = context.watch<StatusProvider>();

    String statusMsg(){
      if(cart.cart.isEmpty && status.current.status == "belum_bayar"){
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
        title: Text('Orders'),
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
                  SizedBox(height: 10),
                  Visibility(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            if(status.current.status == "pesanan_diterima"){
                              status.onTheWay();
                            }
                            else if(status.current.status == "pesanaan_diantar"){
                              status.delivered();
                            }
                            else{
                              status.unpaid();
                            }
                          },
                          child: Text('Refresh Status'),
                        ),
                      ],
                    ),
                    visible: status.current.status != "belum_bayar" && status.current.status != "sudah_bayar",
                  ),

                ],
              ),
            ),
          ],
        ),
      ),                    
    );
  }

}
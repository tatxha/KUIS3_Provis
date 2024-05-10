import 'package:flutter/material.dart';
import 'package:quiz3/auth/auth.dart';
import 'package:quiz3/main.dart';
import 'package:quiz3/provider/cart_provider.dart';
import 'package:quiz3/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:quiz3/model/product.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  int _selectedIndex = 0;
  int quantity = 1;
  // double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    var value = context.watch<ProductProvider>();
    // if (totalPrice == 0 && value.chart.isNotEmpty) {
    //   totalPrice = double.parse(value.chart.first.price);
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart'),
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
                          'Waiting for payment',
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
                              Text('Total Orders: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                              Text('00.00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                            ],
                          ),
                      ),
                      Expanded(child:
                        ElevatedButton(
                          onPressed: () {
                          },
                          child: Text('Pay Now'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.chart.length,
              itemBuilder: (context, index) {
                final product = value.chart[index];
                return 
                Container(
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
                          product.image, 
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
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    child: Row(children: [
                                        Text('Total: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                        Text('\$${product.totalPrice}', style: TextStyle(fontSize: 14)),
                                        // Text('${product.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 14)),
                                        // Expanded(child: Text('$totalPrice')),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: 
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
                                            setState(() {
                                              if (product.quantity > 1) {
                                                product.quantity--;
                                                product.totalPrice = double.parse(product.price) * product.quantity;
                                              }
                                            });
                                          },
                                        ),
                                        Text(
                                          '${product.quantity}',
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
                                            setState(() {
                                              product.quantity++;
                                              product.totalPrice = double.parse(product.price) * product.quantity;
                                            });
                                          },
                                        ),
                                      ],
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
                                      value.remove(product);
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
                );
              },
            ),
          ],
        ),
      ),                    
    );
  }

}

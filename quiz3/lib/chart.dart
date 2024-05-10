import 'package:flutter/material.dart';
import 'package:quiz3/main.dart';
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
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    var value = context.watch<ProductProvider>();
    if (totalPrice == 0 && value.chart.isNotEmpty) {
      totalPrice = double.parse(value.chart.first.price);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false, // Tambahkan baris ini
      ),

      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: value.chart.length,
          itemBuilder: (context, index) {
            final product = value.chart[index];
            return Container(
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
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
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
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(child: Container(
                              
                              child: Text(
                                textAlign: TextAlign.right,
                                '\$${product.price}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ))
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Row(children: [
                                  Text('Total: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  Text('$totalPrice', style: TextStyle(fontSize: 14)),
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
                                        if (quantity > 1) {
                                          quantity--;
                                          totalPrice = double.parse(product.price) * quantity;
                                        }
                                      });
                                    },
                                  ),
                                  Text(
                                    '$quantity',
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
                                        quantity++;
                                        totalPrice = double.parse(product.price) * quantity;
                                      });
                                    },
                                  ),
                                ],
                                                              ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                value.remove(product);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 5.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                child: Text(
                                  'Pay Now',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                value.remove(product);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
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
      ),                    
    );
  }

}

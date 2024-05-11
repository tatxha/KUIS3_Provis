import 'package:flutter/material.dart';
import 'package:quiz3/main.dart';
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

    var status = context.watch<StatusProvider>();

    String statusMsg(){
      if(status.current.status == "belum_bayar"){
        return "Waiting for payment";
      }
      else if(status.current.status == "status diupdate sudah bayar"){
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
                  // SizedBox(height: 15,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text('Total Orders: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  //     Text('000.00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  //   ],
                  // ),
                  SizedBox(height: 10),
                  Visibility(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            print(status.current.status);
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
                    visible: status.current.status != "belum_bayar" && status.current.status != "status diupdate sudah bayar",
                  ),

                ],
              ),
            ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: value.chart.length,
            //   itemBuilder: (context, index) {
            //     final product = value.chart[index];
            //     return 
            //     Container(
            //       padding: EdgeInsets.all(5.0),
            //       margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            //       decoration: BoxDecoration(
            //         color: Colors.white, // Atur warna latar belakang sesuai kebutuhan
            //         borderRadius: BorderRadius.circular(10), // Atur border radius sesuai kebutuhan
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.5),
            //             spreadRadius: 1,
            //             blurRadius: 4,
            //             offset: Offset(0, 3), // changes position of shadow
            //           ),
            //         ],
            //       ),
            //       child: Row(
            //         children: [
            //           Container(
            //             width: MediaQuery.of(context).size.width * 0.2,
            //             height: MediaQuery.of(context).size.height * 0.2,
            //             child: Image.network(
            //               product.img_name, 
            //               fit: BoxFit.contain,
            //             ),
            //           ),
            //           Expanded(
            //             child: Container(
            //               padding: EdgeInsets.only(left: 12.0),
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //                 child: Column(
            //                   children: [
            //                     Row(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                           // color: Colors.amber,
            //                           width: MediaQuery.of(context).size.width * 0.5,
            //                           margin: EdgeInsets.only(right: 3),
            //                           child: Text(
            //                             product.title,
            //                             maxLines: 2, // Atur jumlah maksimum baris menjadi 2
            //                           overflow: TextOverflow.ellipsis,
            //                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //                           ),
            //                         ),
            //                         Expanded(
            //                           child: Container(
            //                             // color: Colors.deepOrangeAccent,
            //                             child: Text(
            //                               'x ${product.quantity}',
            //                               textAlign: TextAlign.right,
            //                               style: TextStyle(fontSize: 14),
            //                             ),
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                     SizedBox(height: 10,),
            //                     Row(
            //                       // mainAxisAlignment: MainAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                           // color: Colors.blue,
            //                           width: MediaQuery.of(context).size.width * 0.2,
            //                           child: Row(children: [
            //                               Text('Total: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            //                               Text('\$${product.totalPrice}', style: TextStyle(fontSize: 14)),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
                                
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),                    
    );
  }

}
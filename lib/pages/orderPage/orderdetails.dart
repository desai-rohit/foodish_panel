import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app_panel/pages/orderPage/orderpage_provider.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;
   const OrderDetails({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
     OrderPageProvider provider = Provider.of<OrderPageProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Deatils"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          
          children: [
            CachedNetworkImage(
              width: 200,
              height: 200,
              imageUrl:
                  data.image,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                overflow:TextOverflow. ellipsis,
                  data.foodname.toString(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                 Text(
                   "₹ ${data.price}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Quntity 1",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                 "₹ ${data.countTotalPrice}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {},
                      child: const Text("Reject")),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                         provider.newOrderUpdate(data.id);
                      },
                      child: const Text("Accept")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

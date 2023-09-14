import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app_panel/pages/orderPage/orderpage_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Timer? timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrderPageProvider>(context, listen: false).getOrderData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderPageProvider>(
      builder: (context, value, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: [
                Text(textAlign: TextAlign.center, "New Order"),
                Text(textAlign: TextAlign.center, "Ship Order"),
                Text(textAlign: TextAlign.center, "Complate Order"),
              ]),
            ),
            body: TabBarView(children: [
              value.isloading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : ListView.builder(
                      itemCount: value.orderData.length,
                      itemBuilder: (context, index) {
                        return value.orderData[index].orderaccepted == false
                            ? Container(
                                margin: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(16)),
                                child: ListTile(
                                  leading: Image.network(
                                      value.orderData[index].image),
                                  title: Text(value.orderData[index].foodname),
                                  subtitle: Text(
                                      "RS ${value.orderData[index].price}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        value.newOrderUpdate(
                                            value.orderData[index].id);
                                      },
                                      icon: const Icon(Icons.check_box)),
                                ),
                              )
                            : Container();
                      }),
              value.isloading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : ListView.builder(
                      itemCount: value.orderData.length,
                      itemBuilder: (context, index) {
                        return value.orderData[index].orderaccepted == true &&
                                value.orderData[index].ordership == false
                            ? Container(
                                margin: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(16)),
                                child: ListTile(
                                  leading: Image.network(
                                      value.orderData[index].image),
                                  title: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            value.orderData[index].foodname),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.location_on),
                                        onPressed: () async {
                                          if (!await launchUrl(Uri.parse(
                                              "https://www.google.com/maps/search/?api=1&query=${value.orderData[index].address[0].lat},${value.data[index].address[0].lng}"))) {
                                            throw Exception(
                                                'Could not launch ${Uri.parse("https://www.google.com/maps/search/?api=1&query=${value.data[index].address[0].lat},${value.data[index].address[0].lng}")}');
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                  subtitle:
                                      Text("R${value.orderData[index].price}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        value.shipOrderUpdate(
                                            value.orderData[index].id);
                                      },
                                      icon: const Icon(
                                        Icons.check_box,
                                        size: 24,
                                      )),
                                ),
                              )
                            : Container();
                      }),
              ListView.builder(
                  itemCount: value.orderData.length,
                  itemBuilder: (context, index) {
                    return value.orderData[index].orderaccepted == true &&
                            value.orderData[index].ordership == true
                        ? Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(16)),
                            child: ListTile(
                              leading:
                                  Image.network(value.orderData[index].image),
                              title: Text(value.orderData[index].foodname),
                              subtitle: Text(value.orderData[index].price),
                              trailing: const Icon(
                                Icons.check_box,
                                color: Colors.green,
                              ),
                            ),
                          )
                        : Container();
                  }),
            ]),
            floatingActionButton: Container(
              width: 100,
              padding: const EdgeInsets.only(bottom: 50),
              child: FloatingActionButton(
                onPressed: () {
                  Provider.of<OrderPageProvider>(context, listen: false)
                      .getOrderData();
                },
                child: const Text("Refersh"),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // timer!.cancel();
    super.dispose();
  }
}

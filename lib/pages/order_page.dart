import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app_panel/provider/App_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Timer? timer;
  // StreamController<List<OrderModel>> streamController =
  //     StreamController<List<OrderModel>>();

  // @override
  // void initState() {
  //   super.initState();
  //   // Provider.of<AppProvider>(context, listen: false).getOrders();

  //   timer = Timer.periodic(const Duration(seconds: 3), (timer) {
  //     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     //   Provider.of<AppProvider>(context, listen: false).getOrders();
  //     // });

  //      Provider.of<AppProvider>(context, listen: false).getOrders();
  //     // streamController.sink
  //     //     .add(Provider.of<AppProvider>(context, listen: false).data);
  //     print("restart");
  //   });
  // }

  // @override
  // void dispose() {
  //   // initState();

  //   // streamController.close();

  //   //Provider.of<AppProvider>(context, listen: false).streamController.close();

  //   //streamController.close();
  //   timer!.cancel();
  //   //Provider.of<AppProvider>(context, listen: false).streamController.close();

  //   super.dispose();
  // }

  @override
  void initState() {
    //  timer = Timer.periodic(const Duration(seconds: 5), (timer) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AppProvider>(context, listen: false).getOrderData();
    });
    super.initState();
    //  });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, value, child) {
        //streamController.sink.add(value.orderData);
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  labelColor: Theme.of(context).colorScheme.secondary,
                  unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
                  tabs: const [
                    Text("New Order"),
                    Text("Ship Order"),
                    Text("complete"),
                    Text("demo"),
                  ]),
            ),
            body: TabBarView(children: [
              ListView.builder(
                  itemCount: value.orderData.length,
                  itemBuilder: (context, index) {
                    return value.orderData[index].orderaccepted == false
                        ? value.isloading == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              )
                            : Container(
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
              ListView.builder(
                  itemCount: value.orderData.length,
                  itemBuilder: (context, index) {
                    return value.orderData[index].orderaccepted == true &&
                            value.orderData[index].ordership == false
                        ? value.isloading == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              )
                            : Container(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(value.orderData[index].foodname),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () async {
                                            if (!await launchUrl(Uri.parse(
                                                "https://www.google.com/maps/search/?api=1&query=${value.orderData[index].address[0].lat},${value.data[index].address[0].lng}"))) {
                                              throw Exception(
                                                  'Could not launch ${Uri.parse("https://www.google.com/maps/search/?api=1&query=${value.data[index].address[0].lat},${value.data[index].address[0].lng}")}');
                                            }
                                          },
                                          child: const Text(
                                            "Direction",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))
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
                                        color: Colors.red,
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
              ListView.builder(
                  itemCount: value.orderData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: Image.network(value.orderData[index].image),
                        title: Text(value.orderData[index].foodname),
                        subtitle: Text(value.orderData[index].price),
                        trailing: const Icon(
                          Icons.check_box,
                          color: Colors.green,
                        ),
                      ),
                    );
                  })
            ]),
            floatingActionButton: Container(
              width: 100,
              padding: const EdgeInsets.only(bottom: 50),
              child: FloatingActionButton(
                onPressed: () {
                  Provider.of<AppProvider>(context, listen: false)
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

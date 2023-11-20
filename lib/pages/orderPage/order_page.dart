import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/model/order_modelcopy.dart';
import 'package:food_app_panel/pages/orderPage/order_service.dart';
import 'package:food_app_panel/pages/orderPage/orderdetails.dart';
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
    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrderPageProvider>(context, listen: false).getOrderData();
    });
    //});

    super.initState();
  }

  @override
  void dispose() {
    // timer!.cancel();
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    var refreshKey = GlobalKey<RefreshIndicatorState>();

    return Consumer<OrderPageProvider>(
      builder: (context, value, child) {
        return StreamBuilder(
          stream: OrderService().getOrderslist(currentEmail),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else if (snapshot.hasData) {
              List<OrderModelCopy> data = snapshot.data;

              return DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text("Order"),
                    centerTitle: true,
                    bottom: const TabBar(isScrollable: true, tabs: [
                      Text(textAlign: TextAlign.center, "New Order"),
                      Text(textAlign: TextAlign.center, "Ship Order"),
                      Text(textAlign: TextAlign.center, "Complate Order"),
                    ]),
                    actions: [
                      IconButton(
                          onPressed: () {
                            value.getOrderData();
                          },
                          icon: const Icon(Icons.refresh,size: 28,))
                    ],
                  ),
                  body: RefreshIndicator(
                    key: refreshKey,
                    backgroundColor: Colors.white,
                    color: Colors.red,
                    onRefresh: () async {
                      value.getOrderData();
                    },
                    child: TabBarView(children: [
                      value.isloading == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            )
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return data[index].orderaccepted == false
                                    ? Container(
                                        margin: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: RefreshIndicator(
                                          backgroundColor: Colors.white,
                                          color: Colors.red,
                                          onRefresh: () async {
                                            value.getOrderData();
                                          },
                                          child: ListTile(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderDetails(
                                                              data: data[index],
                                                            )));
                                              },
                                              leading: CachedNetworkImage(
                                                imageUrl: data[index].image,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                              //  Image.network(
                                              //     data[index].image),
                                              title: Text(data[index].foodname),
                                              subtitle: Text(
                                                  "RS ${data[index].price}"),
                                              trailing: const Icon(
                                                  Icons.arrow_forward_ios)),
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
                                return value.orderData[index].orderaccepted ==
                                            true &&
                                        value.orderData[index].ordership ==
                                            false
                                    ? Container(
                                        margin: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: ListTile(
                                          leading: CachedNetworkImage(
                                            imageUrl:
                                                value.orderData[index].image,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                          // Image.network(
                                          //     value.orderData[index].image),
                                          title: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    value.orderData[index]
                                                        .foodname),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.location_on),
                                                onPressed: () async {
                                                  if (!await launchUrl(Uri.parse(

                                                      // "google.navigation:q=${value.orderData[index].address[0].lat},${value.orderData[index].address[0].lat}&mode=d"
                                                      "https://www.google.com/maps/search/?api=1&query=${value.orderData[index].address[0].lat},${value.orderData[index].address[0].lng}"))) {
                                                    throw Exception(
                                                        'Could not launch ${Uri.parse("https://www.google.com/maps/search/?api=1&query=${value.orderData[index].address[0].lat},${value.orderData[index].address[0].lng}")}');
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                          subtitle: Text(
                                              "R${value.orderData[index].price}"),
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
                            return value.orderData[index].orderaccepted ==
                                        true &&
                                    value.orderData[index].ordership == true
                                ? Container(
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: ListTile(
                                      leading: CachedNetworkImage(
                                        imageUrl: value.orderData[index].image,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      title:
                                          Text(value.orderData[index].foodname),
                                      subtitle:
                                          Text(value.orderData[index].price),
                                      trailing: const Icon(
                                        Icons.check_box,
                                        color: Colors.green,
                                      ),
                                    ),
                                  )
                                : Container();
                          }),
                    ]),
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}

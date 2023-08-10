import 'package:flutter/material.dart';
import 'package:food_app_panel/provider/App_provider.dart';
import 'package:food_app_panel/services/api_services.dart';
import 'package:provider/provider.dart';

class UpdateProducts extends StatefulWidget {
  dynamic data;
  UpdateProducts({super.key, required this.data});

  @override
  State<UpdateProducts> createState() => _UpdateProductsState();
}

class _UpdateProductsState extends State<UpdateProducts> {
  @override
  void initState() {
    // TODO: implement initState
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);

    provider.productsNameUpdateController.text = widget.data.name;
    provider.productsdesUpdateController.text = widget.data.des;
    provider.productspriceUpdateController.text = widget.data.price.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: value.productsNameUpdateController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        label: Text("Products Name")),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    maxLines: 10,
                    controller: value.productsdesUpdateController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Products des")),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: value.productspriceUpdateController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Products price")),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          productUpdate(
                                  id: widget.data.id,
                                  foodName:
                                      value.productsNameUpdateController.text,
                                  des: value.productsdesUpdateController.text,
                                  price:
                                      value.productspriceUpdateController.text)
                              .then((v) => value.getAllProducts());
                        },
                        child: const Text("Update")),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

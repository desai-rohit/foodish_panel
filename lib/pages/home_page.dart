import 'package:flutter/material.dart';
import 'package:food_app_panel/pages/update_products.dart';
import 'package:food_app_panel/provider/App_provider.dart';
import 'package:provider/provider.dart';

List<String> categoryImage = [
  "assets/vegPizza.png",
  "assets/nonvegPizza.png",
  "assets/burgar.png",
  "assets/nonveg_burgar.png",
  "assets/desserts.png"
];

List<String> categoryName = [
  "Veg Pizza",
  "Nonveg Pizza",
  "Veg Burgar",
  "Nonveg Burgar",
  "Desserts"
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AppProvider>(context, listen: false).getAllProducts();
      print("home init");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, value, child) {
        return value.isloading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : value.prodcutsData.isEmpty
                ? const Center(
                    child: Text("No Any Products found"),
                  )
                : Scaffold(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    appBar: AppBar(
                      title: const Text("Home"),
                      centerTitle: true,
                    ),
                    body: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoryImage.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.all(4),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            categoryImage[index],
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          Text(categoryName[index])
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.prodcutsData.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 6 / 8.5,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateProducts(
                                                      data: value.prodcutsData[
                                                          index])));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.network(
                                            value.prodcutsData[index].image!,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            cacheHeight: 115,
                                            cacheWidth: 115,
                                            fit: BoxFit.fill,
                                          ),
                                          Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            value.prodcutsData[index].name!,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            value.prodcutsData[index]
                                                .restorantName!,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "RS ${value.prodcutsData[index].price}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                          const Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ));
      },
    );
  }
}

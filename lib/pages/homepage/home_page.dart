import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/pages/homepage/homepage_provider.dart';
import 'package:food_app_panel/pages/updateProduct/update_products.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

List<String> categoryImage = [
  "assets/all_food.png",
  "assets/vegPizza.png",
  "assets/nonvegPizza.png",
  "assets/burgar.png",
  "assets/nonveg_burgar.png",
  "assets/desserts.png"
];

List<String> categoryName = [
  "All Food",
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
      Provider.of<HomePageProvider>(context, listen: false).getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, value, child) {
        return

            // value.isloading == true
            //     ? const Center(
            //         child: CircularProgressIndicator(
            //           color: Colors.red,
            //         ),
            //       )
            //     :

            Scaffold(
                // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  child: Material(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    child: InkWell(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      onTap: () {
                                        categoryName[index] == "All Food"
                                            ? value.getAllProducts()
                                            : value.getcategoryProducts(
                                                gmail: currentEmail!,
                                                category:
                                                    categoryName[index++]);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(4),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
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
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // value.prodcutsData.isEmpty
                        //     ? const Center(
                        //         child: Text(
                        //           "No Any Products found",
                        //           style: TextStyle(
                        //               fontSize: 18,
                        //               fontWeight: FontWeight.bold),
                        //         ),
                        //       )
                        //     :
                        value.isloading == true
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 5,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 6 / 9.5,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                      width: 50.0,
                                      height: 100.0,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[500]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width: 50,
                                          height: 100,
                                        ),
                                      ));
                                })
                            :
                              value.prodcutsData.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Any Products found",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            :
                             GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.prodcutsData.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 6 / 9.5,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return Material(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    child: InkWell(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateProducts(
                                                        data:
                                                            value.prodcutsData[
                                                                index])));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CachedNetworkImage(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              imageUrl: value
                                                  .prodcutsData[index].image!,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
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
                                    ),
                                  );
                                }),
                        const Padding(padding: EdgeInsets.only(bottom: 16))
                      ],
                    ),
                  ),
                ));
      },
    );
  }
}

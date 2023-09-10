import 'dart:math';
import 'package:ecommerce_app/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/products/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductsBloc productsBloc = ProductsBloc();
  int quantity = 1;
  int generateRandomId() {
    Random random = Random();
    return random.nextInt(999);
  }

  Container ImageSlider(String imageUrl) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              image: NetworkImage(imageUrl), fit: BoxFit.cover)),
    );
  }

  @override
  void initState() {
    productsBloc.add(ProductDetailFetchEvent(productId: widget.productId));
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 233, 166, 67)),
        elevation: 0,
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        bloc: productsBloc,
        listenWhen: (previous, current) => current is ProductActionState,
        buildWhen: (previous, current) => current is! ProductActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProductsFetchingLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ProductDetailFetchingSuccessState:
              final successState = state as ProductDetailFetchingSuccessState;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue,
                            offset: Offset(0.0, 5.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image(
                          image: NetworkImage(successState.product.thumbnail),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            successState.product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            " Rs: ${successState.product.price}, ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blue),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            "Description :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color.fromARGB(255, 135, 210, 245),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  successState.product.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Images :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            height: 300,
                            child: PageView.builder(
                              // onPageChanged: sliderCubit.changePage,
                              itemBuilder: (context, index) {
                                var imageUrl =
                                    successState.product.images[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ImageSlider(imageUrl),
                                );
                              },
                              itemCount: successState.product.images.length,
                            ),
                          ),
                          Text(
                            "Quantity",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (quantity != 1) {
                                          quantity = quantity - 1;
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffD4ADFC),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    child: Icon(Icons.minimize)),
                                SizedBox(width: 15),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        quantity = quantity + 1;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffD4ADFC),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    child: Icon(Icons.add)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SizedBox(
                              width: 240,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  int cartId = generateRandomId();
                                  int productTotalAmount =
                                      quantity * successState.product.price;
                                  context.read<CartBloc>().add(
                                      CartDataStoreEvent(
                                          cartId,
                                          successState.product.title,
                                          successState.product.price,
                                          quantity,
                                          productTotalAmount,
                                          successState.product.thumbnail));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Successfully added to cart"),
                                    backgroundColor: Colors.green,
                                  ));
                                },
                                icon: Icon(Icons.trolley),
                                label: Text("Add to Cart"),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.lightBlue,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

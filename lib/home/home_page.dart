import 'package:ecommerce_app/cart/ui/cart_screen.dart';
import 'package:ecommerce_app/order/ui/order_view.dart';
import 'package:ecommerce_app/products/ui/product_detail_page.dart';

import 'package:ecommerce_app/products/ui/products_page.dart';
import 'package:ecommerce_app/search/bloc/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final List<Widget> _pages = [ProductsPage(), CartScreen(), OrderScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "E-Commerce",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: Icon(Icons.search_outlined),
            color: Colors.black,
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.transparent,
        elevation: 0,
        unselectedItemColor: Color(0xffD4ADFC),
        selectedItemColor: Colors.amber,
        onTap: (index) {
          if (index == 2)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderScreen()),
            );
          else {
            setState(() {
              currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Products'),
          BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits), label: 'Cart'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.person_3_rounded), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_edu_rounded), label: 'Order History'),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    String querySearch = (query.isEmpty) ? "" : query.toLowerCase();
    if (querySearch != "") {
      context
          .read<SearchBloc>()
          .add(SearchProductFetchEvent(searchQuery: querySearch));
    }

    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      switch (state.runtimeType) {
        case SearchProductFetchingLoadingState:
          return Center(child: CircularProgressIndicator());
        case SearchProductFetchingErrorState:
          final errorState = state as SearchProductFetchingErrorState;
          return Center(
            child: Text(errorState.error),
          );
        case SearchProductSuccessState:
          final successState = state as SearchProductSuccessState;
          return ListView.builder(
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              itemCount: successState.searchProducts.length,
              itemBuilder: (context, index) {
                final searchProduct = successState.searchProducts[index];
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchProduct.products.length,
                    itemBuilder: (context, index) {
                      final searchProd = searchProduct.products[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ProductDetailPage(
                                        productId: searchProd.id))));
                          },
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(searchProd.thumbnail),
                          ),
                          title: Text(searchProd.title),
                          subtitle: Divider(
                            thickness: 2,
                            color: Colors.teal,
                          ),
                        ),
                      );
                    });
              });
        default:
          return Center(child: const Text('Enter Product Name'));
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    String querySearch = (query.isEmpty) ? "" : query.toLowerCase();
    if (querySearch != "") {
      context
          .read<SearchBloc>()
          .add(SearchProductFetchEvent(searchQuery: querySearch));
    }

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchProductFetchingLoadingState:
            return Center(child: CircularProgressIndicator());
          case SearchProductFetchingErrorState:
            final errorState = state as SearchProductFetchingErrorState;
            return Center(
              child: Text(errorState.error),
            );
          case SearchProductSuccessState:
            final successState = state as SearchProductSuccessState;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: successState.searchProducts.length,
                itemBuilder: (context, index) {
                  final searchProduct = successState.searchProducts[index];
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchProduct.products.length,
                      itemBuilder: (context, index) {
                        final searchProd = searchProduct.products[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ProductDetailPage(
                                          productId: searchProd.id))));
                            },
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  NetworkImage(searchProd.thumbnail),
                            ),
                            title: Text(searchProd.title),
                            subtitle: Divider(
                              thickness: 1,
                              color: Colors.teal,
                            ),
                          ),
                        );
                      });
                });
          default:
            return Center(child: const Text("Enter Product Name"));
        }
      },
    );
  }
}

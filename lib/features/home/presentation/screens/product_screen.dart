import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:task/core/utils/loader.dart';

import 'package:task/core/theme/pallete.dart';

import 'package:task/features/home/domain/entities/product.dart';

import 'package:task/features/home/presentation/bloc/home_bloc.dart';

import 'package:task/features/home/presentation/screens/product_view.dart';

import 'package:task/features/home/presentation/widgets/custom_field.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late TextEditingController controller;

  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();

    context.read<HomeBloc>().add(FetchAllProductsEvent());

    controller.addListener(() {
      filterProducts();
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void filterProducts() {
    final state = context.read<HomeBloc>().state;

    final query = controller.text.toLowerCase().trim();

    log('Current Query: $query');

    if (state.products.isEmpty) return;

    setState(() {
      if (query.isEmpty) {
        filteredProducts = List.from(state.products);
      } else {
        filteredProducts = state.products.where((product) {
          return product.title.toLowerCase().contains(query);
        }).toList();
      }
    });

    log('Filtered Products: ${filteredProducts.map((p) => p.title).toList()}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.errorMessage ?? "Something went wrong")),
          );
        }

        if (state.products.isNotEmpty) {
          filteredProducts = List.from(state.products);
        }
      },
      builder: (context, state) {
        if (state.products.isNotEmpty && filteredProducts.isEmpty) {
          filteredProducts = List.from(state.products);
        }

        return LoadingWrapper(
          isLoading: state.isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                CustomField(controller: controller, hint: 'Search Product'),
                const SizedBox(height: 10),
                if (controller.text.isNotEmpty)
                  Text(
                    '${filteredProducts.length} results found',
                    style: const TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 10),
                Expanded(
                  child: filteredProducts.isEmpty
                      ? const Center(child: Text('No products found'))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final singleProduct = filteredProducts[index];

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              height: 270,
                              decoration: BoxDecoration(
                                color: Pallete.backgroundColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            ProductView.route(singleProduct));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 150,
                                        color: Pallete.itemBackgroundColor,
                                        child: Image.network(
                                            singleProduct.thumbnail),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          singleProduct.title,
                                          style: Pallete.normalSizeText
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "\$ ${singleProduct.price}",
                                          style: Pallete.normalSizeText
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          singleProduct.rating.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        RatingBarIndicator(
                                          rating: singleProduct.rating,
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 16,
                                          direction: Axis.horizontal,
                                        ),
                                      ],
                                    ),
                                    Text(singleProduct.brand,
                                        style: Pallete.normalSizeText
                                            .copyWith(color: Colors.grey)),
                                    Text(singleProduct.category,
                                        style: Pallete.normalSizeText
                                            .copyWith(fontSize: 10)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

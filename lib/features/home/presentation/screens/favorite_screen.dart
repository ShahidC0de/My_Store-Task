import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/utils/loader.dart';
import 'package:task/core/theme/pallete.dart';
import 'package:task/features/home/domain/entities/hive_product.dart';
import 'package:task/features/home/presentation/bloc/home_bloc.dart';
import 'package:task/features/home/presentation/widgets/custom_field.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchFavoriteProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final favoriteProducts = state.products.where((product) {
            return state.favoriteProducts.any((fav) => fav.id == product.id);
          }).toList();

          return LoadingWrapper(
            isLoading: state.isLoading,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  CustomField(controller: controller, hint: 'Search'),
                  const SizedBox(height: 10),
                  controller.text.isNotEmpty
                      ? Text(
                          '${favoriteProducts.length} results found',
                          style: TextStyle(color: Colors.grey),
                        )
                      : const SizedBox(height: 10),
                  if (favoriteProducts.isEmpty)
                    const Text('No Favorite Products')
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final singleProduct = favoriteProducts[index];

                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          width: double.infinity,
                          height: 90,
                          color: Pallete.backgroundColor,
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                  singleProduct.thumbnail,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      singleProduct.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "\$ ${singleProduct.price}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Rating: ${singleProduct.rating}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9,
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(
                                              singleProduct.rating.round(),
                                              (index) {
                                            return const Icon(
                                              Icons.star,
                                              size: 10,
                                              color: Colors.amber,
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  context.read<HomeBloc>().add(
                                        StoreFavoriteProductEvent(
                                          product:
                                              HiveProduct(id: singleProduct.id),
                                        ),
                                      );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task/core/utils/loader.dart';
import 'package:task/core/theme/pallete.dart';
import 'package:task/features/home/domain/entities/category.dart';
import 'package:task/features/home/presentation/bloc/home_bloc.dart';
import 'package:task/features/home/presentation/screens/product_view.dart';
import 'package:task/features/home/presentation/widgets/custom_field.dart';

class SelectedCategory extends StatefulWidget {
  final Categgory category;
  static route(Categgory category) => MaterialPageRoute(
      builder: (context) => SelectedCategory(category: category));
  const SelectedCategory({super.key, required this.category});

  @override
  State<SelectedCategory> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  @override
  void initState() {
    context
        .read<HomeBloc>()
        .add(FetchProductsBasedOnProductsEvent(query: widget.category.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          widget.category.name,
          style: Pallete.titleText,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage.toString())));
          }
        },
        builder: (context, state) {
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
                  controller.text.isNotEmpty
                      ? const Text(
                          '234 results found',
                          style: TextStyle(color: Colors.grey),
                        )
                      : const SizedBox(height: 10),
                  Expanded(
                    child: state.categoryBasedProducts.isEmpty
                        ? Text('No products available')
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            itemCount: state.categoryBasedProducts.length,
                            itemBuilder: (context, index) {
                              final singleProduct =
                                  state.categoryBasedProducts[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                height: 270,
                                decoration: BoxDecoration(
                                  color: Pallete.backgroundColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          Text(
                                            "\$ ${singleProduct.price}",
                                            style: Pallete.normalSizeText
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                          style:
                                              Pallete.normalSizeText.copyWith(
                                            color: Colors.grey,
                                          )),
                                      Text(singleProduct.category,
                                          style:
                                              Pallete.normalSizeText.copyWith(
                                            fontSize: 10,
                                          )),
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
      ),
    );
  }
}

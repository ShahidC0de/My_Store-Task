import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task/core/utils/loader.dart';

import 'package:task/core/theme/pallete.dart';
import 'package:task/features/home/domain/entities/category.dart';

import 'package:task/features/home/presentation/bloc/home_bloc.dart';

import 'package:task/features/home/presentation/screens/selected_category.dart';

import 'package:task/features/home/presentation/widgets/custom_field.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late TextEditingController controller;

  List<Categgory> filteredCategories = [];

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();

    context.read<HomeBloc>().add(FetchAllCategoriesEvent());

    controller.addListener(() {
      filterCategories();
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void filterCategories() {
    final state = context.read<HomeBloc>().state;

    final query = controller.text.toLowerCase().trim();

    if (state.categories.isEmpty) return;

    setState(() {
      if (query.isEmpty) {
        filteredCategories = List.from(state.categories);
      } else {
        filteredCategories = state.categories.where((category) {
          return category.slug.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }

        if (state.categories.isNotEmpty) {
          filteredCategories = List.from(state.categories);
        }
      },
      builder: (context, state) {
        if (state.categories.isNotEmpty && filteredCategories.isEmpty) {
          filteredCategories = List.from(state.categories);
        }

        return LoadingWrapper(
          isLoading: state.isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                CustomField(controller: controller, hint: 'Search Categories'),
                const SizedBox(height: 10),
                if (controller.text.isNotEmpty)
                  Text(
                    '${filteredCategories.length} results found',
                    style: const TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: filteredCategories.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 100,
                              crossAxisCount: 2,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: filteredCategories.length,
                            itemBuilder: (context, index) {
                              final singleCategory = filteredCategories[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      SelectedCategory.route(singleCategory));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Stack(children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Image.network(
                                        'https://w7.pngwing.com/pngs/246/825/png-transparent-moisturizer-skin-care-facial-exfoliation-olives-miscellaneous-face-hand.png',
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          singleCategory.slug,
                                          style:
                                              Pallete.normalSizeText.copyWith(
                                            fontSize: 15,
                                          ),
                                        )),
                                  ]),
                                ),
                              );
                            },
                          )
                        : const Center(child: Text('No categories found')),
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

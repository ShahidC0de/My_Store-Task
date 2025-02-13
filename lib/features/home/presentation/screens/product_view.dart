import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/theme/pallete.dart';
import 'package:task/features/home/domain/entities/hive_product.dart';
import 'package:task/features/home/domain/entities/product.dart';
import 'package:task/features/home/presentation/bloc/home_bloc.dart';
import 'package:task/features/home/presentation/widgets/custom_row.dart';

class ProductView extends StatefulWidget {
  final Product _product;
  static route(Product product) => MaterialPageRoute(
      builder: (context) => ProductView(
            product: product,
          ));
  const ProductView({super.key, required Product product}) : _product = product;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          'Product Details',
          style: Pallete.titleText,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.black,
                child: Image.network(
                  widget._product.thumbnail,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<HomeBloc>().add(StoreFavoriteProductEvent(
                            product: HiveProduct(id: widget._product.id),
                          ));
                    },
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        final isFavorite = state.favoriteProducts.any(
                            (favProduct) =>
                                favProduct.id == widget._product.id);

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.black,
                            key: ValueKey(isFavorite),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomRow(
                  ratings: 0,
                  productAttributeTitle: 'Name',
                  productAttributeValue: widget._product.title),
              CustomRow(
                  productAttributeTitle: 'Price',
                  productAttributeValue: '\$ ${widget._product.price}'),
              CustomRow(
                  productAttributeTitle: 'Category',
                  productAttributeValue: widget._product.category),
              CustomRow(
                  productAttributeTitle: 'Brand',
                  productAttributeValue: widget._product.brand),
              CustomRow(
                  ratings: widget._product.rating,
                  productAttributeTitle: 'Rating',
                  productAttributeValue: widget._product.stock.toString()),
              CustomRow(
                productAttributeTitle: 'Description',
                productAttributeValue: widget._product.description,
              ),
              const SizedBox(height: 15),
              Text(
                'Product Gallery',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: widget._product.images.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: widget._product.images.isNotEmpty
                          ? Image.network(
                              widget._product.images[index],
                              fit: BoxFit.cover,
                            )
                          : Text('No image'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

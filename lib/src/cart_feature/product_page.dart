import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_app/src/theme/app_colors.dart';

import 'cart_bloc/cart_bloc.dart';
import 'cart_page.dart';
import 'models/cart_model.dart';
import 'models/product_model.dart';

/// based on: https://pub.dev/packages/carousel_slider/example
/// live Demo for differrent sliders: https://serenader2014.github.io/flutter_carousel_slider/#/
class ProductPage extends StatelessWidget {
  ProductPage({Key? key}) : super(key: key);
  static const List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  final List<Product> products = <Product>[
    Product('product 1', 'category1', 'https://source.unsplash.com/random?sig=1', 500.0),
    Product('product 2', 'category1', 'https://source.unsplash.com/random?sig=2', 200.0),
    Product('product 3', 'category1', 'https://source.unsplash.com/random?sig=3', 3500.0),
    Product('product 4', 'category1', 'https://source.unsplash.com/random?sig=4', 2500.0),
    Product('product 5', 'category1', 'https://source.unsplash.com/random?sig=5', 235.0),
    Product('product 5', 'category1', 'https://source.unsplash.com/random?sig=6', 235.0),
    Product('product 5', 'category1', 'https://source.unsplash.com/random?sig=7', 235.0),
    Product('product 5', 'category1', 'https://source.unsplash.com/random?sig=8', 235.0),
    Product('product 5', 'category1', 'https://source.unsplash.com/random?sig=9', 235.0),
  ];

  @override
  Widget build(BuildContext context) {
    var imageWidth = MediaQuery.of(context).size.width / 2.7;
    var imageHeight = MediaQuery.of(context).size.width / 2;
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //------- carousle
          _carousleDesign,

          //------- title
          _cartTitle(context),

          //------- grid
          InkWell(
            onTap: () {
              Navigator.restorablePushNamed(context, CartPage.routeName);
            },
            child: Container(
              height: imageHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) => _productCard(context, index, imageWidth, imageHeight),

                // staggeredTileBuilder: (int index) => new StaggeredTile.count(
                //   2,
                //   (index == 0 || index.isOdd && index != 1) ? 2.2 :1.8 ,
                // ),
                // mainAxisSpacing: 4.0,
                // crossAxisSpacing: 4.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get _carousleDesign => Container(
          child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          initialPage: 2,
          autoPlay: true,
        ),
        items: imageSliders,
      ));

  Widget _cartTitle(BuildContext context) => Text(
        '${AppLocalizations.of(context)!.latestItems}:',
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.start,
      );

  List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  Widget _productCard(BuildContext context, int index, double imageWidth, double imageHeight) {
    final borderRaduis = BorderRadius.circular(12.0);

    final product = products[index];
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: imageHeight,
              width: imageWidth,
              margin: EdgeInsets.all(9),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: borderRaduis,
              ),
              child: ClipRRect(
                borderRadius: borderRaduis,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: imageWidth,
              height: imageHeight / 4,
              margin: EdgeInsets.all(9),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.lightColor),
                        ),
                        Text(
                          '${product.price.toString()} \$',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(color: AppColors.lightColor),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: AppColors.lightColor),
                    onPressed: () {
                      context.read<CartBloc>().add(CartProductAdded(product));
                      var snack = SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          '${product.name} has been added to cart!',
                          style: TextStyle(color: AppColors.green),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

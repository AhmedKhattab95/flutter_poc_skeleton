import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/cart_feature/models/product_model.dart';
import 'package:my_app/src/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'mvvm/cart_mvvm.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart';

  const CartPage({Key? key}) : super(key: key);

  final summryPadding = const EdgeInsets.symmetric(horizontal: 16.0);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final theme = Theme.of(context);
    return ChangeNotifierProvider<CartMvvm>.value(
      value: CartMvvm.instance,
      builder: (cxt, child) => Scaffold(
          appBar: AppBar(
            title: Text(localization.cart),
          ),
          // bottomNavigationBar: CustomNavBar(),
          body: Consumer<CartMvvm>(
            builder: (context, vm, state) {
              if (vm.cartLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (vm.cartLoaded) {
                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(localization.addFree('50')),
                          ElevatedButton(onPressed: () {}, child: Text(localization.addMoreItems))
                        ],
                      ),

                      //============ products
                      Expanded(
                          child: ListView.builder(
                        itemCount: vm.cart.products.length,
                        itemBuilder: (context, index) => CartProductCard(product: vm.cart.products[index]),
                      )),

                      //==================== subtotal, Fees
                      SizedBox(height: 16),
                      _summaryDesing(context, vm.cart),
                      //=========== total
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        padding: summryPadding,
                        height: 50.0,
                        color: Theme.of(context).secondaryHeaderColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TOTAL',
                                style: theme.textTheme.subtitle2!
                                    .copyWith(color: Theme.of(context).scaffoldBackgroundColor)),
                            Text('\$${vm.cart.totalString}',
                                style: theme.textTheme.bodyText2!
                                    .copyWith(color: Theme.of(context).scaffoldBackgroundColor)),
                          ],
                        ),
                      )
                    ]));
              } else
                return Text('Error!!');
            },
          )),
    );
  }

  Widget _summaryDesing(BuildContext context, CartModel cart) {
    final theme = Theme.of(context);

    return Container(
      padding: summryPadding,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SUBTOTAL', style: theme.textTheme.subtitle2),
              Text(cart.subTtoalString, style: theme.textTheme.bodyText2),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DELIVERY FEE', style: theme.textTheme.subtitle2),
              Text(cart.deliveryFeeString, style: theme.textTheme.bodyText2),
            ],
          ),
        ],
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final Product product;

  const CartProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _productCard(context);
  }

  Widget _productCard(BuildContext context) {
    final borderRaduis = BorderRadius.circular(12.0);

    var imageWidth = MediaQuery.of(context).size.width / 2.7;
    var imageHeight = MediaQuery.of(context).size.width / 2.7;

    return Consumer<CartMvvm>(builder: (context, vm, child) {
      if (vm.cartLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (vm.cartLoaded) {
        return Card(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //========= product image
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

              //================= prodcut data

              Column(
                children: [
                  Text(
                    '${product.name}  \$${product.price.toString()}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  //========== add to cart button
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          //todo: remove product
                          Provider.of<CartMvvm>(context, listen: false).removeProduct(product);
                          var snack = SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                              '${product.name} has been removed from cart!',
                              style: TextStyle(color: AppColors.error),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        },
                      ),
                      Text(
                        '1',
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () {
                          // context.read<CartProvider>().add(CartProductAdded(product));

                          Provider.of<CartMvvm>(context, listen: false).addProduct(product);

                          var snack = SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                              '${product.name} has been added to cart!',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.green),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      } else
        return Text('Error!!');
    });
  }
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

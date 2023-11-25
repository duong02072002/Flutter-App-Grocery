import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_app_grocery/inner_screens/product_details.dart';
import 'package:flutter_app_grocery/models/viewed_model.dart';
import 'package:flutter_app_grocery/providers/cart_provider.dart';
import 'package:flutter_app_grocery/providers/products_provider.dart';
import 'package:flutter_app_grocery/services/utils.dart';
import 'package:flutter_app_grocery/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyWidgetState createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final viewedProdModel = Provider.of<ViewedProdModel>(context);

    final getCurrProduct =
        productProvider.findProdById(viewedProdModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: viewedProdModel.productId);
          // GlobalMethods.navigateTo(
          //     ctx: context, routeName: ProductDetails.routeName);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FancyShimmerImage(
              imageUrl: getCurrProduct.imageUrl,
              boxFit: BoxFit.fill,
              height: size.width * 0.27,
              width: size.width * 0.25,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                TextWidget(
                  text: getCurrProduct.title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextWidget(
                  text: '\$${usedPrice.toStringAsFixed(2)}',
                  color: color,
                  textSize: 20,
                  isTitle: false,
                ),
              ],
            ),
            //   const Spacer(),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 5),
            //     child: Material(
            //       borderRadius: BorderRadius.circular(12),
            //       color: Colors.green,
            //       child: InkWell(
            //         borderRadius: BorderRadius.circular(12),
            //         onTap: isInCart
            //             ? null
            //             : () async {
            //                 final User? user = authInstance.currentUser;
            //                 if (user == null) {
            //                   GlobalMethods.errorDialog(
            //                       subtitle: 'No user found, Please login first',
            //                       context: context);
            //                   return;
            //                 }
            //                 await GlobalMethods.addToCart(
            //                     productId: getCurrProduct.id,
            //                     quantity: 1,
            //                     context: context);
            //                 await cartProvider.fetchCart();

            //                 // cartProvider.addProductsToCart(
            //                 //   productId: getCurrProduct.id,
            //                 //   quantity: 1,
            //                 // );
            //               },
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Icon(
            //             isInCart ? Icons.check : IconlyBold.plus,
            //             color: Colors.white,
            //             size: 20,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}

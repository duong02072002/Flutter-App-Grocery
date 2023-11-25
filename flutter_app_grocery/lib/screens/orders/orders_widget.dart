import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_grocery/models/orders_model.dart';
import 'package:flutter_app_grocery/services/utils.dart';
import 'package:flutter_app_grocery/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrderModel>(context);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;

    // Sử dụng thông tin sản phẩm từ ordersModel thay vì từ ProductsProvider
    final productTitle = ordersModel.productTitle;
    final productImage = ordersModel.imageUrl;

    return ListTile(
      subtitle:
          Text('Paid: \$${double.parse(ordersModel.price).toStringAsFixed(2)}'),
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: productImage, // Sử dụng hình ảnh sản phẩm từ ordersModel
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
          text:
              '$productTitle x${ordersModel.quantity}', // Sử dụng tên sản phẩm từ ordersModel
          color: color,
          textSize: 18),
      trailing: TextWidget(text: orderDateToShow, color: color, textSize: 18),
    );
  }
}

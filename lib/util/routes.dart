import 'package:flutter/material.dart';
import 'package:distribuidora/views/product_detail_page.dart';
import 'package:distribuidora/util/constants.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    Constants.ROUTE_PRODUCT_DETAIL: (BuildContext context) =>
        ProductDetailPage()
  };
}
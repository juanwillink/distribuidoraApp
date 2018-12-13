import 'package:flutter/material.dart';
import 'package:distribuidora/views/product_list_page.dart';
import 'package:distribuidora/util/routes.dart';

void main() {
  runApp(
    MaterialApp(
      home: ProductsListPage(),
      routes: Routes.routes,
    )
  );
}
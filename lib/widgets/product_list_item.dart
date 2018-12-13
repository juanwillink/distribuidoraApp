import 'package:flutter/material.dart';
import 'package:distribuidora/util/constants.dart';
import 'package:distribuidora/model/Product.dart';
import 'package:distribuidora/views/product_detail_page.dart';

class ProductsListItem extends StatelessWidget {

  final Product product1;
  final Product product2;

  ProductsListItem({

    @required this.product1,
              this.product2

  });

  @override
  Widget build(BuildContext context) {

    if(product2 != null){
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildProductItemCard(context, product1),
          _buildProductItemCard(context, product2),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildProductItemCard(context, product1),
        ],
      );
    }

  }

  _buildImageForItem(BuildContext context, Product product){

    if(product.images.length != 0){
      return Container(
        child: Image.network(
          product.images.first.imageURL
        ),
        height: 250.0,
        width: MediaQuery
          .of(context)
          .size
          .width / 2.2
      );
    } else {
      return Container(
          height: 250.0,
          width: MediaQuery
              .of(context)
              .size
              .width / 2.2
      );
    }
  }

  _buildPriceRow(Product product) {

    if(product.salePrice != null){
      double salePercentage = ((product.price - product.salePrice) / product.price * 100);
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '\$' + product.salePrice.toStringAsFixed(2),
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            '\$' + product.price.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            salePercentage.toStringAsFixed(0) + "%",
            style: TextStyle(fontSize: 12.0, color: Colors.orange),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '\$' + product.price.toStringAsFixed(2),
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),

        ],
      );
    }
  }

  _buildProductItemCard(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailPage(product: product);
            }
          )
        );
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImageForItem(context, product),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  _buildPriceRow(product),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
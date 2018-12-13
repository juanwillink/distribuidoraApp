import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:distribuidora/util/constants.dart';
import 'package:distribuidora/model/Product.dart';
import 'package:distribuidora/model/Color.dart';
import 'package:distribuidora/model/ProductType.dart';
import 'package:distribuidora/model/AnyImage.dart';
import 'package:distribuidora/widgets/product_list_item.dart';

Future<List<Product>> _getProducts(http.Client client) async {
  final response = await client.get(
      Constants.REMOTE_BASE_URL + "products",
      headers: {
        "Authorization": "Bearer " + "lgCFT0WFC6EINGrmsJ6kiEQ7eHdBFMfkKSHWfh3m3YWKFMPqFXPPewIoirsl"
      }
  ).catchError(
          (error) {
        return false;
      }
  );

  return compute(_parseProducts, response.body);
}

List<Product> _parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

Future<List<ProductType>> _getProductTypes(http.Client client) async {
  final response = await client.get(
      Constants.REMOTE_BASE_URL + "product_types",
      headers: {
        "Authorization": "Bearer " + "lgCFT0WFC6EINGrmsJ6kiEQ7eHdBFMfkKSHWfh3m3YWKFMPqFXPPewIoirsl"
      }
  ).catchError(
          (error) {
        return false;
      }
  );

  return compute(_parseProductTypes, response.body);
}

List<ProductType> _parseProductTypes(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ProductType>((json) => ProductType.fromJson(json)).toList();
}

class ProductsListPage extends StatelessWidget {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          "PRODUCTOS",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: _buildProductsListPage(),
    );
  }

  _buildProductsListPage() {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[100],
      child: FutureBuilder<List<Product>>(
        future: _getProducts(http.Client()),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);

          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                if(index == 0){
                  return _buildFilterWidgets(screenSize);
                } else if(index == (snapshot.data.length - 1)) {
                  return ProductsListItem(
                    product1: snapshot.data[index],
                    product2: null,
                  );
                } else if(index % 2 == 0){
                  return Container();
                } else{
                  return ProductsListItem(
                      product1: snapshot.data[index-1],
                      product2: snapshot.data[index]
                  );
                }
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }

  _buildFilterWidgets(Size screenSize) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: screenSize.width,
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildFilterButton("ORDEN"),
              Container(
                color: Colors.black,
                width: 2.0,
                height: 24.0,
              ),
              _buildFilterButton("FILTRO"),
            ],
          ),
        ),
      ),
    );
  }

  _buildFilterButton(String title) {
    return InkWell(
      onTap: () {
        print(title);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          SizedBox(
            width: 2.0,
          ),
          Text(title),
        ],
      ),
    );
  }
}


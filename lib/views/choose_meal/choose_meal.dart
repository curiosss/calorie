import 'dart:io';

import 'package:calorie_calculator/models/product_model.dart';
import 'package:calorie_calculator/providers/todaymeals_prv.dart';
import 'package:calorie_calculator/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseMealPage extends StatefulWidget {
  const ChooseMealPage({Key key}) : super(key: key);

  @override
  State<ChooseMealPage> createState() => _ChooseMealPageState();
}

class _ChooseMealPageState extends State<ChooseMealPage> {
  double width = 320;
  TextEditingController textEditingController = TextEditingController();

  @override
  dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  addMeal() async {
    List<Product> products =
        await Provider.of<TodayMealsProvider>(context, listen: false)
            .initSelectableProducts();
    showDialog(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(10),
          child: Container(
              constraints: BoxConstraints(maxHeight: width),
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: products.map((product) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimens.HGMargin),
                      child: _buildProductItem(product),
                    );
                  }).toList(),
                ),
              )),
        );
      },
    );
  }

  onSelectMeal(Product product) {
    Navigator.pop(context);
    showDialog(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(10),
          child: Container(
            constraints: BoxConstraints(maxHeight: width),
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildProductItem(product),
                  SizedBox(height: Dimens.GMargin),
                  Card(
                    child: Row(
                      children: [
                        Text(
                          'mukdary',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: Dimens.GMargin),
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimens.GMargin),
                  ElevatedButton(
                    onPressed: saveProduct,
                    child: Text('Ýatda sakla'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  saveProduct() {
    if (validateEnterProduct()) {
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mukdaryny giriziň'),
        ),
      );
    }
  }

  validateEnterProduct() {
    if (textEditingController.text.length > 0)
      return true;
    else
      return false;
  }

  //ui widgets
  _buildProductItem(Product product) {
    return Card(
      child: ListTile(
        onTap: () {
          onSelectMeal(product);
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
          child: Image.file(
            File(product.image),
            fit: BoxFit.cover,
          ),
        ),
        minLeadingWidth: 80,
        title: Text(product.name),
        subtitle: Text(
          product.calorie.toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Consumer<TodayMealsProvider>(builder: (context, todayMealProv, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Nahar saýlamak'),
        ),
        body:
            Consumer<TodayMealsProvider>(builder: (context, todayMealProv, _) {
          return Container();
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: addMeal,
          child: Icon(Icons.add),
        ),
      );
    });
  }
}

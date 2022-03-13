import 'dart:io';

import 'package:calorie_calculator/models/product_model.dart';
import 'package:calorie_calculator/providers/todaymeals_prv.dart';
import 'package:calorie_calculator/utils/colors.dart';
import 'package:calorie_calculator/utils/dimens.dart';
import 'package:calorie_calculator/views/fitness_app/models/meals_list_data.dart';
import 'package:calorie_calculator/views/widgets/k_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseMealPage extends StatefulWidget {
  final MealsListData mealsListData;
  const ChooseMealPage({
    Key key,
    @required this.mealsListData,
  }) : super(key: key);

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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: 'Mukdary',
                        hintText: '100 g',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimens.GMargin),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPlateItem(val: '50'),
                      _buildPlateItem(val: '100'),
                      _buildPlateItem(val: '150'),
                      _buildPlateItem(val: '200'),
                    ],
                  ),
                  SizedBox(height: Dimens.GMargin),
                  SizedBox(
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () {
                        saveProduct(product);
                      },
                      child: Text('Ýatda sakla'),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimens.SBORDER_R)))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  saveProduct(Product product) {
    if (validateEnterProduct()) {
      product.quant =
          int.tryParse(textEditingController.text.toString() ?? '0');
      Provider.of<TodayMealsProvider>(context, listen: false).addMealListData(
          mealType: widget.mealsListData.typeId, product: product);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mukdaryny giriziň'),
        ),
      );
    }
  }

  removeProduct(int index) {
    confirm(context, () {
      Provider.of<TodayMealsProvider>(context, listen: false)
          .removeMealListData(
        mealType: widget.mealsListData.typeId,
        index: index,
      );
    });
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
        leading: Container(
          height: 75,
          width: 75,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.SBORDER_R),
            child: Image.file(
              File(product.image),
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(product.name),
        subtitle: Text(
          product.calorie.toString() + ' kkal / 100 g',
        ),
      ),
    );
  }

  _buildPlateItem({String val = '0'}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimens.SBORDER_R),
        onTap: () {
          textEditingController.text = val;
        },
        child: Container(
          height: 40,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(Dimens.SBORDER_R),
          ),
          child: Text(
            val + ' g',
            style: TextStyle(color: Colors.white),
          ),
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
          title: Text(widget.mealsListData.titleTxt ?? ''),
        ),
        body:
            Consumer<TodayMealsProvider>(builder: (context, todayMealProv, _) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.GMargin,
              vertical: Dimens.HGMargin,
            ),
            itemCount:
                todayMealProv.eatings[widget.mealsListData.typeId].length,
            itemBuilder: ((context, index) {
              Product product =
                  todayMealProv.eatings[widget.mealsListData.typeId][index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.HGMargin),
                child: Card(
                  child: ListTile(
                    leading: Container(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimens.SBORDER_R),
                        child: Image.file(
                          File(product.image),
                        ),
                      ),
                    ),
                    title: Text(product.name),
                    subtitle: Text(
                        (product.quant / 100 * product.calorie).toString() +
                            ' kkal / ${product.quant} g'),
                    trailing: IconButton(
                      onPressed: () {
                        removeProduct(index);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: addMeal,
          child: Icon(Icons.add),
        ),
      );
    });
  }
}

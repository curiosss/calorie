import 'dart:io';
import 'package:calorie_calculator/providers/categorie_prv.dart';
import 'package:calorie_calculator/utils/dimens.dart';
import 'package:calorie_calculator/views/bottom_sheets/confirm_sheet.dart';
import 'package:calorie_calculator/views/bottom_sheets/crud_btsheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_add_page.dart';
import '../products/products_page.dart';
import 'category_update_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    Provider.of<CategorieProvider>(context, listen: false).initCats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Önümler kategoriýalary'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: Dimens.GMargin, left: Dimens.GMargin),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryAddPage(),
                    ),
                  );
                },
                icon: Icon(Icons.add),
              ),
            )
          ],
        ),
        // floatingActionButton: FloatingActionButton(

        // ),
        body: Consumer<CategorieProvider>(
          builder: (context, catProv, _) {
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                left: Dimens.GMargin,
                top: Dimens.GMargin,
                right: Dimens.GMargin,
                bottom: 55 + Dimens.GMargin,
              ),
              itemCount: catProv.categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 7.0,
                mainAxisSpacing: 7.0,
              ),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Stack(
                      children: [
                        // kCachedNetworkImage(imageUrl: Dummy.bannerImages3[0]),
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Image.file(
                            File(catProv.categories[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          right: 0.0,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.black38,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  catProv.categories[index].catName ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.green.withOpacity(0.2),
                            highlightColor: Colors.green.withOpacity(0.3),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                            catId: catProv.categories[index].id,
                                          )));
                            },
                            onLongPress: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return CrudBottomSheet(
                                      updateTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryUpdatePage(
                                              category:
                                                  catProv.categories[index],
                                            ),
                                          ),
                                        );
                                      },
                                      deleteTap: () {
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(15.0),
                                              ),
                                            ),
                                            context: context,
                                            builder: (context) =>
                                                ConfirmBottomSheet(
                                                  text:
                                                      'Dogrydan hem pozmakçymy ?',
                                                )).then((value) {
                                          if (value != null && value) {
                                            Provider.of<CategorieProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteCategory(
                                                    category: catProv
                                                        .categories[index]);
                                            Navigator.of(context).pop();
                                          }
                                        });
                                      },
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

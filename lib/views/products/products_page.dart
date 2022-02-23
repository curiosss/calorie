import 'dart:io';
import 'package:calorie_calculator/providers/categorie_prv.dart';
import 'package:calorie_calculator/utils/dimens.dart';
import 'package:calorie_calculator/views/bottom_sheets/confirm_sheet.dart';
import 'package:calorie_calculator/views/bottom_sheets/crud_btsheet.dart';
import 'package:calorie_calculator/views/products/products_add_page.dart';
import 'package:calorie_calculator/views/products/products_update_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final int catId;
  const ProductPage({
    Key key,
    @required this.catId,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    Provider.of<CategorieProvider>(context, listen: false)
        .initProducts(catid: widget.catId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Önümler'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductsAddPage(
                          catId: widget.catId,
                        )));
          },
          child: Icon(Icons.add),
        ),
        body: Consumer<CategorieProvider>(
          builder: (context, services, _) {
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(Dimens.GMargin),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Dimens.GMargin,
                crossAxisSpacing: Dimens.GMargin,
                childAspectRatio: 0.75,
              ),
              itemCount: services.products.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
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
                                    builder: (context) => ProductsUpdatePage(
                                      product: services.products[index],
                                    ),
                                  ),
                                );
                              },
                              deleteTap: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15.0),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) => ConfirmBottomSheet(
                                          text: 'Dogrydan hem pozmakçymy ?',
                                        )).then((value) {
                                  if (value != null && value) {
                                    Provider.of<CategorieProvider>(context,
                                            listen: false)
                                        .deleteProduct(
                                            id: services.products[index].id);
                                    Navigator.of(context).pop();
                                  }
                                });
                              },
                            );
                          });
                    },
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Dimens.GBORDER_R),
                            // child: CachedNetworkImage(imageUrl: ),
                            child: Container(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .color
                                  .withOpacity(0.05),
                              // padding: const EdgeInsets.all(Dimens.GMargin),
                              // child: Image.asset(
                              //   'assets/signs/caution/${index + 1}.png',
                              //   fit: BoxFit.contain,
                              // ),
                              child: Image.file(
                                File(services.products[index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: Dimens.HGMargin,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  services.products[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: Dimens.FONT_H16,
                                  ),
                                ),
                                Text(
                                  '${services.products[index].calorie} kcal / 100 g',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Dimens.FONT_H14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )
        // body: ListView.builder(
        //   physics: BouncingScrollPhysics(),
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 10,
        //     vertical: 10,
        //   ),
        //   itemCount: Dummy.bannerImages3.length,
        //   itemBuilder: (context, index) {
        //     return Card(
        //       elevation: 3.0,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
        //       ),
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
        //         child: Material(
        //           color: Colors.transparent,
        //           child: Slidable(
        //             secondaryActions: [
        //                IconSlideAction(
        //                 caption: 'Üýtget',
        //                 color: Colors.blue,
        //                 icon: Icons.edit,
        //                 onTap: (){
        //                   print('delete item $index');
        //                 },
        //               ),
        //               IconSlideAction(
        //                 caption: 'Poz',
        //                 color: Colors.red,
        //                 icon: Icons.delete,
        //                 onTap: (){
        //                   print('delete item $index');
        //                 },
        //               ),
        //             ],
        //             actionPane: SlidableStrechActionPane(),
        //             child: ListTile(
        //               leading: AspectRatio(
        //                 aspectRatio: 1.0,
        //                 child: ClipRRect(
        //                   borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
        //                   child: kCachedNetworkImage(
        //                       imageUrl: Dummy.bannerImages3[index]),
        //                 ),
        //               ),
        //               title: Text('Product with long text'),
        //               subtitle: Text('100 Cal'),
        //               onLongPress: () {
        //                 print('long press');
        //               },
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
        );
  }
}

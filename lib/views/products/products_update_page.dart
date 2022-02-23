import 'dart:io';
import 'dart:typed_data';
import 'package:calorie_calculator/models/category_model.dart';
import 'package:calorie_calculator/models/product_model.dart';
import 'package:calorie_calculator/providers/categorie_prv.dart';
import 'package:calorie_calculator/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ProductsUpdatePage extends StatefulWidget {
  Product product;

  ProductsUpdatePage({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _ProductsUpdatePageState createState() => _ProductsUpdatePageState();
}

class _ProductsUpdatePageState extends State<ProductsUpdatePage> {
  bool _isLoading = false, isImageSelected = false;
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _calorieValController = TextEditingController();
  TextEditingController _proteinValController = TextEditingController();
  TextEditingController _fatValController = TextEditingController();
  TextEditingController _carboHydController = TextEditingController();
  File image;
  String imgExtension;
  String path;
  Uint8List imageBytes;

  @override
  void initState() {
    _productNameController.text = widget.product.name;
    image = File(widget.product.image);
    path = widget.product.image;
    _calorieValController.text = widget.product.calorie.toString();
    _proteinValController.text = widget.product.protein.toString();
    _fatValController.text = widget.product.fat.toString();
    _carboHydController.text = widget.product.carbohydrate.toString();
    super.initState();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _calorieValController.dispose();
    _proteinValController.dispose();
    _fatValController.dispose();
    _carboHydController.dispose();
    super.dispose();
  }

  void pickGallery() {
    pickImage(isGallery: true);
  }

  void pickCamera() {
    pickImage(isGallery: false);
  }

  void pickImage({bool isGallery = false}) async {
    try {
      final imageT = await ImagePicker().getImage(
          source: isGallery ? ImageSource.gallery : ImageSource.camera);
      if (imageT == null) return;
      setState(() {
        image = File(imageT.path);
      });
      imgExtension = imageT.path.split(".").last;
      isImageSelected = true;
      print(imageT.path);
    } catch (e) {
      print(e);
    }
  }

  void save() async {
    setState(() {
      _isLoading = true;
    });

    if (isImageSelected) {
      Directory docsDir = await getApplicationDocumentsDirectory();
      await Directory(docsDir.path + '/images').create(recursive: true);

      String imgPath = 'img_' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.' +
          imgExtension;

      String path = docsDir.path + '/images/' + imgPath;

      await File(widget.product.image).delete();
      await image.copy(path);
    }

    bool res = await Provider.of<CategorieProvider>(context, listen: false)
        .updateProduct(
      product: Product(
        id: widget.product.id,
        name: _productNameController.text.toString(),
        calorie: int.tryParse(_calorieValController.text.toString() ?? '0'),
        protein: int.tryParse(_proteinValController.text.toString() ?? '0'),
        fat: int.tryParse(_fatValController.text.toString() ?? '0'),
        carbohydrate: int.tryParse(_carboHydController.text.toString() ?? '0'),
        image: path,
      ),
    );

    setState(() {
      _isLoading = false;
    });
    if (res) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Önüm üýtgetmek'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dimens.GMargin),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
                child: Container(
                  height: 200,
                  width: 200,
                  child: image != null
                      ? Image.file(
                          image,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40.0,
                    child: ElevatedButton.icon(
                      onPressed: pickGallery,
                      icon: Icon(
                        Icons.image,
                      ),
                      label: Text('Gallery'),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Dimens.GMargin),
                Expanded(
                  child: SizedBox(
                    height: 40.0,
                    child: ElevatedButton.icon(
                      onPressed: pickCamera,
                      icon: Icon(
                        Icons.camera,
                      ),
                      label: Text('Camera'),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimens.GMargin),
            SizedBox(
              height: 50.0,
              child: TextField(
                controller: _productNameController,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: 'Önümiň ady',
                  hintText: 'Önümiň ady',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.red)),
                  prefixIcon: Icon(Icons.restaurant),
                ),
              ),
            ),
            SizedBox(height: Dimens.GMargin),
            SizedBox(
              height: 50.0,
              child: TextField(
                controller: _calorieValController,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: 'Kaloriýasy (kilokaloriýada)',
                  hintText: '100 Cal',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.red)),
                  prefixIcon: Icon(Icons.restaurant),
                ),
              ),
            ),
            SizedBox(height: Dimens.GMargin),
            SizedBox(
              height: 50.0,
              child: TextField(
                controller: _proteinValController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: 'Beloklar (gramda)',
                  hintText: '10 g',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.red)),
                  prefixIcon: Icon(Icons.restaurant),
                ),
              ),
            ),
            SizedBox(height: Dimens.GMargin),
            SizedBox(
              height: 50.0,
              child: TextField(
                controller: _fatValController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: 'Ýaglar (gramda)',
                  hintText: '10 g',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.red)),
                  prefixIcon: Icon(Icons.restaurant),
                ),
              ),
            ),
            SizedBox(height: Dimens.GMargin),
            SizedBox(
              height: 50.0,
              child: TextField(
                controller: _carboHydController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  labelText: 'Uglewodlar (gramda)',
                  hintText: '10 g',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.red)),
                  prefixIcon: Icon(Icons.restaurant),
                ),
              ),
            ),
            SizedBox(height: 2 * Dimens.GMargin),
            SizedBox(
              height: 40.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: save,
                child: _isLoading
                    ? Center(
                        child: SpinKitCircle(
                          size: 30.0,
                          color: Colors.white,
                        ),
                      )
                    : Text('Ýatda sakla'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 300),
          ],
        ),
      ),
    );
  }
}

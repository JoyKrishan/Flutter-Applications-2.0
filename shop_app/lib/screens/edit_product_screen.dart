import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/add-product";

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _desciptionFocusNode = FocusNode();
  final FocusNode _imgUrlFocusNode = FocusNode();
  final TextEditingController _imgUrlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _prodTitle, _prodImgURL, _prodDescription = "";
  double? _prodPrice = null;
  var init = false;
  Product? existingProduct = null;

  @override
  void initState() {
    _imgUrlFocusNode.addListener(updateImageURL);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!init) {
      String? prodId = ModalRoute.of(context)!.settings.arguments as String?;
      if (prodId != null) {
        existingProduct =
            Provider.of<Products>(context, listen: false).getById(prodId);
        _prodTitle = existingProduct!.title;
        _imgUrlController.text = existingProduct!.imageUrl;
        _prodDescription = existingProduct!.description;
        _prodPrice = existingProduct!.price;
      }
    }
    init = true;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imgUrlFocusNode.removeListener(updateImageURL);
    _priceFocusNode.dispose();
    _desciptionFocusNode.dispose();
    _imgUrlFocusNode.dispose();
    _imgUrlController.dispose();
    super.dispose();
  }

  void updateImageURL() {
    if (!_imgUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (existingProduct != null) {
        final updateProduct = Product(
            id: existingProduct!.id,
            description: _prodDescription,
            title: _prodTitle,
            price: _prodPrice!,
            imageUrl: _prodImgURL,
            isFavourite: existingProduct!.isFavourite);
        Provider.of<Products>(context, listen: false)
            .updateProduct(existingProduct!.id, updateProduct);
      } else {
        final newProduct = Product(
            id: DateTime.now().toString(),
            description: _prodDescription,
            title: _prodTitle,
            price: _prodPrice!,
            imageUrl: _prodImgURL);
        Provider.of<Products>(context, listen: false).addNewProduct(newProduct);
      }
    }
    _formKey.currentState!.reset();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        actions: [IconButton(onPressed: saveForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _prodTitle,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Title"),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
                onSaved: (value) {
                  _prodTitle = value;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                initialValue: _prodPrice == null ? "" : _prodPrice.toString(),
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter a price";
                  }
                  if (double.tryParse(val) == null)
                    return 'Please enter a valid number';
                  if (double.parse(val) <= 0)
                    return 'Please enter a number greater than zero';
                  return null;
                },
                onSaved: (value) {
                  _prodPrice = double.parse(value!);
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_desciptionFocusNode);
                },
              ),
              TextFormField(
                initialValue: _prodDescription,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _desciptionFocusNode,
                decoration: InputDecoration(labelText: "Description"),
                onSaved: (val) {
                  _prodDescription = val!;
                },
                validator: (val) {
                  if (val!.isEmpty) return 'Please enter a description';
                  if (val.length < 10)
                    return 'Please enter at least 10 characters';
                  return null;
                },
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                  margin: EdgeInsets.only(top: 10, right: 8),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: _imgUrlController.text.isEmpty
                      ? Text("No Url")
                      : Image.network(
                          _imgUrlController.text,
                          fit: BoxFit.cover,
                        ),
                ),
                Expanded(
                    child: TextFormField(
                  initialValue: _imgUrlController.text,
                  decoration: InputDecoration(labelText: "Image Url"),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  focusNode: _imgUrlFocusNode,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter a image URL";
                    }
                    if (!val.startsWith('http') && !val.startsWith('https'))
                      return "Please enter a valid URL";
                    if (!val.endsWith('jpg') &&
                        !val.endsWith('jpeg') &&
                        !val.endsWith('png')) {
                      print(!val.endsWith('jpeg'));
                      print(!val.endsWith('png'));
                      return 'Please enter a valid Image URL';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _prodImgURL = val!;
                  },
                  onFieldSubmitted: (_) {
                    saveForm();
                  },
                )),
              ])
            ],
          ),
        ),
      ),
    );
  }
}

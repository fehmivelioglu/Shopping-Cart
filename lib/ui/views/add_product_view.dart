import 'package:flutter/material.dart';
import 'package:todo_app/core/api_service.dart';
import 'package:todo_app/core/models/product_model.dart';

class AddProductView extends StatefulWidget {
  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerImage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidate: true,
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: controllerName,
                  validator: validator,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Product Name",
                    hasFloatingPlaceholder: true,
                  ),
                ),
                TextFormField(
                  controller: controllerPrice,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "This area can not be empty";
                    } else if (int.tryParse(val) == null) {
                      return "Write number";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Price",
                      hasFloatingPlaceholder: true),
                ),
                TextFormField(
                  controller: controllerImage,
                  validator: validator,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Image URL",
                      hasFloatingPlaceholder: true),
                ),
                RaisedButton.icon(
                  icon: Icon(Icons.send),
                  label: Text("Add product"),
                  onPressed: () async {
                    var model = Product(
                      productName: controllerName.text,
                      price: int.parse(controllerPrice.text),
                      imageUrl: controllerImage.text,
                    );
                    await ApiService.getInstance().addProducts(model);
                    Navigator.pop(context);
                  },
                  shape: StadiumBorder(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validator(val) {
    if (val.isEmpty) {
      return "This area can not be empty";
    }
    return null;
  }
}

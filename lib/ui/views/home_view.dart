import 'package:flutter/material.dart';
import 'package:todo_app/core/api_service.dart';
import 'package:todo_app/core/models/product_model.dart';
import 'package:todo_app/ui/shared/widgets/custom_card.dart';
import 'package:todo_app/ui/views/add_product_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ApiService service = ApiService.getInstance();
  List<Product> productList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart Application by FAV"),
      ),
      floatingActionButton: buildFloatingActionButton(),
      body: FutureBuilder<List<Product>>(
          future: service.getProducts(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  productList = snapshot.data;
                  return buildListView();
                }
                return Center(
                  child: Text("error"),
                );
                break;
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
    );
  }

  ListView buildListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return dismiss(
            CustomCard(
              title: productList[index].productName,
              subtitle: productList[index].price.toString(),
              imageUrl: productList[index].imageUrl,
            ),productList[index].key
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: productList.length);
  }

  Widget dismiss(Widget child,String key) {
    return Dismissible(
      child: child,
      key: UniqueKey(),
      background: Container(color: Colors.redAccent,child: Center(child: Text("Delete product"),),),
      onDismissed: (dismissDirection) async {
        await service.removeProduct(key);

      },
      
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(child: Icon(Icons.add), onPressed: fabPressed);
  }

  void fabPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) => bottomSheet,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))));
  }

  Widget get bottomSheet => Container(
      height: 200,
      child: Column(
        children: <Widget>[
          Divider(
            thickness: 2,
            endIndent: 100,
            indent: 100,
            color: Colors.grey,
          ),
          RaisedButton(
            child: Text("Add product to card"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddProductView()));
            },
          ),
        ],
      ));
}

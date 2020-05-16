import 'package:flutter/material.dart';
import 'package:todo_app/ui/shared/styles/text_styles.dart';

class CustomCard extends StatelessWidget {
  final String title ;
  final String subtitle ;
  final String imageUrl ;

  const CustomCard({Key key, this.title, this.subtitle,this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title,style: titleStyle,),
        subtitle: Text(subtitle),
        trailing: imagePlace,
      ),
    );
  }
  Widget get imagePlace{
    return imageUrl.isEmpty ? Container(child:Placeholder(),height: 20,width: 20,):Image.network(imageUrl,);
  }
}
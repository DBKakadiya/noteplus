import 'package:flutter/material.dart';
import 'package:noteplus_demo/resources/resources.dart';
import 'package:noteplus_demo/widgets/drawer.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/Search';
  final Color color;
  final String image;
  const SearchScreen(this.color,this.image, {Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: widget.color,
        title: const Text('Search bar'), 
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.clear,size: 30))
        ],
      ),
      body: SizedBox(
          height: deviceHeight(context),
          width: deviceWidth(context),
          child: Image.asset(widget.image,fit: BoxFit.fill,)),
    );
  }
}

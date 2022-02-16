import 'package:flutter/material.dart';
import 'package:noteplus_demo/model/drawer_data.dart';
import 'package:noteplus_demo/resources/dimensions.dart';
import 'package:noteplus_demo/resources/styles.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  Widget buildList(int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(drawerData[index].route);
          },
          child: Row(
            children: [
              SizedBox(
                width: deviceWidth(context) * 0.03,
              ),
              Image.asset(
                drawerData[index].icon,
                width: deviceWidth(context) * 0.06,
              ),
              SizedBox(
                width: deviceWidth(context) * 0.032,
              ),
              Text(drawerData[index].title,style: textStyle14(),)
            ],
          ),
        ),
        SizedBox(height: deviceHeight(context) * 0.03)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Note Plus Pro',
              style: textStyle24(),
            ),
          ),
          Divider(
            height: deviceHeight(context) * 0.04,
            color: Colors.black45,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: drawerData.length,
                  itemBuilder: (context, index) => buildList(index)))
        ],
      ),
    );
  }
}

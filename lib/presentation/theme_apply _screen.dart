import 'package:flutter/material.dart';
import 'package:noteplus_demo/model/preference.dart';
import 'package:noteplus_demo/resources/resources.dart';

class ApplyTheme extends StatefulWidget {
  static const routeName = '/Apply-Theme';

  const ApplyTheme({Key? key}) : super(key: key);

  @override
  _ApplyThemeState createState() => _ApplyThemeState();
}

class _ApplyThemeState extends State<ApplyTheme> {


  void _themeColor(BuildContext context) async {
    final color = ModalRoute.of(context)!.settings.arguments as Color;
    setState(() {
      SharedPreference().storeValue('color', color.toString());
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = ModalRoute.of(context)!.settings.arguments as Color;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        leading: const Icon(Icons.menu),
        title: const Text('Note Plus'),
        actions: [
          const Icon(
            Icons.search,
            size: 25,
          ),
          SizedBox(width: deviceWidth(context) * 0.05),
          const Icon(
            Icons.sync,
            size: 25,
          ),
          SizedBox(width: deviceWidth(context) * 0.05),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.5),
                itemCount: widgets.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: deviceHeight(context) * 0.36,
                        width: deviceWidth(context) * 0.45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.black54,
                                width: deviceWidth(context) * 0.005)),
                        child: widgets[index],
                      ),
                    )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                    height: deviceHeight(context) * 0.09,
                    width: deviceWidth(context) * 0.09,
                    decoration: BoxDecoration(
                        color: color.withOpacity(0.3), shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: const Icon(Icons.close)),
              ),
              TextButton(
                onPressed: ()=>_themeColor(context),
                child: Text('Apply', style: textStyle18Bold(Colors.white)),
                style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(30))),
                    backgroundColor: color,
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth(context) * 0.28,
                        vertical: deviceHeight(context) * 0.02)),
              )
            ],
          ),
          SizedBox(height: deviceHeight(context) * 0.015)
        ],
      ),
    );
  }

  List<Widget> widgets = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Something 1',
                style: textStyle14Bold(),
              ),
              const Icon(
                Icons.alarm,
                size: 20,
              )
            ],
          ),
          Text('Content', style: textStyle14()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [Text('18/01/2022')],
          )
        ],
      ),
    ),
    Column(
      children: [
        Container(
          height: 10,
          color: Colors.orangeAccent.withOpacity(0.6),
        ),
        Container(
          color: Colors.orangeAccent.shade100.withOpacity(0.3),
          padding: const EdgeInsets.all(10),
          height: 100.98,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Something 1',
                    style: textStyle14Bold(),
                  ),
                  const Icon(
                    Icons.alarm,
                    size: 20,
                    color: Colors.orangeAccent,
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.orangeAccent,
                        size: 20,
                      ),
                      Text('Sun title 1', style: textStyle14()),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.orangeAccent,
                        size: 20,
                      ),
                      Text('Sun title 2', style: textStyle14()),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text('18/01/2022')],
              )
            ],
          ),
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10,
          color: Colors.purpleAccent.withOpacity(0.6),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          height: 100.98,
          color: Colors.purpleAccent.shade100.withOpacity(0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Something 1',
                    style: textStyle14Bold(),
                  ),
                  Icon(
                    Icons.alarm,
                    size: 20,
                    color: Colors.purpleAccent.withOpacity(0.7),
                  )
                ],
              ),
              Row(
                children: [
                  Text('Content', style: textStyle14()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text('18/01/2022')],
              )
            ],
          ),
        ),
      ],
    )
  ];
}

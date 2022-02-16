import 'package:flutter/material.dart';
import 'package:noteplus_demo/resources/resources.dart';

class SyncAccountScreen extends StatefulWidget {
  static const routeName = '/Sync-Account';
  final Color color;
  final String image;
  const SyncAccountScreen(this.color,this.image, {Key? key}) : super(key: key);

  @override
  _SyncAccountScreenState createState() => _SyncAccountScreenState();
}

class _SyncAccountScreenState extends State<SyncAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          SizedBox(
              height: deviceHeight(context),
              width: deviceWidth(context),
              child: Image.asset(widget.image,fit: BoxFit.fill,)),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: deviceHeight(context) * 0.05,
                    left: deviceWidth(context) * 0.05,
                    bottom: deviceHeight(context) * 0.025),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.black12.withOpacity(0.05),
                              width: deviceWidth(context) * 0.005)),
                      child: Container(
                        height: deviceHeight(context) * 0.12,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white,
                                width: deviceWidth(context) * 0.02)),
                        child: Image.asset(
                          imgUserProfile,
                          color: Colors.grey.shade500,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: deviceWidth(context) * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your name', style: textStyle20Bold()),
                        SizedBox(height: deviceHeight(context) * 0.01),
                        Text(
                          'your_email@gmail.com',
                          style: textStyle16(),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: deviceHeight(context) * 0.002,
              ),
              SizedBox(height: deviceHeight(context) * 0.03),
              TextButton(
                onPressed: () {},
                child: Text('Login', style: textStyle16(Colors.white),),
                style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30), right: Radius.circular(30))),
                    backgroundColor: widget.color,
                    padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.35, vertical: deviceHeight(context) * 0.02)),
              )
            ],
          ),
        ],
      )
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: widget.color,
      title: const Text('Sync'),
      actions: [
        Image.asset(icQueMark,
            color: Colors.white, width: deviceWidth(context) * 0.09),
        SizedBox(width: deviceWidth(context) * 0.03)
      ],
    );
  }
}

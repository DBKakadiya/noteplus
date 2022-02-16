import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:noteplus_demo/model/handler.dart';
import 'package:noteplus_demo/model/list_Data.dart';
import 'package:noteplus_demo/model/preference.dart';
import 'package:noteplus_demo/model/textNotes.dart';
import 'package:noteplus_demo/presentation/sync_screen.dart';
import 'package:noteplus_demo/widgets/drawer.dart';
import 'package:sqflite/sqflite.dart';
import '../resources/resources.dart';
import 'notePad_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _folded = false;
  bool _isGrid = true;
  int? index;
  Color? _color;
  String? _image;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<TextNotes>? textNotes;
  int count = 0;
  int itemCount = 0;
  List<ListItem>? listNotes;

  shwDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(8),
            content: SizedBox(
              height: deviceHeight(context) * 0.0935,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(NotePadScreen.routeName, arguments: {
                          'simpleNoteText': 1,
                        });
                      },
                      child: const Text('Add Note')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                        height: deviceHeight(context) * 0.01,
                        color: Colors.grey.shade600),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(NotePadScreen.routeName, arguments: {
                          'listNoteText': 2,
                        });
                      },
                      child: const Text('Add ListNote'))
                ],
              ),
            ),
          );
        });
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      animatedIconTheme: const IconThemeData(size: 28.0),
      backgroundColor: _color,
      visible: true,
      curve: Curves.bounceInOut,
      spaceBetweenChildren: 5,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.short_text_outlined
              , color: Colors.white),
          backgroundColor: _color,
          onTap: () {
            Navigator.of(context)
                .pushNamed(NotePadScreen.routeName, arguments: {
              'simpleNoteText': 1,
            });
          },
          label: 'Add Note',
          labelStyle: textStyle16(),
          labelBackgroundColor: Colors.black38,
        ),
        SpeedDialChild(
          child: const Icon(Icons.list_alt, color: Colors.white),
          backgroundColor: _color,
          onTap: () {
            Navigator.of(context)
                .pushNamed(NotePadScreen.routeName, arguments: {
              'listNoteText': 2,
            });
          },
          label: 'Add Checklist',
          labelStyle: textStyle16(),
          labelBackgroundColor: Colors.black38,
        ),
      ],
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: _color,
      title: _folded
          ? null
          : Text(
              'Note Plus',
              style: textStyle18(),
            ),
      actions: [
        AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: _folded
                ? deviceWidth(context) * 0.86
                : deviceWidth(context) * 0.367,
            child: Row(
              children: [
                Expanded(
                    child: _folded
                        ? Container(
                            height: deviceHeight(context) * 0.06,
                            padding: EdgeInsets.only(
                              left: deviceWidth(context) * 0.016,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: '  Search...',
                                hintStyle: textStyle18(Colors.black38),
                                border: InputBorder.none,
                              ),
                              cursorColor: Colors.black38,
                            ),
                          )
                        : Container()),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _folded = !_folded;
                            });
                          },
                          icon: _folded
                              ? const Icon(
                                  Icons.clear,
                                  size: 30,
                                )
                              : const Icon(Icons.search)),
                    ],
                  ),
                ),
                if (!_folded)
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _isGrid = !_isGrid;
                        });
                      },
                      icon: _isGrid
                          ? const Icon(Icons.grid_on)
                          : const Icon(Icons.view_list)),
                if (!_folded)
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(SyncAccountScreen.routeName);
                      },
                      icon: const Icon(Icons.sync))
              ],
            )),
      ],
    );
  }

  Widget body() {
    return textNotes!.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Empty notes!',
                  style: textStyle16(),
                ),
                SizedBox(height: deviceHeight(context) * 0.015),
                TextButton(
                  onPressed: shwDialog,
                  child: Text(
                    'Add now!',
                    style: textStyle16(Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(30),
                              right: Radius.circular(30))),
                      backgroundColor: _color,
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth(context) * 0.1,
                          vertical: deviceHeight(context) * 0.02)),
                )
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth(context) * 0.01,
                vertical: deviceHeight(context) * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: deviceHeight(context) * 0.023,
                      horizontal: deviceWidth(context) * 0.03),
                  child: Text('Other', style: textStyle16Bold()),
                ),
                Expanded(
                  child: _isGrid
                      ? GridView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth(context) * 0.02),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1.53),
                          itemCount: count,
                          itemBuilder: (ctx, index) {
                            // print(
                            //     '----typeData--$index----${textNotes![index].noteText}');
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    NotePadScreen.routeName,
                                    arguments: {
                                      'index': index,
                                      'savedTextNote': textNotes![index]
                                    });
                              },
                              child: Container(
                                height: deviceHeight(context) * 0.4,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: _color,
                                      height: deviceHeight(context) * 0.015,
                                    ),
                                    Dismissible(
                                      key: ObjectKey(textNotes![index]),
                                      direction: DismissDirection.endToStart,
                                      onDismissed:
                                          (DismissDirection direction) {
                                        if (direction ==
                                            DismissDirection.endToStart) {
                                          if (kDebugMode) {
                                            print("Remove item");
                                          }
                                        }
                                        setState(() {
                                          _delete(context, textNotes![index]);
                                        });
                                      },
                                      background: Container(
                                        color: _color!.withOpacity(0.2),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right:
                                                  deviceWidth(context) * 0.016),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Text('Delete',
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 16)),
                                              SizedBox(
                                                  width: deviceWidth(context) *
                                                      0.01),
                                              const Icon(
                                                Icons.delete,
                                                color: Colors.black87,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      confirmDismiss:
                                          (DismissDirection direction) async {
                                        return await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Delete Confirmation"),
                                              content: const Text(
                                                  "Are you sure you want to delete this note?"),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                      _delete(context,
                                                          textNotes![index]);
                                                    },
                                                    child:
                                                        const Text("Delete")),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: const Text("Cancel"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: deviceHeight(context) * 0.135,
                                        color: _color!.withOpacity(0.55),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  deviceWidth(context) * 0.03,
                                              vertical:
                                                  deviceHeight(context) * 0.01),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(textNotes![index].titleText!,
                                                  style: textStyle16Bold()),
                                              // textNotes![index].isList == false
                                              //     ?
                                              Text(textNotes![index]
                                                          .noteText!,
                                                      style: textStyle14()),
                                                  // : Text(
                                                  //     listNotes![1]
                                                  //         .textFieldText!,
                                                  //     style: textStyle16Bold()),
                                              Row(
                                                children: [
                                                  const Spacer(),
                                                  Text(textNotes![index].date ==
                                                          ''
                                                      ? DateFormat()
                                                          .add_yMd()
                                                          .format(
                                                              DateTime.now())
                                                      : textNotes![index].date!)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth(context) * 0.02),
                          itemCount: count,
                          itemBuilder: (context, index) => Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          NotePadScreen.routeName,
                                          arguments: {
                                            'index': index,
                                            'isSave': true,
                                            'savedTextNote': textNotes![index]
                                          });
                                    },
                                    child: Container(
                                      height: deviceHeight(context) * 0.11,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topLeft: Radius.circular(20))),
                                      child: Row(
                                        children: [
                                          Container(
                                            color: _color,
                                            width: deviceWidth(context) * 0.015,
                                          ),
                                          Dismissible(
                                            direction:
                                                DismissDirection.endToStart,
                                            key: ObjectKey(textNotes![index]),
                                            onDismissed:
                                                (DismissDirection direction) {
                                              if (direction ==
                                                  DismissDirection.endToStart) {
                                                if (kDebugMode) {
                                                  print("Remove item");
                                                }
                                              }
                                            },
                                            background: Container(
                                              color: _color!.withOpacity(0.2),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        deviceWidth(context) *
                                                            0.016),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Text('Delete',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 16)),
                                                    SizedBox(
                                                        width: deviceWidth(
                                                                context) *
                                                            0.01),
                                                    const Icon(
                                                      Icons.delete,
                                                      color: Colors.black87,
                                                      size: 30,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            confirmDismiss: (DismissDirection
                                                direction) async {
                                              return await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Delete Confirmation"),
                                                    content: const Text(
                                                        "Are you sure you want to delete this note?"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                            _delete(
                                                                context,
                                                                textNotes![
                                                                    index]);
                                                          },
                                                          child: const Text(
                                                              "Delete")),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false),
                                                        child: const Text(
                                                            "Cancel"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              color: _color!.withOpacity(0.55),
                                              width:
                                                  deviceWidth(context) * 0.92,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        deviceWidth(context) *
                                                            0.03,
                                                    vertical:
                                                        deviceHeight(context) *
                                                            0.02),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(imgNote,
                                                            width: deviceWidth(
                                                                    context) *
                                                                0.07),
                                                        SizedBox(
                                                            width: deviceWidth(
                                                                    context) *
                                                                0.02),
                                                        Text(
                                                            textNotes![index]
                                                                .titleText!,
                                                            style:
                                                                textStyle16Bold()),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(textNotes![index]
                                                                    .date ==
                                                                ''
                                                            ? DateFormat()
                                                                .add_yMd()
                                                                .format(DateTime
                                                                    .now())
                                                            : textNotes![index]
                                                                .date!)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: deviceHeight(context) * 0.013)
                                ],
                              )),
                )
              ],
            ),
          );
  }

  void _delete(BuildContext context, TextNotes note) async {
    int result = await databaseHelper.deleteTodo(note.id!);
    if (result != 0) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TextNotes>?> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((noteList) {
        setState(() {
          textNotes = noteList!;
          count = textNotes!.length;
        });
      });
    });
  }

  void updateNoteListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ListItem>?> listNoteFuture = databaseHelper.getListItem();
      listNoteFuture.then((listItem) {
        print('----items----$listItem');
        setState(() {
          listNotes = listItem!;
          itemCount = listNotes!.length;
        });
      });
    });
  }

  _getColor() async {
    setState(() {});
    var color = await SharedPreference().getColor('color');
    String valueString = color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    setState(() {});
    _color = Color(value);
  }

  _getImage() async {
    setState(() {});
    var image = await SharedPreference().getImage('image');
    setState(() {});
    _image = image;
  }

  @override
  Widget build(BuildContext context) {
    if (textNotes == null) {
      textNotes = <TextNotes>[];
      updateListView();
    }

    if (listNotes == null) {
      listNotes = <ListItem>[];
      updateNoteListView();
    }

    _getColor();
    _getImage();

    print('====mainNotes-----$textNotes');
    print('----list----$listNotes');
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            Container(
                height: deviceHeight(context),
                width: deviceWidth(context),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(_image == null ? imgBlank : _image!),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstIn),
                ))),
            body(),
          ],
        ),
        floatingActionButton: buildSpeedDial(),
      ),
    );
  }
}

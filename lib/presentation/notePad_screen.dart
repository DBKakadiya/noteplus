import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:noteplus_demo/model/drawer_data.dart';
import 'package:noteplus_demo/model/handler.dart';
import 'package:noteplus_demo/model/list_Data.dart';
import 'package:noteplus_demo/model/textNotes.dart';
import 'package:noteplus_demo/resources/resources.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';
import 'home_screen.dart';

class NotePadScreen extends StatefulWidget {
  static const routeName = 'NotePad_screen';
  final Color color;
  final String image;

  const NotePadScreen(this.color, this.image, {Key? key}) : super(key: key);

  @override
  _NotePadScreenState createState() => _NotePadScreenState();
}

List<int> numbers = List.generate(99999, (index) => index);
int i = Random().nextInt(numbers.length);

class _NotePadScreenState extends State<NotePadScreen> {
  final _simpleTextController = TextEditingController();
  final _listTextController = TextEditingController();
  final _noteController = TextEditingController();
  Future<List<TextNotes>?>? _textNotes;
  bool _isSave = false;

  bool _isSelectDate = false;
  bool _isSelectTime = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  bool isSave = true;
  bool isUpdate = false;
  int? textNoteIdForUpdate;

  int listIndex = 0;

  DatabaseHelper helper = DatabaseHelper();
  TextNotes textNoteModel = TextNotes.withId(numbers[i], '', '', '', '');
  ListItem listItemModel = ListItem(numbers[i],0, '');

  PreferredSizeWidget appBar(int option) {
    return AppBar(
      backgroundColor: widget.color,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        Row(
          children: [
            Container(
              height: deviceHeight(context) * 0.062,
              width: deviceWidth(context) * 0.63,
              padding: EdgeInsets.only(
                left: deviceWidth(context) * 0.03,
              ),
              decoration: _isSave
                  ? null
                  : BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _isSave
                      ? (option == 1
                          ? Text(
                              _simpleTextController.text.isEmpty
                                  ? 'Title...'
                                  : textNoteModel.titleText!,
                              style: textStyle16(Colors.black54),
                            )
                          : Text(
                              _listTextController.text.isEmpty
                                  ? 'Title...'
                                  : textNoteModel.titleText!,
                              style: textStyle16(Colors.black54),
                            ))
                      : Expanded(
                          child: TextField(
                            controller: option == 1
                                ? _simpleTextController
                                : _listTextController,
                            onChanged: (value) {
                              if (option == 1) {
                                textNoteModel.titleText =
                                    _simpleTextController.text;
                              } else {
                                textNoteModel.noteText =
                                    _listTextController.text;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: '  Title...',
                              hintStyle: textStyle18(Colors.black38),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    if (option == 1) {
                                      _simpleTextController.clear();
                                    } else {
                                      _listTextController.clear();
                                    }
                                  },
                                  icon: const Icon(Icons.clear)),
                            ),
                            cursorColor: Colors.black38,
                          ),
                        ),
                ],
              ),
            ),
            _isSave
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        // isUpdate = !isUpdate;
                        _isSave = !_isSave;
                        print('----update11---$isUpdate');
                      });
                    },
                    icon: const Icon(Icons.edit))
                : IconButton(
                    onPressed: () {
                      option == 1
                          ? {
                              setState(() {
                                textNoteModel.titleText =
                                    _simpleTextController.text;
                                textNoteModel.noteText = _noteController.text;
                                _isSelectTime
                                    ? textNoteModel.time =
                                        '${_selectedTime!.hour}:${_selectedTime!.minute}'
                                    : textNoteModel.time = '';
                                _isSelectDate
                                    ? textNoteModel.date = DateFormat()
                                        .add_yMd()
                                        .format(_selectedDate!)
                                    : textNoteModel.date = '';
                                textNoteIdForUpdate = textNoteModel.id;
                                (textNoteModel.titleText!.isNotEmpty &&
                                        textNoteModel.noteText != '')
                                    ? {
                                        isUpdate
                                            ? {
                                                helper.updateTodo(
                                                    TextNotes.withId(
                                                        textNoteIdForUpdate,
                                                        textNoteModel.titleText,
                                                        textNoteModel.noteText,
                                                        textNoteModel.date,
                                                        textNoteModel.time)),
                                                // numbers.removeAt(i)
                                              }
                                            : helper.insertTodo(textNoteModel),
                                        _isSave = !_isSave,
                                        isUpdate = !isUpdate
                                      }
                                    : null;
                                numbers.removeAt(i);
                              }),
                            }
                          : {
                              setState(() {
                                textNoteModel.titleText =
                                    _listTextController.text;
                                textNoteModel.noteText = '';
                                _isSelectTime
                                    ? textNoteModel.time =
                                        '${_selectedTime!.hour}:${_selectedTime!.minute}'
                                    : textNoteModel.time = '';
                                _isSelectDate
                                    ? textNoteModel.date = DateFormat()
                                        .add_yMd()
                                        .format(_selectedDate!)
                                    : textNoteModel.date = '';
                                textNoteIdForUpdate = textNoteModel.id;
                                (textNoteModel.titleText!.isNotEmpty)
                                    ? {
                                        isUpdate
                                            ? {
                                                helper.updateTodo(
                                                    TextNotes.withId(
                                                        textNoteIdForUpdate,
                                                        textNoteModel.titleText,
                                                        textNoteModel.noteText,
                                                        textNoteModel.date,
                                                        textNoteModel.time)),
                                              }
                                            : {
                                                helper
                                                    .insertTodo(textNoteModel),
                                                for (int listIndex=0; listIndex < noteList.length; listIndex++)
                                                  {
                                                    listItemModel.id = textNoteIdForUpdate,
                                                    listItemModel.listNoteId = listIndex,
                                                    listItemModel.textFieldText =
                                                        noteList[listIndex]
                                                            .textFieldText.text,
                                                    listItemModel.checkVal =
                                                        noteList[listIndex].val,
                                                    helper.insertList(listItemModel),
                                                    print('----listItemModel----$listItemModel--')
                                                  },
                                          print('-======--textNotemodel--===$textNoteModel')
                                              },
                                        _isSave = !_isSave,
                                        isUpdate = !isUpdate
                                      }
                                    // helper.insertList(listItemModel),
                                    : null;
                                numbers.removeAt(i);
                              }),
                            };
                      _isSave ? onSaveReminder() : null;
                    },
                    icon: const Icon(Icons.save, size: 30)),
            IconButton(
                onPressed: shawDialog,
                icon: const Icon(Icons.more_vert, size: 30))
          ],
        ),
      ],
    );
  }

  void shawDialog([int? index, dynamic savedTextNote]) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              height: deviceHeight(context) * 0.565,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    moreVertData.length,
                    (i) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (i == 0)
                              SizedBox(height: deviceHeight(context) * 0.008),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: deviceWidth(context) * 0.04,
                                  top: deviceHeight(context) * 0.01,
                                  bottom: deviceHeight(context) * 0.01),
                              child: GestureDetector(
                                  onTap: i == 1
                                      ? () {
                                          _displayTitle;
                                          Navigator.of(context)
                                              .pushNamed(moreVertData[i].route);
                                        }
                                      : i == 2
                                          ? index == null
                                              ? reminderDialog
                                              : () => reminderDialog(
                                                  index, savedTextNote)
                                          : () {
                                              Navigator.of(context).pushNamed(
                                                  moreVertData[i].route);
                                            },
                                  child: Text(moreVertData[i].title)),
                            ),
                            if (!(i == 7))
                              Divider(
                                thickness: deviceHeight(context) * 0.001,
                                color: Colors.black12,
                              )
                          ],
                        )),
              ),
            ),
          );
        });
  }

  void _presentTimePicker() {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(
                hour: DateTime.now().hour, minute: DateTime.now().minute))
        .then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = pickedTime;
        _isSelectTime = true;
      });
    });
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2030))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _isSelectDate = true;
        _selectedDate = pickedDate;
      });
    });
  }

  void loadAlarms() {
    _textNotes = DatabaseHelper().getTodoList();
    if (mounted) setState(() {});
  }

  void scheduleTextNotes(
      DateTime scheduledNotificationDateTime, TextNotes textNotes) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'textNotes_notify',
      'Channel for textNotes notification',
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        textNotes.titleText,
        textNotes.noteText,
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  void onSaveReminder([int? index, dynamic savedTextNote]) {
    DateTime? scheduleTextNotesDateTime;
    scheduleTextNotesDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute);
    // print('=-=-=-=-=-=$_isSave');
    var textNoteInfo = TextNotes(
        index == null ? textNoteModel.titleText : savedTextNote.titleText,
        index == null ? textNoteModel.noteText : savedTextNote.noteText,
        DateFormat().add_yMd().format(_selectedDate!),
        '${_selectedTime!.hour}:${_selectedTime!.minute}');
    scheduleTextNotes(scheduleTextNotesDateTime, textNoteInfo);
    print('------3----$isSave');
    _isSave ? Navigator.of(context).pop() : null;
    isSave ? null : Navigator.of(context).pop();
    loadAlarms();
  }

  void _setState() {
    setState(() {
      if (_isSelectDate) {
        textNoteModel.date = DateFormat().add_yMd().format(_selectedDate!);
      } else {
        textNoteModel.date = DateFormat().add_yMd().format(DateTime.now());
      }
      if (_isSelectTime) {
        textNoteModel.time =
            '${_selectedTime!.hour}:${_selectedTime!.minute} ${_selectedTime!.period.name}';
      } else {
        textNoteModel.time = '${DateTime.now().hour}:${DateTime.now().minute}';
      }
      isUpdate ? helper.updateTodo(textNoteModel) : null;
    });
  }

  reminderDialog([int? index, dynamic savedTextNote]) {
    Navigator.of(context).pop();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              height: deviceHeight(context) * 0.31,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth(context) * 0.03,
                        vertical: deviceHeight(context) * 0.02),
                    child: Text('Edit Reminder',
                        style: textStyle20Bold(Colors.black87)),
                  ),
                  Divider(
                    height: deviceHeight(context) * 0.001,
                    color: Colors.black26,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth(context) * 0.03,
                        vertical: deviceHeight(context) * 0.005),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Time', style: textStyle16(Colors.black)),
                        TextButton(
                          onPressed: _presentTimePicker,
                          child: Text(
                            _isSelectTime
                                ? '${_selectedTime!.hour}:${_selectedTime!.minute} ${_selectedTime!.period.name}'
                                : '${DateTime.now().hour}:${DateTime.now().minute}',
                            style: textStyle18(widget.color),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: deviceHeight(context) * 0.001,
                    color: Colors.black26,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth(context) * 0.03,
                        vertical: deviceHeight(context) * 0.005),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date', style: textStyle16(Colors.black)),
                        TextButton(
                          onPressed: _presentDatePicker,
                          child: Text(
                            _isSelectDate
                                ? DateFormat().add_yMd().format(_selectedDate!)
                                : DateFormat().add_yMd().format(DateTime.now()),
                            style: textStyle18(widget.color),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: deviceHeight(context) * 0.001,
                    color: Colors.black26,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth(context) * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel',
                                style: textStyle16(Colors.black54))),
                        TextButton(
                            onPressed: index == null
                                ? _isSave
                                    ? onSaveReminder
                                    : () {
                                        _setState;
                                        Navigator.of(context).pop();
                                      }
                                : isSave
                                    ? () {
                                        // _setState;
                                        onSaveReminder(index, savedTextNote);
                                      }
                                    : () {
                                        // _setState;
                                        Navigator.of(context).pop();
                                      },
                            child: Text('Save',
                                style: textStyle16(Colors.black54)))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  PreferredSizeWidget appBar1(int index, dynamic savedTextNote) {
    return AppBar(
      backgroundColor: widget.color,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        Row(
          children: [
            Container(
              height: deviceHeight(context) * 0.065,
              width: deviceWidth(context) * 0.63,
              padding: EdgeInsets.only(
                left: deviceWidth(context) * 0.03,
              ),
              decoration: isSave
                  ? null
                  : isUpdate
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10))
                      : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isSave
                      ? (Text(
                          savedTextNote.titleText.isEmpty
                              ? 'Title...'
                              : savedTextNote.titleText,
                          style: textStyle16(Colors.black54),
                        ))
                      : isUpdate
                          ? Expanded(
                              child: TextField(
                                controller: _simpleTextController,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  hintText: _simpleTextController.text.isEmpty
                                      ? '  Title...'
                                      : _simpleTextController.text,
                                  hintStyle: textStyle18(Colors.black38),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        _simpleTextController.clear();
                                      },
                                      icon: const Icon(Icons.clear)),
                                ),
                                cursorColor: Colors.black38,
                              ),
                            )
                          : (Text(
                              _simpleTextController.text.isEmpty
                                  ? 'Title...'
                                  : _simpleTextController.text,
                              style: textStyle16(Colors.black54),
                            ))
                ],
              ),
            ),
            isSave
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _simpleTextController.text = savedTextNote.titleText;
                        _noteController.text = savedTextNote.noteText;
                        isUpdate = !isUpdate;
                        isSave = !isSave;
                        print('------1----$isSave');
                      });
                    },
                    icon: const Icon(Icons.edit))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        textNoteIdForUpdate = savedTextNote.id;
                        savedTextNote.titleText = _simpleTextController.text;
                        savedTextNote.noteText = _noteController.text;
                        savedTextNote.time = _isSelectTime
                            ? '${_selectedTime!.hour}:${_selectedTime!.minute}'
                            : savedTextNote.time;
                        savedTextNote.date = _isSelectDate
                            ? DateFormat().add_yMd().format(_selectedDate!)
                            : savedTextNote.date;
                        print('----id----$savedTextNote---');
                        (savedTextNote.titleText!.isNotEmpty &&
                                savedTextNote.noteText != null)
                            ? helper.updateTodo(TextNotes.withId(
                                textNoteIdForUpdate,
                                savedTextNote.titleText,
                                savedTextNote.noteText,
                                savedTextNote.date,
                                savedTextNote.time))
                            : null;
                        isSave = !isSave;
                        isUpdate = !isUpdate;
                        print('------2----$isSave');
                      });
                      isSave ? onSaveReminder(index, savedTextNote) : null;
                    },
                    icon: const Icon(Icons.save)),
            IconButton(
                onPressed: () => shawDialog(index, savedTextNote),
                icon: const Icon(Icons.more_vert, size: 30))
          ],
        ),
      ],
    );
  }

  Widget simpleNote() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isSave
            ? Text(_noteController.text.isEmpty ? '' : textNoteModel.noteText!,
                style: textStyle16())
            : ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: deviceWidth(context),
                  maxWidth: deviceWidth(context),
                  minHeight: 0.0,
                  maxHeight: deviceHeight(context),
                ),
                child: TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    hintText: 'Content...',
                    hintStyle: textStyle18(Colors.black87),
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.black38,
                ),
              ),
        //
      ),
    );
  }

  Widget saveSimpleNote(int index, dynamic savedTextNote) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isSave
            ? Text(
                savedTextNote.noteText,
                style: textStyle16Bold(),
              )
            : isUpdate
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: deviceWidth(context),
                      maxWidth: deviceWidth(context),
                      minHeight: 0.0,
                      maxHeight: deviceHeight(context),
                    ),
                    child: TextField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        hintText:
                            savedTextNote.noteText.isEmpty ? 'Content...' : '',
                        hintStyle: textStyle18(Colors.black87),
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      cursorColor: Colors.black38,
                    ),
                  )
                : Text(
                    savedTextNote.noteText,
                    style: textStyle16Bold(),
                  )
        // ListView.builder(
        //         itemBuilder: (context, i) => Stack(
        //               children: [
        //                 if (i == 0)
        //                   ConstrainedBox(
        //                     constraints: BoxConstraints(
        //                       minWidth: deviceWidth(context),
        //                       maxWidth: deviceWidth(context),
        //                       minHeight: 0.0,
        //                       maxHeight: deviceHeight(context),
        //                     ),
        //                     child: TextField(
        //                       controller: _noteController,
        //                       decoration: InputDecoration(
        //                         hintText: 'Content...',
        //                         hintStyle: textStyle18(Colors.black38),
        //                         border: InputBorder.none,
        //                       ),
        //                       maxLines: null,
        //                       keyboardType: TextInputType.multiline,
        //                       cursorColor: Colors.black38,
        //                     ),
        //                   ),
        //                 if (!(i == 0))
        //                   SizedBox(height: deviceHeight(context) * 0.065),
        //                 if (!(i == 0))
        //                   Divider(
        //                       thickness: deviceHeight(context) * 0.001,
        //                       color: Colors.black54),
        //               ],
        //             ))
        );
  }

  int? _selectedView;
  bool? _reordering;

  void loadData() async {
    await HomeWidget.getWidgetData<String>('_title', defaultValue: '')
        .then((value) {
      _simpleTextController.text = value!;
    });
    setState(() {});
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData<String>(
        '_title', _simpleTextController.text);
    await HomeWidget.updateWidget(
        name: 'MainActivity', iOSName: 'MainActivity');
  }

  void _displayTitle() {
    setState(() {});
    updateAppWidget();
  }

  @override
  void initState() {
    super.initState();
    _reordering = true;
    _selectedView = 0;
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    loadData();
  }

  List<MyItem> noteList = [
    MyItem(0, TextEditingController()),
  ];

  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  List<ListItem>? listNotes;

  // void _delete(BuildContext context, ListItem listItem) async {
  //   int result = await databaseHelper.deleteList(listItem.id!);
  //   if (result != 0) {
  //     updateListView();
  //   }
  // }
  //
  // void updateListView() {
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((database) {
  //     Future<List<ListItem>?> todoListFuture = databaseHelper.getListItem();
  //     todoListFuture.then((noteList) {
  //       setState(() {
  //         listNotes = noteList!;
  //         count = listNotes!.length;
  //       });
  //     });
  //   });
  // }

  Widget listNote() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ReorderableListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                return Column(
                  key: ValueKey(noteList[index]),
                  children: [
                    _isSave
                        ? Row(
                            children: [
                              SizedBox(width: deviceWidth(context) * 0.015),
                              Checkbox(
                                  activeColor: widget.color,
                                  side:
                                      BorderSide(color: widget.color, width: 2),
                                  value: noteList[index].val,
                                  onChanged: (val) {
                                    setState(() {
                                      noteList[index].val = val!;
                                    });
                                  }),
                              SizedBox(width: deviceWidth(context) * 0.01),
                              Text(noteList[index].textFieldText.text)
                            ],
                          )
                        : Row(
                            children: [
                              SizedBox(width: deviceWidth(context) * 0.02),
                              const Icon(Icons.drag_indicator, size: 30),
                              Checkbox(
                                  activeColor: widget.color,
                                  side:
                                      BorderSide(color: widget.color, width: 2),
                                  value: noteList[index].val,
                                  onChanged: (val) {
                                    setState(() {
                                      noteList[index].val = val!;
                                    });
                                  }),
                              Expanded(
                                child: TextField(
                                  controller: noteList[index].textFieldText,
                                  decoration: const InputDecoration(
                                      hintText: 'Content...',
                                      border: InputBorder.none),
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              // Text(noteList[index].textFieldText, style: textStyle18Bold()),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      noteList.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.clear, size: 25)),
                              SizedBox(width: deviceWidth(context) * 0.03),
                            ],
                          ),
                    Divider(
                      thickness: deviceHeight(context) * 0.001,
                      color: Colors.black38,
                    )
                  ],
                );
              },
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > noteList.length) newIndex = noteList.length;
                  if (oldIndex < newIndex) newIndex--;

                  var item = noteList[oldIndex];
                  noteList.remove(item);
                  noteList.insert(newIndex, item);
                });
              },
            ),
          ),
          _isSave
              ? Container()
              : TextButton.icon(
                  onPressed: () {
                    setState(() {
                      listIndex++;
                      noteList.add(MyItem(listIndex, TextEditingController()));
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    size: 27,
                    color: widget.color,
                  ),
                  label: Text(
                    'Add new item',
                    style: textStyle18(widget.color),
                  )),
          const Spacer()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final option = ModalRoute.of(context)!.settings.arguments as dynamic;
    final simpleNoteText = option['simpleNoteText'];
    final listNoteText = option['listNoteText'];
    final index = option['index'];
    final savedTextNote = option['savedTextNote'];

    return SafeArea(
      child: Scaffold(
          appBar: index == null
              ? (simpleNoteText == 1
                  ? appBar(simpleNoteText)
                  : appBar(listNoteText))
              : appBar1(index, savedTextNote),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SizedBox(
                  height: deviceHeight(context),
                  width: deviceWidth(context),
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.fill,
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: deviceHeight(context) * 0.02),
                  child: Column(
                    children: [
                      if (index == null)
                        if (simpleNoteText == 1) simpleNote(),
                      if (listNoteText == 2) listNote(),
                      if (index != null) saveSimpleNote(index, savedTextNote)
                    ],
                  )),
            ],
          )),
    );
  }
}

// ListView.builder(
//         itemBuilder: (context, i) => Stack(
//               children: [
//                 if (i == 0)
//                   ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minWidth: deviceWidth(context),
//                       maxWidth: deviceWidth(context),
//                       minHeight: 0.0,
//                       maxHeight: deviceHeight(context),
//                     ),
//                     child: TextField(
//                       controller: _noteController,
//                       decoration: InputDecoration(
//                         hintText: 'Content...',
//                         hintStyle: textStyle18(Colors.black38),
//                         border: InputBorder.none,
//                       ),
//                       maxLines: null,
//                       keyboardType: TextInputType.multiline,
//                       cursorColor: Colors.black38,
//                     ),
//                   ),
//               ],
//             ))

// for(listIndex;listIndex<noteList.length;listIndex++){
// listItemModel.id = listIndex,
// listItemModel.textFieldText =
// noteList[listIndex]
//     .textFieldText.text,
// listItemModel.checkVal =
// noteList[listIndex].val,
// helper.insertList(listItemModel),

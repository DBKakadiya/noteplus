class TextNotes {
  int? id;
  String? titleText;
  String? noteText;
  String? date;
  String? time;

  TextNotes(this.titleText,this.noteText,this.date,this.time);
  TextNotes.withId(this.id,this.titleText,this.noteText,this.date,this.time);

  // int? get _id => id;
  //
  // String? get _titleText => titleText;
  //
  // dynamic get _noteText => noteText;
  //
  // String? get _date => date;
  //
  // String? get _time => time;
  //
  // set _id(int? newId) {
  //   id = newId;
  // }
  //
  // set _titleText(String? newTitle) {
  //   if (newTitle!.length <= 255) {
  //     titleText = newTitle;
  //   }
  // }
  // set _noteText(dynamic newDescription) {
  //   if (newDescription!.length <= 255) {
  //     noteText = newDescription;
  //   }
  // }
  //
  // set _date(String? newDate) {
  //   date = newDate;
  // }
  //
  // set _time(String? newTime) {
  //   time = newTime;
  // }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'titleText': titleText,
      'noteText': noteText,
      'date': date,
      'time': time
    };
    return map;
  }

    TextNotes.fromMap(Map<String, dynamic> map) {
      id = map['id'];
      titleText = map['titleText'];
      noteText = map['noteText'];
      date = map['date'];
      time = map['time'];
    }

  @override
  String toString() {
    return 'TextNotes{id: $id, titleText: $titleText, noteText: $noteText, date: $date, time: $time}';
  }
}


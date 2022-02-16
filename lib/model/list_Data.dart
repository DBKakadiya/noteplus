class ListItem{
  int? id;
  int? listNoteId;
  String? textFieldText;
  String? checkVal;
  ListItem(this.id,this.listNoteId,this.textFieldText, this.checkVal);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id': id,
      'listNoteId': listNoteId,
      'textFieldText': textFieldText,
      'checkVal': checkVal
    };
    return map;
  }

  ListItem.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    listNoteId = map['listNoteId'];
    textFieldText = map['textFieldText'];
    checkVal = map['checkVal'];
  }

  @override
  String toString() {
    return 'ListItem{id: $id, listNoteId: $listNoteId, textFieldText: $textFieldText, checkVal: $checkVal}';
  }
}
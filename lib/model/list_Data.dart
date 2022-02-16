class ListItem {
  int? id;
  int? listNoteId;
  String? textFieldText;
  bool? checkVal;

  ListItem(this.id,this.listNoteId,this.textFieldText, {this.checkVal = false});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id': id,
      'listId': listNoteId,
      'listTextFieldText': textFieldText,
      'listCheckBox': checkVal
    };
    return map;
  }

  ListItem.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    listNoteId = map['listId'];
    textFieldText = map['listTextFieldText'];
    checkVal = map['listCheckBox'];
  }

  @override
  String toString() {
    return 'ListItem{id: $id, listNoteId: $listNoteId, textFieldText: $textFieldText, checkVal: $checkVal}';
  }
}
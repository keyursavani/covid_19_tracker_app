class Example {
  Example({
      List<Results>? results}){
    _results = results;
}

  Example.fromJson(dynamic json) {
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  List<Results>? _results;

  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Results {
  Results({
      String? gender,}){
    _gender = gender;
}

  Results.fromJson(dynamic json) {
    _gender = json['gender'];
  }
  String? _gender;

  String? get gender => _gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gender'] = _gender;
    return map;
  }

}
class Phone {
  String? name;
  String? number;
  int? id;

  Phone({this.name, this.number, this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'id': id,
    };
  }
}

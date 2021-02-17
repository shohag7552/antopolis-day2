class Person {
  int id;
  String name;
  String address;
  int age;

  Person({this.id, this.name, this.address, this.age});

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        age: json["age"],
      );
}

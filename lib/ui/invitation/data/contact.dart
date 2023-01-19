import 'package:equatable/equatable.dart';

class ContactNumber extends Equatable {

  final String name;
  final String number;

  const ContactNumber({
    required this.name,
    required this.number,
  });

  @override
  String toString() {
    return "$name, $number";
  }

  static const contacts = [
    ContactNumber(name: "Md. Rafiqul Islam", number: "+880 1316-798479"),
    ContactNumber(name: "Shahidullah", number: "+880 1916-979879"),
    ContactNumber(name: "Kalam Azad", number: "+880 5460-979879"),
    ContactNumber(name: "Mr. Siddik", number: "+880 7589-979877"),
    ContactNumber(name: "Babu", number: "+880 3146-867653"),
    ContactNumber(name: "Md. Rafiqul Islam", number: "+880 1316-798479"),
    ContactNumber(name: "Shahidullah", number: "+880 1916-979879"),
    ContactNumber(name: "Kalam Azad", number: "+880 5460-979879"),
    ContactNumber(name: "Mr. Siddik", number: "+880 7589-979877"),
    ContactNumber(name: "Babu", number: "+880 3146-867653"),
    ContactNumber(name: "Md. Rafiqul Islam", number: "+880 1316-798479"),
    ContactNumber(name: "Shahidullah", number: "+880 1916-979879"),
    ContactNumber(name: "Kalam Azad", number: "+880 5460-979879"),
    ContactNumber(name: "Mr. Siddik", number: "+880 7589-979877"),
    ContactNumber(name: "Babu", number: "+880 3146-867653"),
    ContactNumber(name: "Md. Rafiqul Islam", number: "+880 1316-798479"),
    ContactNumber(name: "Shahidullah", number: "+880 1916-979879"),
    ContactNumber(name: "Kalam Azad", number: "+880 5460-979879"),
    ContactNumber(name: "Mr. Siddik", number: "+880 7589-979877"),
    ContactNumber(name: "Babu", number: "+880 3146-867653"),
    ContactNumber(name: "Md. Rafiqul Islam", number: "+880 1316-798479"),
    ContactNumber(name: "Shahidullah", number: "+880 1916-979879"),
    ContactNumber(name: "Kalam Azad", number: "+880 5460-979879"),
    ContactNumber(name: "Mr. Siddik", number: "+880 7589-979877"),
    ContactNumber(name: "Babu", number: "+880 3146-867653"),
    ContactNumber(name: "Md. Rafiqul Islam", number: "+880 1316-798479"),
    ContactNumber(name: "Shahidullah", number: "+880 1916-979879"),
    ContactNumber(name: "Kalam Azad", number: "+880 5460-979879"),
    ContactNumber(name: "Mr. Siddik", number: "+880 7589-979877"),
    ContactNumber(name: "Babu", number: "+880 3146-867653"),
  ];

  @override
  List<Object?> get props => [
        name,
        number,
      ];
}

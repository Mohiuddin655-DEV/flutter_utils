class Patterns {
  static const String digit = r'^\d+(.\d{1,2})?$';
  static const String numeric = r'^-?[0-9]+$';
  static const String letter = r'^[a-z A-Z]+$';
  static const String email =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  //static const String phone = r'^(?:[+0][1-9])?[0-9]{10,12}$';
  static const String phone = r'^[+]*[(]{0,1}[0-9]{1,4}+$';
  static const String url =
      r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
}

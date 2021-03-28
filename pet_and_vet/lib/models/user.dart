class UserApp{
  String _email;
  String _name;
  String pass;
  String _id;


  UserApp(this._email, this._name,this._id);

  String get email => _email;

  set email(String value) {
    _email = value;
  }


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;


  set name(String value) {
    _name = value;
  }
}
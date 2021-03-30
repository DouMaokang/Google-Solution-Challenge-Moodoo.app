class Global {

  Global._();
  static final Global global = Global._();
  static String _username;


  String getUsername() {
      return _username;
  }

  setUsername(String s) {
    _username = s;
  }
}


class APIPath {
  static String senddata(String email, String jobid) => '/$email/$jobid';
  static String readdata(String email) => '/$email';
}

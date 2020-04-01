
import 'package:chatting/firestore.dart';
import 'package:chatting/signin/register.dart';



class APIPath
{
  static String senddata(String uid,String jobid) => '/$uid/$jobid';
  static String readdata(String uid) => '/$uid';


}
import 'package:demoapp/Constant/Constant.dart';
import 'package:get/get.dart';

class HttpService extends GetConnect{

  static const baseurl = 'https://reqres.in/api';

  Future<List> getPost(int page, int per_page) async{

    Response response = await get(baseurl+'/users?page=${page}&per_page=${per_page}');
    Debug('Response => ${response.body['data']}');

    return response.body['data'];

  }
}
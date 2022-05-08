import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/model/base_item.dart';
import 'package:customrig/providers/product_page/repository/product_page_repository.dart';
import 'package:customrig/services/user_service.dart';
import 'package:dio/dio.dart';

class ProductPageRepositoryImpl implements ProductPageRepository {
  String? _uid;
  final _userService = UserService();
  // @override
  // Future<void> addItemToFavorite({required String itemId}) async {
  //   _uid = await _userService.getUserId();
  //   final dio = await MyDio.provideDio();
  //   await dio.post('/item/addItemToFavorite', data: {
  //     "uid": _uid,
  //     "itemId": itemId,
  //   });
  // }

  // @override
  // Future<void> remoteItemFromFavorite({required String itemId}) async {
  //   _uid = await _userService.getUserId();
  //   final dio = await MyDio.provideDio();
  //   await dio.post('/item/removeItemFromFavorites', data: {
  //     "uid": _uid,
  //     "itemId": itemId,
  //   });
  // }

  @override
  Future<BaseItem> getProduct(String id, {required String type}) async {
    final dio = await MyDio.provideDio();

    Response? result;
    BaseItem? product;

    if (type == 'ITEM') {
      result = await dio.post('/item/getItemById', data: {"id": id});
      if (result.statusCode == 200) {
        product = BaseItem.fromJson(result.data);
      }
    } else {
      result = await dio.post('/rig/getRigById', data: {"id": id});
      if (result.statusCode == 200) {
        product = BaseItem.fromJson(result.data);
      }
    }
    return product!;
  }
}

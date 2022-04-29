import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/providers/product_page/repository/product_page_repository.dart';
import 'package:customrig/services/user_service.dart';

class ProductPageRepositoryImpl implements ProductPageRepository {
  String? _uid;
  final _userService = UserService();
  @override
  Future<void> addItemToFavorite({required String itemId}) async {
    _uid = await _userService.getUserId();
    final dio = await MyDio.provideDio();
    await dio.post('/item/addItemToFavorite', data: {
      "uid": _uid,
      "itemId": itemId,
    });
  }

  @override
  Future<void> remoteItemFromFavorite({required String itemId}) async {
    _uid = await _userService.getUserId();
    final dio = await MyDio.provideDio();
    await dio.post('/item/removeItemFromFavorites', data: {
      "uid": _uid,
      "itemId": itemId,
    });
  }
}

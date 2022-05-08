import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/model/base_item.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/providers/favorite_items/repository/favorite_items_repository.dart';
import 'package:customrig/services/user_service.dart';

class FavoriteItemsRepositoryImpl implements FavoriteItemsRepository {
  UserService _userService = UserService();

  String? _uid;

  @override
  Future<void> addItemToFavorite(
      {required String itemId, required String type}) async {
    _uid = await _userService.getUserId();

    final dio = await MyDio.provideDio();
    if (_uid != null) {
      await dio.post('/item/addItemToFavorite', data: {
        "uid": _uid,
        "itemId": itemId,
        "type": type,
      });
    }
  }

  @override
  Future<List<BaseItem>> getFavoriteItems() async {
    _uid = await _userService.getUserId();
    List<BaseItem> _favoriteItemsList = [];

    final dio = await MyDio.provideDio();
    final result = await dio.post('/user/getFavoriteItems', data: {
      "uid": _uid,
    });

    final itemsList = result.data as List;

    for (var item in itemsList) {
      _favoriteItemsList.add(BaseItem.fromJson(item));
    }

    return _favoriteItemsList;
  }

  @override
  Future<void> removeItemFromFavorite({
    required String itemId,
  }) async {
    _uid = await _userService.getUserId();
    final dio = await MyDio.provideDio();
    await dio.post('/item/removeItemFromFavorites', data: {
      "uid": _uid,
      "itemId": itemId,
    });
  }
}

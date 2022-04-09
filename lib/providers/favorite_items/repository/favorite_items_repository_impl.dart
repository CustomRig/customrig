import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/providers/favorite_items/repository/favorite_items_repository.dart';

class FavoriteItemsRepositoryImpl implements FavoriteItemsRepository {
  final _uid = 'ahjfshlkajsflka';

  @override
  Future<void> addItemToFavorite({required String itemId}) async {
    final dio = await MyDio.provideDio();
    await dio.post('/item/addItemToFavorite', data: {
      "uid": _uid,
      "itemId": itemId,
    });
  }

  @override
  Future<List<Item>> getFavoriteItems() async {
    List<Item> _favoriteItemsList = [];

    final dio = await MyDio.provideDio();
    final result = await dio.post('/user/getFavoriteItems', data: {
      "uid": _uid,
    });

    final itemsList = result.data['favorite_items'] as List;

    for (var item in itemsList) {
      _favoriteItemsList.add(Item.fromJson(item));
    }

    return _favoriteItemsList;
  }

  @override
  Future<void> removeItemFromFavorite({
    required String itemId,
  }) async {
    final dio = await MyDio.provideDio();
    await dio.post('/item/removeItemFromFavorites', data: {
      "uid": _uid,
      "itemId": itemId,
    });
  }
}

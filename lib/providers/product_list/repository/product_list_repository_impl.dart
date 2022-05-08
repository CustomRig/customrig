import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/model/base_item.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/model/rig.dart';

import 'product_list_repository.dart';

class ProductListRepositoryImpl extends ProductListRepository {
  @override
  Future<List<BaseItem>> getItemsByCategory({
    required String category,
    required String type,
    required int limit,
  }) async {
    final dio = await MyDio.provideDio();

    if (type == 'RIG') {
      final result = await dio.post(
        '/rig/getRigsByCategory',
        data: {"category": category},
      );

      if (result.statusCode == 200) {
        final items = result.data as List<dynamic>;
        return items.map((item) => Rig.fromJson(item)).toList();
      } else {
        return [];
      }
    } else {
      final result = await dio.post(
        '/item/getItemsByCategory',
        data: {"category": category},
      );

      if (result.statusCode == 200) {
        final items = result.data as List<dynamic>;
        return items.map((item) => Item.fromJson(item)).toList();
      } else {
        return [];
      }
    }
  }

  @override
  Future<List<BaseItem>> searchItems({required String query}) async {
    final dio = await MyDio.provideDio();
    final result = await dio.post('/search', data: {"query": query});

    if (result.statusCode == 200) {
      final items = result.data as List<dynamic>;
      return items.map((item) => BaseItem.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}

import 'package:customrig/global/dio/dio.dart';
import 'package:customrig/model/item.dart';

import 'product_list_repository.dart';

class ProductListRepositoryImpl extends ProductListRepository {
  @override
  Future<List<Item>> getItemsByCategory({required String category}) async {
    final dio = await MyDio.provideDio();
    final result = await dio.post(
      '/item/getItemsByCategory',
      data: {"category": category},
    );

    if (result.statusCode == 200) {
      final items = result.data['items'] as List<dynamic>;
      return items.map((item) => Item.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<Item>> searchItems({required String query}) async {
    final dio = await MyDio.provideDio();
    final result = await dio.post('/search', data: {"query": query});

    if (result.statusCode == 200) {
      final items = result.data['items'] as List<dynamic>;
      return items.map((item) => Item.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}

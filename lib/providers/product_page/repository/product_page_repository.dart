import 'package:customrig/model/base_item.dart';

abstract class ProductPageRepository {
  // Future<void> addItemToFavorite({required String itemId});
  // Future<void> remoteItemFromFavorite({required String itemId});
  Future<BaseItem> getProduct(String id, {required String type});
}

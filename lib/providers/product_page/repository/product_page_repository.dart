abstract class ProductPageRepository {
  Future<void> addItemToFavorite({required String itemId});
  Future<void> remoteItemFromFavorite({required String itemId});
}

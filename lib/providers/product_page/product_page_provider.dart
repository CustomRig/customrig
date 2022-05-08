import 'package:customrig/model/base_item.dart';
import 'package:customrig/providers/favorite_items/repository/favorite_items_repository.dart';
import 'package:customrig/providers/favorite_items/repository/favorite_items_repository_impl.dart';
import 'package:customrig/providers/product_page/repository/product_page_repository.dart';
import 'package:customrig/providers/product_page/repository/product_page_repository_impl.dart';
import 'package:customrig/services/dynamic_link_service.dart';
import 'package:customrig/services/favorite_items_prefs_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

enum ProductPageState {
  initial,
  loading,
  complete,
  error,
}

class ProductPageProvider extends ChangeNotifier {
  final ProductPageRepository _productRepository = ProductPageRepositoryImpl();
  final FavoriteItemsRepository _favoriteRepository =
      FavoriteItemsRepositoryImpl();

  final _favItemPrefsService = FavoriteItemsPrefsService();
  final _dynamicLink = DynamicLinkService();

  ProductPageState _state = ProductPageState.initial;
  ProductPageState get state => _state;

  BaseItem? _product;
  BaseItem? get product => _product;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  Future<void> shareProduct(BaseItem item) async {
    final link = await _dynamicLink.createDynamicLink(item.id!, item.type!);
    Share.share(
        'Checkout out this ${item.type == 'RIG' ? 'rig' : 'product'} \n' + link,
        subject: item.title);
  }

  void handleFavorite() {
    if (_isFavorite) {
      _removeItemFromFavorites(itemId: _product!.id!);
      _isFavorite = !_isFavorite;
      notifyListeners();
    } else {
      _addItemToFavorite(item: _product!);
      _isFavorite = !_isFavorite;
      notifyListeners();
    }
  }

  Future<void> loadProduct(
    BaseItem? product, {
    required String? itemId,
    required String? type,
  }) async {
    if (product == null) {
      // from dynamic link
      try {
        _setState(ProductPageState.loading);
        final fetchedProduct =
            await _productRepository.getProduct(itemId!, type: type!);
        _product = fetchedProduct;
        notifyListeners();
        _setState(ProductPageState.complete);
      } on DioError catch (_) {
        _setState(ProductPageState.error);
      }
    } else {
      // from local product object
      _product = product;
      _isFavorite = await _checkIfFavorite(product.id!);
      _setState(ProductPageState.complete);
    }
  }

  Future<bool> _addItemToFavorite({required BaseItem item}) async {
    try {
      _favItemPrefsService.addItemToFavorite(item);
      await _favoriteRepository.addItemToFavorite(
        itemId: item.id!,
        type: item.type!,
      );
      return true;
    } on DioError catch (e) {
      debugPrint(e.response.toString());
      return false;
    }
  }

  Future<bool> _removeItemFromFavorites({required String itemId}) async {
    try {
      _favItemPrefsService.removeItemFromFavorites(itemId);
      await _favoriteRepository.removeItemFromFavorite(itemId: itemId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _checkIfFavorite(String itemId) async {
    return await _favItemPrefsService.isItemFavorite(itemId);
  }

  void _setState(ProductPageState state) {
    _state = state;
    notifyListeners();
  }
}

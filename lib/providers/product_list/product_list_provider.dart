import 'package:customrig/model/base_item.dart';
import 'package:customrig/providers/product_list/repository/product_list_repository.dart';
import 'package:customrig/providers/product_list/repository/product_list_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum ProductListState {
  initial,
  loading,
  complete,
  error,
}

class ProductListProvider extends ChangeNotifier {
  final int _limit = 20;
  int _offset = 0;

  int get limit => _limit;
  int get offset => _offset;

  List<BaseItem> _items = [];
  List<BaseItem> get items => _items;

  ProductListState _state = ProductListState.initial;
  ProductListState get state => _state;

  final ProductListRepository _repository = ProductListRepositoryImpl();

  RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;

  void increaseLimit() {
    _offset += _limit;
    notifyListeners();
  }

  Future<void> getItemsByCategory({
    required String category,
    required String type,
    bool loadMore = false,
  }) async {
    try {
      if (!loadMore) setState(ProductListState.loading);
      final _itemsFromApi = await _repository.getItemsByCategory(
        category: category,
        type: type,
        limit: _limit,
        offset: _offset,
      );

      if (loadMore) {
        if (_itemsFromApi.isEmpty) {
          _refreshController.loadNoData();
        } else {
          _items.addAll(_itemsFromApi);
          _refreshController.loadComplete();
        }
      } else {
        _items = _itemsFromApi;
      }
      setState(ProductListState.complete);
    } on DioError catch (_) {
      setState(ProductListState.error);
    }
  }

  Future<void> searchItems(
      {required String query, bool loadMore = false}) async {
    try {
      if (!loadMore) setState(ProductListState.loading);

      final _itemsFromApi = await _repository.searchItems(
        query: query,
        limit: _limit,
        offset: _offset,
      );

      if (loadMore) {
        if (_itemsFromApi.isEmpty) {
          _refreshController.loadNoData();
        } else {
          _items.addAll(_itemsFromApi);
          _refreshController.loadComplete();
        }
      } else {
        _items = _itemsFromApi;
      }
      setState(ProductListState.complete);
      _refreshController.loadComplete();
    } on DioError catch (_) {
      setState(ProductListState.error);
    }
  }

  void disposeItems() {
    _items = [];
    _offset = 0;
    _refreshController = RefreshController();
    notifyListeners();
  }

  void setState(ProductListState state) {
    _state = state;
    notifyListeners();
  }
}

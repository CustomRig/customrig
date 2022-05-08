import 'package:customrig/model/base_item.dart';
import 'package:customrig/providers/product_list/repository/product_list_repository.dart';
import 'package:customrig/providers/product_list/repository/product_list_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum ProductListState {
  initial,
  loading,
  complete,
  error,
}

class ProductListProvider extends ChangeNotifier {
  List<BaseItem> _items = [];
  List<BaseItem> get items => _items;

  ProductListState _state = ProductListState.initial;
  ProductListState get state => _state;

  final ProductListRepository _repository = ProductListRepositoryImpl();

  Future<void> getItemsByCategory({
    required String category,
    required String type,
  }) async {
    try {
      setState(ProductListState.loading);
      _items = await _repository.getItemsByCategory(
        category: category,
        type: type,
        limit: 10,
      );
      setState(ProductListState.complete);
    } on DioError catch (_) {
      setState(ProductListState.error);
    }
  }

  Future<void> searchItems(String query) async {
    if (_items.isEmpty) {
      try {
        setState(ProductListState.loading);
        _items = await _repository.searchItems(query: query);
        setState(ProductListState.complete);
      } on DioError catch (_) {
        setState(ProductListState.error);
      }
    }
  }

  void disposeItems() {
    _items = [];
  }

  void setState(ProductListState state) {
    _state = state;
    notifyListeners();
  }
}

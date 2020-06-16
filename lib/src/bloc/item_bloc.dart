import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_shopping_cart/src/catalog.dart';

part 'item_event.dart';
part 'item_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  @override
  CatalogState get initialState => CatalogLoading();

  @override
  Stream<CatalogState> mapEventToState(
    CatalogEvent event,
  ) async* {
    if (event is LoadCatalog) {
      yield* _mapLoadCatalogToState();
    }
  }

  Stream<CatalogState> _mapLoadCatalogToState() async* {
    yield CatalogLoading();
    try {
      yield CatalogLoaded(Product());
    } catch (_) {
      yield CatalogError();
    }
  }
}

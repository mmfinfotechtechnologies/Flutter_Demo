part of 'item_bloc.dart';

@immutable
abstract class CatalogState extends Equatable {
  const CatalogState();
}

class CatalogLoading extends CatalogState {
  @override
  List<Object> get props => [];
}

class CatalogLoaded extends CatalogState {
  final Product product;

  const CatalogLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class CatalogError extends CatalogState {
  @override
  List<Object> get props => [];
}

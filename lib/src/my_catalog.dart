import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_cart/cart/cart.dart';
import 'package:flutter_shopping_cart/src/catalog.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoading) {
                return SliverFillRemaining(
                  child: Center(child: Image.asset("assets/loading.gif")),
                );
              }
              if (state is CatalogLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _MyListItem(
                      state.product.getByPosition(index),
                    ),
                  ),
                );
              }
              return Text('error');
            },
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return Image.asset("assets/loading.gif");
        }
        if (state is CartLoaded) {
          return FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.black)),
            color: Colors.white,
            textColor: Colors.black,
            onPressed: state.items.contains(item)
                ? null
                : () => BlocProvider.of<CartBloc>(context).add(AddItem(item)),
            splashColor: Theme.of(context).primaryColor,
            child: state.items.contains(item)
                ? Icon(Icons.check, semanticLabel: 'ADDED')
                : Text('ADD'),
          );
        }
        return Text('Something went wrong!');
      },
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Items',
      style: TextStyle(
        color: Colors.white
      ),),
      centerTitle: true,
      backgroundColor: Colors.black,
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final Item item;

  const _MyListItem(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.headline6;
    return Card(
        margin: EdgeInsets.all(2.0),
        child: new Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [item.color, Colors.greenAccent[100]],
                begin: const FractionalOffset(0.0, 0.2),
                end: const FractionalOffset(0.8, 0.4),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Image.asset("assets/shoes.png"),
                  ),
                  spaceWidth(),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.name, style: textTheme),
                        spaceHeight(),
                        shoeDetailText(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _AddButton(item: item),
                  ),
                ],
              )),
        ));
  }

  Widget spaceWidth() {
    return SizedBox(
      width: 20.0,
    );
  }
  Widget spaceHeight() {
    return SizedBox(
      width: 20.0,
    );
  }
  Widget shoeDetailText() {
    return Text(
        "A shoe is an item of footwear intended to protect and comfort the human foot. Shoes are also used as an item of decoration and fashion.",
      style: GoogleFonts.alatsi(fontSize: 15.0),);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_cart/cart/cart.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemNameStyle = Theme.of(context).textTheme.headline6;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return Image.asset("assets/loading.gif");
        }
        if (state is CartLoaded) {
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.brightness_1),
              title: Text(
                state.items[index].name,
                style: itemNameStyle,
              ),
            ),
          );
        }
        return Text('Something went wrong!');
      },
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            "Total Price",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state is CartLoading) {
            return CircularProgressIndicator();
          }
          if (state is CartLoaded) {
            return Text(
              '\$${state.totalPrice}',
              style: TextStyle(fontSize: 20.0),
            );
          }
          return Text('Something went wrong!');
        })
      ]),
    );
  }
}

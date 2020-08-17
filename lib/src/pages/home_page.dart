import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc=Provider.of(context);
    return Scaffold(

      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Email: ${bloc.email}'),
            Text('Password: ${bloc.password}')
          ],
        ),

      ),
    );

  }
}
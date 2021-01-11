
import 'package:flutter_firebase_login/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {

  static Route route () {
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Need to import 'package:flutter_bloc/flutter_bloc.dart'; to use context.select.
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
//            onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLog),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
//        child:
      ),
    );
  }

}
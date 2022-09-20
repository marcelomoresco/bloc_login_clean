import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/blocs/home_bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title, required this.username})
      : super(key: key);

  final String title;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeNav) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Center(
              child: Row(
                children: const [
                  Text(
                    "Loading....",
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else {
            return initialLayout(context);
          }
        },
      ),
    );
  }

  Widget initialLayout(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Olá $username!",
              style: const TextStyle(fontSize: 20.00),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(NavBackLogin());
              },
              child: const Text("Voltar"),
            )
          ],
        ),
      );
}

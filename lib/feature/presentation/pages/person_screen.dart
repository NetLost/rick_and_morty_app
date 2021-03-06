import 'package:flutter/material.dart';
import '../widgets/custom_search_delegate.dart';
import '../widgets/persons_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
        centerTitle: true,
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: PersonsList(),
    );
  }
}

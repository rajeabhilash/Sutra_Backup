import 'package:flutter/material.dart';
import 'package:sutra/util/constants/home_page.dart';
import 'package:sutra/util/widgets/containers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: dashboardAppBar,
      body: Row(
        children: [
          dashboardDrawer,
          Expanded(
            flex: 2,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 4,
                  child: SizedBox(
                    width: double.infinity,
                    child: GridView.builder(
                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (context, index) {
                        return const BaseContainer();
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const BaseTile();
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  color: Colors.black,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

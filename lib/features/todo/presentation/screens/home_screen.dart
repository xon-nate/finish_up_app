import 'package:flutter/material.dart';

import '../widgets/todo_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          // backgroundColor: const Color(0xFF006ED4),
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xFF111111),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Color(0xFF111111),
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
          title: const Text(
            'Finish Up',
            style: TextStyle(
              color: Color(0xFF111111),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFECECEC),
          bottom: const TabBar(
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
            labelColor: Color(0xFF111111),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7B8088),
            ),
            tabs: [
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Tasks',
              ),
              Tab(
                text: 'Categories',
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest Tasks',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Kumbh',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TodoItemWidget(
                    isCompleted: false,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TodoItemWidget(
                    isCompleted: true,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

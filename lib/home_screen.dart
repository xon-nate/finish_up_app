import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Latest Tasks',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Kumbh',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Card(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.transparent,
                        trailing: Icon(
                          Icons.check_box_outline_blank,
                          size: 35,
                          color: Color(0xFF7B8088),
                        ),
                        title: Text(
                          'Finish up the design',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111111),
                          ),
                        ),
                        subtitle: Text(
                          'Finish up the design for the project',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7B8088),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Card(
                    elevation: 20, // Apply the same elevation
                    shadowColor:
                        const Color(0xFF111111), // Apply the same shadow color
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Color(0xFF006ED4),
                        width: 2,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    color: const Color(0xFFECF7FE),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        dense: true,
                        trailing: Icon(
                          Icons.check_box,
                          size: 35,
                          color: Color(0xFF0F8CFF),
                        ),
                        title: Text(
                          'Finish up the design',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111111),
                          ),
                        ),
                        subtitle: Text(
                          'Finish up the design for the project',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7B8088),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF006ED4),
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socioapp/mainscreen/cubit/bottomnavbar_cubit.dart';
import 'package:socioapp/mainscreen/homescreeen.dart';

import 'package:socioapp/mainscreen/profilescreen.dart';

import '../friends/Friendscreen.dart';

import '../marketscreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static const List<Widget> _widgetoptions = <Widget>[
    HomeScreen(),
    FriendScreen(),
    MarketScreen(),
    ProfileScreen()
  ];
  void _onItemtapped(index) {
    BlocProvider.of<BottomnavbarCubit>(context).onchanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomnavbarCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: _widgetoptions.elementAt(state),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
              BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Person'),
            ],
            currentIndex: state,
            selectedItemColor: const Color.fromARGB(255, 3, 35, 50),
            unselectedItemColor: const Color.fromARGB(255, 252, 9, 187),
            onTap: _onItemtapped,
          ),
        );
      },
    );
  }
}

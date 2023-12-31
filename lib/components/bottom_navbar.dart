import 'package:expensor/add_item.dart';
import 'package:expensor/home.dart';
import 'package:expensor/profile.dart';
import 'package:expensor/statistics.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index_color = 0;
  List Screen = [Home(), Statistics(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddItem()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 54, 73, 137),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    index_color = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: index_color == 0 ? Color.fromARGB(255, 54, 73, 137) : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Icon(
                  Icons.stacked_line_chart_outlined,
                  size: 30,
                  color: index_color == 1 ? Color.fromARGB(255, 54, 73, 137) : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Icon(
                  Icons.account_circle_rounded,
                  size: 30,
                  color: index_color == 2 ? Color.fromARGB(255, 54, 73, 137) : Colors.grey,
                ),
              ),
              SizedBox(width: 25,),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:expensor/core/add_data.dart';
import 'package:expensor/data/util.dart';
import 'package:expensor/login_screen.dart';
// import 'package:expensor/data/data_list.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _deviceLocation;

  @override
  void initState() {
    super.initState();
    _getDeviceLocation();
  }

  Future<void> _getDeviceLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    setState(() {
      _deviceLocation = "Location: ${position.latitude}, ${position.longitude}";
    });
  }
  var history;
  final box = Hive.box<Add_data>('data');
  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: 300, child: _head()),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transactions History',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          history = box.values.toList()[index];
                          return getList(history, index);
                        },
                        childCount: box.length,
                      ),
                    )
                  ],
                );
              })),
    );
  }

  Widget getList(Add_data history, int index){
    return Dismissible(key: UniqueKey(),
    onDismissed: (direction) {
      history.delete();
    },
    child: get(index, history));
  }

  ListTile get(int index, Add_data history){
    return ListTile(
    title: Text(
      history.name,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
    ),
    subtitle: Text(
      // history.explain,
      '${day[history.datetime.weekday - 1]} ${history.datetime.year}-${history.datetime.day}-${history.datetime.month}',
      style: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    trailing: Text(
      history.amount,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17,
        color: history.IN == 'Income' ? Colors.green:Colors.red,
        ),
      ),
    );
  }

  Widget _head(){
    DateTime now = DateTime.now();
    String greeting = getGreeting(now.hour);
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 54, 73, 137),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    left: 330,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  Padding( 
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 10
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greeting, 
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Chathurindu Kaushalya',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _deviceLocation ?? 'Fetching location...',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 100,
          left: 6,
          child: Container(
            height: 170,
            width: 380,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(47, 83, 125, 0.298),
                  offset: Offset(0,6),
                  blurRadius: 10,
                  spreadRadius: 6,
                ),
              ],
              color: Color.fromARGB(255, 76, 99, 172),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Balance (LKR)',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          '${total()}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Color.fromARGB(255, 85, 145, 141),
                                      child: Icon(Icons.arrow_downward, color: Colors.white,size: 19,),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 7,),
                                Text(
                                  'Income',
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Color.fromARGB(255, 184, 64, 57),
                                      child: Icon(Icons.arrow_upward, color: Colors.white,size: 19,),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 7,),
                                Text(
                                  'Expenses',
                                  style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${income()}',
                            style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                            ),
                          ),
                          Text(
                            '${expenses()}',
                            style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
        ,Positioned(
        top: 10,
        right: 10,
        child: IconButton(
          icon: Icon(
            Icons.logout, // You can change this to the icon you prefer
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            // Add navigation to the login screen here
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ),
      ],
    );
  }

  String getGreeting(int hour) {
    if (hour >= 5 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
}
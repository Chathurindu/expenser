import 'package:expensor/components/charts.dart';
import 'package:expensor/core/add_data.dart';
import 'package:expensor/data/util.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

ValueNotifier<int> selectedIndex = ValueNotifier(0);

class _StatisticsState extends State<Statistics> {
  List<String> timeFrames = ['Day', 'Week', 'Month', 'Year'];
  List<List<Add_data>> data = [today(), week(), month(), year()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 70.0,
            floating: false,
            pinned: true,
            flexibleSpace: ValueListenableBuilder<int>(
              valueListenable: selectedIndex,
              builder: (BuildContext context, int index, Widget? child) {
                return FlexibleSpaceBar(
                  title: Text(
                    'Statistics (${timeFrames[index]})',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  centerTitle: true,
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Wrap(
                  spacing: 16,
                  children: List.generate(
                    timeFrames.length,
                    (index) => ChoiceChip(
                      label: Text(timeFrames[index]),
                      selected: selectedIndex.value == index,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedIndex.value = index;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Chart(indexx: selectedIndex.value),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Spending',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.swap_vert,
                    size: 25,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final addData = data[selectedIndex.value][index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/img/add/${addData.name}.png',
                      height: 40,
                    ),
                  ),
                  title: Text(
                    addData.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    ' ${addData.datetime.year}-${addData.datetime.day}-${addData.datetime.month}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    addData.amount,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      color: addData.IN == 'Income' ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
              childCount: data[selectedIndex.value].length,
            ),
          ),
        ],
        ),
      ),
    );
  }
}

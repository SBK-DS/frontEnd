import 'package:devopsapp/pages/records/dailyrecords/GetRecord.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'PostDailyrecord.dart';

class DailyRecords extends StatefulWidget {
  const DailyRecords({super.key});

  @override
  _DailyRecordsState createState() => _DailyRecordsState();
}

class _DailyRecordsState extends State<DailyRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
                length: 4,
                child: Scaffold(
                  appBar: AppBar(
                      title: Text('Daily Records'),
                      actions: [
                        IconButton(
                          tooltip: 'Add Daily Records',
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Get.to(
                              PostDailyrecord(),
                            );
                          },
                        ),
                      ],
                      bottom: TabBar(
                        isScrollable: true,
                        labelPadding: EdgeInsets.all(15),
                        tabs: [
                          Text('BP',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('Pulse Rate',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('Respiration Rate',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('Body Temperature',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )),
                  body: TabBarView(
                    children: [
                      getRecord(1),
                      getRecord(2),
                      getRecord(3),
                      getRecord(4),
                    ],
                  ),
                ))));
  }
}

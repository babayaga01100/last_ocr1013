import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class PregnantListPage extends StatefulWidget {
  @override
  PregnantListPageState createState() => PregnantListPageState();
}
class MyHomePage extends StatefulWidget {

  @override
  PregnantListPageState createState() => PregnantListPageState();
}

class PregnantListPageState extends State<PregnantListPage> {

  final List<String> ocr_seq = <String>['A', 'B', 'C'];
  final List<int> sow_no = <int>[600, 500, 100];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("임신사 기록보기"),
        ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: ocr_seq.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber[sow_no[index]],
            child: Center(child: Text('Entry ${ocr_seq[index]}')),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
    );
  }
}






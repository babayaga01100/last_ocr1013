import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_rx/get_rx.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:last_ocr/entities/Ocr_pregnant.dart';
import 'package:last_ocr/page/maternity_graph_page.dart';
import 'package:last_ocr/page/pregnant_modify_page.dart';
import 'package:path/path.dart';

import '../functions/functions.dart';


class PregnantListPage extends StatefulWidget {

  // PregnantListPage(List list_ocr_seq);
  // final List ocr_seq;
  final List listfromserver_list_pre ;
  const PregnantListPage(this.listfromserver_list_pre);

  @override
  PregnantListPageState createState() => PregnantListPageState();
}

class PregnantListPageState extends State<PregnantListPage> {

  final List<int> ocr_seq = <int>[];
  final List<String> id = <String>[];
  final List<String> sow_no = <String>[];

  @override
  Widget build(BuildContext context) {

    // final Future<dynamic> result = pregnant_getocr();

     //List list = pregnant_getocr();
    // await pregnant_getocr();
    final file = pregnant_getocr();
    // List list = pregnant_getocr()(file);
    print("값 받아옴");

    print(file);
    // print(result);

    print("길이 : " + widget.listfromserver_list_pre.length.toString());

    for(int i = 0 ; i < widget.listfromserver_list_pre.length ; i++){
      print(widget.listfromserver_list_pre);
      ocr_seq.add(widget.listfromserver_list_pre[i][0]);
      id.add(widget.listfromserver_list_pre[i][1]);
      sow_no.add(widget.listfromserver_list_pre[i][2]);
    }
    print(ocr_seq);
    print("값 채워 넣음");

    return Scaffold(
        appBar: AppBar(title: Text('임신사 기록보기')),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: ocr_seq.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              // height: 50,
              // color: Colors.amber[sow_no[index]],
              // child: Center(child: Text('Entry ${ocr_seq[index]}')),
              child: (
                  Stack(
                    children: [
                      for(int i = 0 ; i < ocr_seq.length ; i++)
                        ListTile(
                          title: Text(id[index] + "     " + sow_no[index].toString()),
                          //subtitle: Text(sow_no[index]),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: (){
                            print(ocr_seq[index].toString());
                            //pregnant_selectrow(ocr_seq[index].toString());
                            //서버로 사용자가 선택한 리스트 값을 보냄
                            pregnant_selectrow(ocr_seq[index]);
                            //화면전환코드
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PregnantModifyPage([])));
                          },
                        ) ,
                      Container(
                        height: 1,
                        color: Colors.black,
                      )
                    ],
                  )
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
    );
  }

}

pregnant_getocr() async {
  var pregnants = <Ocr_pregnant>[].obs;

  final api ='http://211.107.210.141:3000/api/getOcr_pregnant';
  final dio = Dio();
  Response response = await dio.get(api);

  if(response.statusCode == 200) {

    List<dynamic> result = response.data;
    pregnants.assignAll(result.map((data) => Ocr_pregnant.fromJson(data)).toList());
    pregnants.refresh();
    for( int i=0; i<pregnants.length; i++){
      print(" success..."+pregnants[i].ocr_seq.toString()+" "+pregnants[i].sow_no.toString());
      //sum.add(pregnants[i].ocr_seq.toString());
    }
    print("결과 길이 : " + pregnants.length.toString());
  }
  else{
    print(" fail..."+response.statusCode.toString());
  }
  return pregnants.toList() ;
}



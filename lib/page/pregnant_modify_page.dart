import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:last_ocr/functions/functions.dart';
import 'package:last_ocr/overlay/camera_overlay_pregnant.dart';

late int ocr_seq;
late int sow_no;
late String sow_birth;
late String sow_buy;
late String sow_estrus;
late String sow_cross;
late String boar_fir;
late String boar_sec;
late String checkdate;
late String expectdate;
late int vaccine1;
late int vaccine2;
late int vaccine3;
late int vaccine4;
late String memo;
late String filename;

class PregnantModifyPage extends StatefulWidget{
  static const routeName = '/OcrPregnantPage';

  // const PregnantPage({Key? key, this.title}) : super(key: key);
  final List listfromserver_pre_mo;
  const PregnantModifyPage(this.listfromserver_pre_mo);

  // final String? title;

  @override
  PregnantModifyPageState createState() => PregnantModifyPageState();
}

class PregnantModifyPageState extends State<PregnantModifyPage>{

  File? _image;
  final picker = ImagePicker();

  late String sowID1;
  late String sowID2;
  // late String sowID3 ='';
  // late String sowID4 ='';
  // late String sowID5 ='';

  late String birth_year;
  late String birth_month;
  late String birth_day;

  late String adoption_year;
  late String adoption_month;
  late String adoption_day;

  late String hormone_year;
  late String hormone_month;
  late String hormone_day;

  late String mate_month;
  late String mate_day;

  late String boar1ID1;
  late String boar1ID2;
  // late String boar1ID3 ='';
  // late String boar1ID4 ='';
  // late String boar1ID5 ='';

  late String boar2ID1;
  late String boar2ID2;
  // late String boar2ID3 ='';
  // late String boar2ID4 ='';
  // late String boar2ID5 ='';

  late String check_month;
  late String check_day;

  late String expect_month;
  late String expect_day;

  Widget showImage() {

    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .width,
        child: Center(
            child: widget.listfromserver_pre_mo.isEmpty ? Text('No image selected.') :  Text('image is selected.')));
  }

  final sowID1_Controller = TextEditingController();
  final sowID2_Controller = TextEditingController();

  final birth_year_Controller = TextEditingController();

  final birth_month_Controller = TextEditingController();
  final birth_day_Controller = TextEditingController();

  final adoption_year_Controller = TextEditingController();
  final adoption_month_Controller = TextEditingController();
  final adoption_day_Controller = TextEditingController();

  final hormone_year_Controller = TextEditingController();
  final hormone_month_Controller = TextEditingController();
  final hormone_day_Controller = TextEditingController();

  final mate_month_Controller = TextEditingController();
  final mate_day_Controller = TextEditingController();

  final boar1ID1_Controller = TextEditingController();
  final boar1ID2_Controller = TextEditingController();

  final boar2ID1_Controller = TextEditingController();
  final boar2ID2_Controller = TextEditingController();

  final check_month_Controller = TextEditingController();
  final check_day_Controller = TextEditingController();

  final expect_month_Controller = TextEditingController();
  final expect_day_Controller = TextEditingController();

  final vaccine1_fir_Controller = TextEditingController();
  final vaccine1_sec_Controller = TextEditingController();
  final vaccine2_fir_Controller = TextEditingController();
  final vaccine2_sec_Controller = TextEditingController();
  final vaccine3_fir_Controller = TextEditingController();
  final vaccine3_sec_Controller = TextEditingController();
  final vaccine4_fir_Controller = TextEditingController();
  final vaccine4_sec_Controller = TextEditingController();
  final memo_Controller = TextEditingController();
  final pxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(widget.listfromserver_pre_mo.isNotEmpty){
      if(sowID1_Controller.text.isEmpty) {
        print(widget.listfromserver_pre_mo);
        sowID1_Controller.text = widget.listfromserver_pre_mo[1][0];
        sowID2_Controller.text = widget.listfromserver_pre_mo[1][1];
        // late String sowID3 ='';
        // late String sowID4 ='';
        // late String sowID5 ='';

        birth_year_Controller.text = widget.listfromserver_pre_mo[1][2];
        birth_month_Controller.text = widget.listfromserver_pre_mo[1][3];
        birth_day_Controller.text = widget.listfromserver_pre_mo[1][4];

        adoption_year_Controller.text = widget.listfromserver_pre_mo[1][5];
        adoption_month_Controller.text = widget.listfromserver_pre_mo[1][6];
        adoption_day_Controller.text = widget.listfromserver_pre_mo[1][7];

        hormone_year_Controller.text = widget.listfromserver_pre_mo[1][8];
        hormone_month_Controller.text = widget.listfromserver_pre_mo[1][8];
        hormone_day_Controller.text = widget.listfromserver_pre_mo[1][9];

        mate_month_Controller.text = widget.listfromserver_pre_mo[1][10];
        mate_day_Controller.text = widget.listfromserver_pre_mo[1][11];

        boar1ID1_Controller.text = widget.listfromserver_pre_mo[1][12];
        boar1ID2_Controller.text = widget.listfromserver_pre_mo[1][13];
        // late String boar1ID3 ='';
        // late String boar1ID4 ='';
        // late String boar1ID5 ='';

        boar2ID1_Controller.text = widget.listfromserver_pre_mo[1][14];
        boar2ID2_Controller.text = widget.listfromserver_pre_mo[1][15];
        // late String boar2ID3 ='';
        // late String boar2ID4 ='';
        // late String boar2ID5 ='';

        check_month_Controller.text = widget.listfromserver_pre_mo[1][16];
        check_day_Controller.text = widget.listfromserver_pre_mo[1][17];

        expect_month_Controller.text = widget.listfromserver_pre_mo[1][18];
        expect_day_Controller.text = widget.listfromserver_pre_mo[1][19];

        vaccine1_fir_Controller.text = widget.listfromserver_pre_mo[1][20];
        vaccine1_sec_Controller.text = widget.listfromserver_pre_mo[1][21];
        vaccine2_fir_Controller.text = widget.listfromserver_pre_mo[1][22];
        vaccine2_sec_Controller.text = widget.listfromserver_pre_mo[1][23];
        vaccine3_fir_Controller.text = widget.listfromserver_pre_mo[1][24];
        vaccine3_sec_Controller.text = widget.listfromserver_pre_mo[1][25];
        vaccine4_fir_Controller.text = widget.listfromserver_pre_mo[1][26];
        vaccine4_sec_Controller.text = widget.listfromserver_pre_mo[1][27];

        memo_Controller.text = widget.listfromserver_pre_mo[1][28];

        filename = widget.listfromserver_pre_mo[0];
      }
    }


    return Scaffold(
        appBar: AppBar(
          title: Text("?????????"),
        ),
        body: SingleChildScrollView(

          child: Column(
            children:[
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Table(
                  textBaseline: TextBaseline.alphabetic,
                  border: TableBorder.all(),
                  columnWidths: {0: FractionColumnWidth(.0),1: FractionColumnWidth(.4), 2: FractionColumnWidth(.4), 3: FractionColumnWidth(.1),4: FractionColumnWidth(.1)},
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: SizedBox(height: 30,),
                        ),
                        Column(children:[
                          Text('????????????',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
                        ],
                        ),
                        Column(children:[
                          TextField(controller: sowID1_Controller,
                            decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                        ]),
                        Column(children:[
                          Text('-',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
                        ], ),
                        Column(children:[
                          TextField(controller: sowID2_Controller,
                            decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                        ]),

                      ],),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {0:FractionColumnWidth(0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.25), 3: FractionColumnWidth(.3),4: FractionColumnWidth(.3)},
                  children: [
                    TableRow( children: [
                      TableCell(
                        child: SizedBox(height: 30,),
                      ),
                      Column(children:[
                        Text('?????????')
                      ]),
                      Column(children:[
                        TextField(controller: birth_year_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: birth_month_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: birth_day_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                    ],),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {0:FractionColumnWidth(0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.25), 3: FractionColumnWidth(.3),4: FractionColumnWidth(.3)},                  children: [
                  TableRow( children: [
                    TableCell(
                      child: SizedBox(height: 30,),
                    ),
                    Column(children:[
                      Text('?????????')
                    ]),
                    Column(children:[
                      TextField(controller: adoption_year_Controller,
                        decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                    ]),
                    Column(children:[
                      TextField(controller: adoption_month_Controller,
                        decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                    ]),
                    Column(children:[
                      TextField(controller: adoption_day_Controller,
                        decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                    ]),
                  ],),
                ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {0:FractionColumnWidth(0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.25), 3: FractionColumnWidth(.3),4: FractionColumnWidth(.3)},                  children: [
                  TableRow( children: [
                    TableCell(
                      child: SizedBox(height: 30,),
                    ),
                    Column(children:[
                      Text('????????????')
                    ]),
                    Column(children:[
                      TextField(controller: hormone_year_Controller,
                        decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                    ]),
                    Column(children:[
                      TextField(controller: hormone_month_Controller,
                        decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                    ]),
                    Column(children:[
                      TextField(controller: hormone_day_Controller,
                        decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                    ]),
                  ],),
                ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {0:FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.43), 3: FractionColumnWidth(.42)},
                  children: [
                    TableRow( children: [
                      TableCell(
                        child: SizedBox(height: 30,),
                      ),
                      Column(children:[
                        Text('?????????')
                      ]),
                      Column(children:[
                        TextField(controller: mate_month_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: mate_day_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                    ],),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {0:FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.2), 3: FractionColumnWidth(.05),4: FractionColumnWidth(.1),5: FractionColumnWidth(.15), 6: FractionColumnWidth(.2), 7: FractionColumnWidth(.05), 8: FractionColumnWidth(.1)},
                  children: [
                    TableRow( children: [
                      TableCell(
                        child: SizedBox(height: 30,),
                      ),
                      Column(children:[
                        Text('1??? ????????????', textAlign: TextAlign.center)
                      ]),
                      Column(children:[
                        TextField(controller: boar1ID1_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        Text('-',style: TextStyle(fontSize: 20))
                      ]),
                      Column(children:[
                        TextField(controller: boar1ID2_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        Text('2??? ????????????', textAlign: TextAlign.center)
                      ]),
                      Column(children:[
                        TextField(controller: boar2ID1_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        Text('-',style: TextStyle(fontSize: 20))
                      ]),
                      Column(children:[
                        TextField(controller: boar2ID2_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                    ],),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {0:FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.43), 3: FractionColumnWidth(.42)},
                  children: [
                    TableRow( children: [
                      TableCell(
                        child: SizedBox(height: 30,),
                      ),
                      Column(children:[
                        Text('?????? ?????????', textAlign: TextAlign.center)
                      ]),
                      Column(children:[
                        TextField(controller: check_month_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: check_day_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                    ],),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {0: FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.43), 3: FractionColumnWidth(.42)},
                  children: [
                    TableRow( children: [
                      TableCell(
                        child: SizedBox(height: 30,),
                      ),
                      Column(children:[
                        Text('?????? ?????????', textAlign: TextAlign.center)
                      ]),
                      Column(children:[
                        TextField(controller: expect_month_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: expect_day_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                    ],),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {0:FractionColumnWidth(.0), 1: FractionColumnWidth(.15), 2: FractionColumnWidth(.175), 3: FractionColumnWidth(.175),4: FractionColumnWidth(.15), 5: FractionColumnWidth(.175), 6: FractionColumnWidth(.175)},
                  children: [
                    TableRow( children: [
                      TableCell(
                        child: SizedBox(height: 30,),
                      ),
                      Column(children:[
                        Text('??????1')
                      ]),
                      Column(children:[
                        TextField(controller: vaccine1_fir_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: vaccine1_sec_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        Text('??????2')
                      ]),
                      Column(children:[
                        TextField(controller: vaccine2_fir_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: vaccine2_sec_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                    ],),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: {0: FractionColumnWidth(.0), 1: FractionColumnWidth(.15), 2: FractionColumnWidth(.175), 3: FractionColumnWidth(.175), 4: FractionColumnWidth(.15), 5: FractionColumnWidth(.175), 6: FractionColumnWidth(.175)},
                  children: [
                    TableRow( children: [
                      TableCell(
                        child: SizedBox(height: 30,),
                      ),
                      Column(children:[
                        Text('??????3')
                      ]),
                      Column(children:[
                        TextField(controller: vaccine3_fir_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: vaccine3_sec_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        Text('??????4')
                      ]),
                      Column(children:[
                        TextField(controller: vaccine4_fir_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: vaccine4_sec_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                    ],),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Table(

                  border: TableBorder.all(),
                  columnWidths: {0: FractionColumnWidth(0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.85)},
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: SizedBox(height: 100,),
                      ),
                      Column(children:[
                        Text('????????????')
                      ]),
                      Column(children:[
                        TextField(controller: memo_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                    ],),
                  ],
                ),
              ),
              SizedBox(height: 10.0), // ?????? ??????
              showImage(),
              SizedBox(
                height: 15.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: '????????????',
                      child: Icon(Icons.wallpaper),
                      tooltip: 'pick Iamge',
                      onPressed: () async{

                      },
                    ),
                    FloatingActionButton(
                      heroTag: 'send_button',
                      child: Icon(Icons.arrow_circle_right_sharp),
                      tooltip: 'pick Iamge',
                      onPressed: () async{
                        //_showToast(context);
                        // sowID = sowID1_Controller.text + sowID2_Controller.text;
                        // ocr_seq = sowID1_Controller.text + sowID2_Controller.text;
                        sow_no = int.parse(sowID1_Controller.text +  sowID2_Controller.text);
                        sow_birth = birth_year_Controller.text + birth_month_Controller.text + birth_day_Controller.text;
                        sow_buy = adoption_year_Controller.text +  adoption_month_Controller.text +adoption_day_Controller.text;
                        sow_estrus = hormone_year_Controller.text + hormone_month_Controller.text + hormone_day_Controller.text;
                        sow_cross =  mate_month_Controller.text +mate_day_Controller.text;
                        boar_fir = boar1ID1_Controller.text + boar1ID2_Controller.text;
                        boar_sec = boar2ID1_Controller.text + boar2ID2_Controller.text;
                        checkdate = check_month_Controller.text + check_day_Controller.text;
                        expectdate = expect_month_Controller.text+ expect_day_Controller.text;
                        vaccine1 = int.parse(vaccine1_fir_Controller.text + vaccine1_sec_Controller.text);
                        vaccine2 = int.parse(vaccine2_fir_Controller.text + vaccine2_sec_Controller.text);
                        vaccine3 = int.parse(vaccine3_fir_Controller.text + vaccine3_sec_Controller.text);
                        vaccine4 = int.parse(vaccine4_fir_Controller.text + vaccine4_sec_Controller.text);
                        // "ocr_imgpath":'17',
                        memo = memo_Controller.text;
                        print("sowID, ocr_seq");

                        await pregnant_update();
                        //pregnant_update(sow_no, sow_birth, sow_buy, sow_estrus, sow_cross, boar_fir, boar_sec, checkdate, expectdate, vaccine1, vaccine2, vaccine3, vaccine4, memo);

                      },
                    ),
                  ])
            ],
          ),
        )
    );

  }
}

//????????? ?????? ??? ????????????
pregnant_update() async {
  final api ='http://211.107.210.141:3000/api/ocrpregnatUpdate';
  final data = {
    "ocr_seq": ocr_seq,
    "sow_no": sow_no,
    "sow_birth": sow_birth,
    "sow_buy": sow_buy,
    "sow_estrus": sow_estrus,
    "sow_cross": sow_cross,
    "boar_fir": boar_fir,
    "boar_sec": boar_sec,
    "checkdate": checkdate,
    "expectdate": expectdate,
    "vaccine1": vaccine1,
    "vaccine2": vaccine2,
    "vaccine3": vaccine3,
    "vaccine4": vaccine4,
    // "ocr_imgpath":'17',
    "memo": memo,
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  if(response.statusCode == 200){
    //resultToast('Ocr ????????? update success... \n\n');
    print('Ocr ????????? update success... \n\n');
  }
  return 0;
}
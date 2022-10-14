import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:last_ocr/functions/functions.dart';
import 'package:last_ocr/overlay/camera_overlay_maternity.dart';

late int ocr_seq;
late String sow_no;
late String sow_birth;
late String sow_buy;
late String sow_expectdate;
late String sow_givebirth;
late int sow_totalbaby;
late int sow_feedbaby;
late int sow_babyweight;
late String sow_sevrerdate;
late int sow_sevrerqty;
late int sow_sevrerweight;
late int vaccine1;
late int vaccine2;
late int vaccine3;
late int vaccine4;
late String memo;

late String filename;

class MaternityModifyPage extends StatefulWidget{
  static const routeName = '/OcrPregnantPage';

  // const MaternityPage({Key? key, this.title}) : super(key: key);

  final List listfromserver_mat_mo;
  const MaternityModifyPage(this.listfromserver_mat_mo);

  //final String? title;

  @override
  MaternityModifyPageState createState() => MaternityModifyPageState();
}

class MaternityModifyPageState extends State<MaternityModifyPage>{

  File? _image;
  final picker = ImagePicker();

  late String sowID1;
  late String sowID2;
  late String birth_year;
  late String birth_month;
  late String birth_day;
  late String adoption_year;
  late String adoption_month;
  late String adoption_day;
  late String expect_year;
  late String expect_month;
  late String expect_day;

  late String teen_month;
  late String teen_day;
  late String givebirth_month;
  late String givebirth_day;
  late String totalbaby;
  late String feedbaby;
  late String weight;
  late String totalteen;
  late String teenweight;


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
            child: Text('No image selected.')));
  }


  //모돈번호
  final sowID1_Controller = TextEditingController();
  final sowID2_Controller = TextEditingController();

  //출생일
  final birth_year_Controller = TextEditingController();
  final birth_month_Controller = TextEditingController();
  final birth_day_Controller = TextEditingController();

  //구입일
  final adoption_year_Controller = TextEditingController();
  final adoption_month_Controller = TextEditingController();
  final adoption_day_Controller = TextEditingController();

  //분만예정일
  final expect_year_Controller = TextEditingController();
  final expect_month_Controller = TextEditingController();
  final expect_day_Controller = TextEditingController();

  //이유일
  final teen_month_Controller = TextEditingController();
  final teen_day_Controller = TextEditingController();

  //분만일
  final givebirth_month_Controller = TextEditingController();
  final givebirth_day_Controller = TextEditingController();

  //총산자수
  final totalbaby_Controller = TextEditingController();
  final feedbaby_Controller = TextEditingController();
  //생시체중
  final weight_Controller = TextEditingController();

  //이유두수
  final totalteen_Controller = TextEditingController();

  //이유체중

  final teenweight_Controller = TextEditingController();


  final vaccine1_fir_Controller = TextEditingController();
  final vaccine1_sec_Controller = TextEditingController();
  final vaccine2_fir_Controller = TextEditingController();
  final vaccine2_sec_Controller = TextEditingController();
  final vaccine3_fir_Controller = TextEditingController();
  final vaccine3_sec_Controller = TextEditingController();
  final vaccine4_fir_Controller = TextEditingController();
  final vaccine4_sec_Controller = TextEditingController();

  final memo_Controller = TextEditingController();



  @override
  Widget build(BuildContext context) {

    if(widget.listfromserver_mat_mo.isNotEmpty){
      if(sowID1_Controller.text.isEmpty) {
        print(widget.listfromserver_mat_mo);
        sowID1_Controller.text = widget.listfromserver_mat_mo[1][0];
        sowID2_Controller.text = widget.listfromserver_mat_mo[1][1];
        // late String sowID3 ='';
        // late String sowID4 ='';
        // late String sowID5 ='';

        birth_year_Controller.text = widget.listfromserver_mat_mo[1][2];
        birth_month_Controller.text = widget.listfromserver_mat_mo[1][3];
        birth_day_Controller.text = widget.listfromserver_mat_mo[1][4];

        adoption_year_Controller.text = widget.listfromserver_mat_mo[1][5];
        adoption_month_Controller.text = widget.listfromserver_mat_mo[1][6];
        adoption_day_Controller.text = widget.listfromserver_mat_mo[1][7];

        expect_year_Controller.text = widget.listfromserver_mat_mo[1][8];
        expect_month_Controller.text = widget.listfromserver_mat_mo[1][8];
        expect_day_Controller.text = widget.listfromserver_mat_mo[1][9];

        teen_month_Controller.text = widget.listfromserver_mat_mo[1][10];
        teen_day_Controller.text = widget.listfromserver_mat_mo[1][11];

        givebirth_month_Controller.text = widget.listfromserver_mat_mo[1][12];
        givebirth_day_Controller.text = widget.listfromserver_mat_mo[1][13];

        totalbaby_Controller.text = widget.listfromserver_mat_mo[1][14];
        feedbaby_Controller.text = widget.listfromserver_mat_mo[1][15];

        weight_Controller.text = widget.listfromserver_mat_mo[1][16];
        totalteen_Controller.text = widget.listfromserver_mat_mo[1][17];
        teenweight_Controller.text = widget.listfromserver_mat_mo[1][18];

        expect_month_Controller.text = widget.listfromserver_mat_mo[1][19];
        expect_day_Controller.text = widget.listfromserver_mat_mo[1][20];

        vaccine1_fir_Controller.text = widget.listfromserver_mat_mo[1][21];
        vaccine1_sec_Controller.text = widget.listfromserver_mat_mo[1][22];
        vaccine2_fir_Controller.text = widget.listfromserver_mat_mo[1][23];
        vaccine2_sec_Controller.text = widget.listfromserver_mat_mo[1][24];
        vaccine3_fir_Controller.text = widget.listfromserver_mat_mo[1][25];
        vaccine3_sec_Controller.text = widget.listfromserver_mat_mo[1][26];
        vaccine4_fir_Controller.text = widget.listfromserver_mat_mo[1][27];
        vaccine4_sec_Controller.text = widget.listfromserver_mat_mo[1][28];

        memo_Controller.text = widget.listfromserver_mat_mo[1][29];

        filename = widget.listfromserver_mat_mo[0];
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("분만사"),
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
                          Text('모돈번호',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
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
                        Text('출생일')
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
                      Text('구입일')
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
                      Text('분만예정일')
                    ]),
                    Column(children:[
                      TextField(controller: expect_year_Controller,
                        decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
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
                  columnWidths: {0:FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.43), 3: FractionColumnWidth(.42)},
                  children: [
                    TableRow( children: [
                      TableCell(
                        child: SizedBox(height: 30,),
                      ),
                      Column(children:[
                        Text('분만일')
                      ]),
                      Column(children:[
                        TextField(controller: givebirth_month_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: givebirth_day_Controller,
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
                        Text('총산자수', textAlign: TextAlign.center)
                      ]),
                      Column(children:[
                        TextField(controller: totalbaby_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        Text('포유개시두수', textAlign: TextAlign.center)
                      ]),
                      Column(children:[
                        TextField(controller: feedbaby_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        Text('생시체중(kg)', textAlign: TextAlign.center)
                      ]),
                      Column(children:[
                        TextField(controller: weight_Controller,
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
                        Text('이유일', textAlign: TextAlign.center)
                      ]),
                      Column(children:[
                        TextField(controller:  teen_month_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        TextField(controller: teen_day_Controller,
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
                        Text('이유두수', textAlign: TextAlign.center)
                      ]),
                      Column(children:[
                        TextField(controller: totalteen_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                      Column(children:[
                        Text('이유체중(kg)', textAlign: TextAlign.center)
                      ]),
                      Column(children:[
                        TextField(controller: teenweight_Controller,
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
                        Text('백신1')
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
                        Text('백신2')
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
                        Text('백신3')
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
                        Text('백신4')
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
                        Text('특이사항')
                      ]),
                      Column(children:[
                        TextField(controller: memo_Controller,
                          decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),),
                      ]),
                    ],),
                  ],
                ),
              ),
              SizedBox(height: 10.0), // 위에 여백
              showImage(),
              SizedBox(
                height: 15.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    FloatingActionButton(
                      heroTag: 'gallery_button',
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
                        //ocr_seq = sowID1_Controller.text + "," + sowID1_Controller.text;
                        //sowID = sowID1_Controller.text + "," + sowID2_Controller.text;
                        //ocr_seq = sowID1_Controller.text + "," + sowID2_Controller.text;
                        sow_no = sowID1_Controller.text + "," + sowID2_Controller.text;
                        sow_birth = birth_year_Controller.text +"," + birth_month_Controller.text + "," + birth_day_Controller.text;
                        sow_buy = adoption_year_Controller.text + "," +  adoption_month_Controller.text + "," + adoption_day_Controller.text;
                        sow_expectdate = expect_year_Controller.text + "," + expect_month_Controller.text + "," + expect_day_Controller.text;
                        sow_givebirth = givebirth_month_Controller.text + "," + givebirth_day_Controller.text;
                        sow_totalbaby = int.parse(totalbaby_Controller.text);
                        sow_feedbaby = int.parse(feedbaby_Controller.text);
                        sow_babyweight = int.parse(weight_Controller.text); //생시체중
                        sow_sevrerdate = teen_month_Controller.text + teen_day_Controller.text;//이유일
                        sow_sevrerqty   = int.parse(totalteen_Controller.text);//이유두수
                        sow_sevrerweight = int.parse(teenweight_Controller.text);//이유체중
                        vaccine1 = int.parse(vaccine1_fir_Controller.text + "," + vaccine1_sec_Controller.text);
                        vaccine2 = int.parse(vaccine2_fir_Controller.text + "," + vaccine2_sec_Controller.text);
                        vaccine3 = int.parse(vaccine3_fir_Controller.text + "," + vaccine3_sec_Controller.text);
                        vaccine4 = int.parse(vaccine4_fir_Controller.text + "," + vaccine4_sec_Controller.text);
                        // "ocr_imgpath":'17',
                        memo = memo_Controller.text;

                        await maternity_update();
                      },
                    ),
                  ])
            ],
          ),
        )
    );

  }
}

maternity_update() async {
  final api ='http://211.107.210.141:3000/api/ocrmaternityUpdate';
  final data = {
    "ocr_seq": ocr_seq,
    "sow_no": sow_no,
    "sow_birth": sow_birth,
    "sow_buy": sow_buy,
    "sow_expectdate": sow_expectdate,
    "sow_givebirth": sow_givebirth,
    "sow_totalbaby": sow_totalbaby,
    "sow_feedbaby": sow_feedbaby,
    "sow_babyweight": sow_babyweight,
    "sow_sevrerdate": sow_sevrerdate,
    "sow_sevrerqty": sow_sevrerqty,
    "sow_sevrerweight": sow_sevrerweight,
    "vaccine1": vaccine1,
    "vaccine2": vaccine2,
    "vaccine3": vaccine3,
    "vaccine4": vaccine4,
    // "ocr_imgpath":'14',
    "memo": memo,
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  if(response.statusCode == 200){
    resultToast('Ocr 분만사 update success... \n\n');
  }
}
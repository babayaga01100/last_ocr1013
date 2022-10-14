import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_rx/get_rx.dart';
import 'package:last_ocr/entities/Ocr_pregnant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';
//임신사 사진전송
// pregnant_insert(String path) async {
//   final api ='http://211.107.210.141:3000/api/ocrpregnatInsert';
//   final data = {
//     "ocr_imgpath": path,
//   };
//   final dio = Dio();
//   Response response;
//   response = await dio.post(api,data: data);
//   if(response.statusCode == 200){
//     resultToast('Ocr 임신사 insert success... \n\n');
//   }
// }

//전체 기록 불러오기
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
    }
  }else{
    print(" fail..."+response.statusCode.toString());
  }
}

//선택한 기록 불러오기
//사용자 아이디, 모돈 번호를 보내고 그 값을 받아옴
pregnant_selectrow(int num) async{
  final api ='http://211.107.210.141:3000/api/ocr_pregnantSelectedRow';
  final data = {
    "ocr_seq": num, //pk
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  if(response.statusCode == 200) {
    print("col 1.."+response.data[0].toString());
    print("col 10.."+response.data[10].toString());
  }else{
    print(" fail..."+response.statusCode.toString());
  }
}

uploadimg_pregnant(File file)async{
  // final api = 'http://172.17.53.63:3000/api/ocrImageUpload';
  final api ='http://211.107.210.141:3000/api/ocrImageUpload';
  final dio = Dio();
  // String fileName = file.path.split('/').last;

  DateTime now = DateTime.now();
  String fileName = now.year.toString()+now.month.toString()+now.day.toString()+now.hour.toString()+now.minute.toString()+'.jpg';
  // final api2 = 'http://172.17.53.63:3000/api/ocrImageUpload' + fileName;

  FormData _formData = FormData.fromMap({
    "file" : await MultipartFile.fromFile(file.path,
        filename: fileName, contentType : MediaType("image","jpg")),
  });

  Response response = await dio.post(
      api,
      data:_formData
  );
  return response.data;
}

uploadimg_maternity(File file)async{
  // final api = 'http://172.17.53.63:3000/api/ocrImageUpload';
  final api ='http://211.107.210.141:3000/api/ocrImageUpload';
  final dio = Dio();
  // String fileName = file.path.split('/').last;

  DateTime now = DateTime.now();
  String fileName = now.year.toString()+now.month.toString()+now.day.toString()+now.hour.toString()+now.minute.toString()+'.jpg';
  // final api2 = 'http://172.17.53.63:3000/api/ocrImageUpload' + fileName;

  FormData _formData = FormData.fromMap({
    "file" : await MultipartFile.fromFile(file.path,
        filename: fileName, contentType : MediaType("image","jpg")),
  });

  Response response = await dio.post(
      api,
      data:_formData
  );
  return response.data;
}

// //수정 후 서버 전송 / pregnant_page에 있음
// pregnant_insert(String? sow_no,String? sow_birth, String? sow_buy, String? sow_estrus, String? sow_cross, String? boar_fir, String? boar_sec,
//     String? checkdate, String? expectdate, String? vaccine1, String? vaccine2, String? vaccine3, String? vaccine4, String? memo) async {
//   final api ='http://211.107.210.141:3000/api/ocrpregnatInsert';
//   final data = {
//     // "ocr_seq": ocr_seq,
//     "sow_no": sow_no,
//     "sow_birth": sow_birth,
//     "sow_buy":sow_buy,
//     "sow_estrus":sow_estrus,
//     "sow_cross":sow_cross,
//     "boar_fir":boar_fir,
//     "boar_sec":boar_sec,
//     "checkdate":checkdate,
//     "expectdate":expectdate,
//     "vaccine1":vaccine1,
//     "vaccine2":vaccine2,
//     "vaccine3":vaccine3,
//     "vaccine4":vaccine4,
//     // "ocr_imgpath":'17',
//     "memo":memo,
//   };
//   final dio = Dio();
//   Response response;
//   response = await dio.post(api,data: data);
//   print(response.data.toString());
//   print(response.data);
//   if(response.statusCode == 200){
// //resultToast('Ocr 임신사 update success... \n\n');
//     print('Ocr 임신사 insert success... \n\n');
//   }
//   return 0;
// }



//분만사 사진전송
// maternity_insert() async{
//   final api ='http://211.107.210.141:3000/api/ocrmaternityInsert';
//   final data = {
//     "sow_no":'2',
//     "sow_birth":'2',
//     "sow_buy":'3',
//     "sow_expectdate":'4',
//     "sow_givebirth":'5',
//     "sow_totalbaby":'6',
//     "sow_feedbaby":'7',
//     "sow_babyweight":'8',
//     "sow_sevrerdate":'9',
//     "sow_sevrerqty":'9',
//     "sow_sevrerweight":'9',
//     "vaccine1":'10',
//     "vaccine2":'11',
//     "vaccine3":'12',
//     "vaccine4":'13',
//     "ocr_imgpath":'14',
//     "memo":'16',
//   };
//   final dio = Dio();
//   Response response;
//   response = await dio.post(api,data: data);
//   if(response.statusCode == 200){
//     resultToast('Ocr 분만사 insert success... \n\n');
//   }
// }

//분만사 전체 기록 불러오기
maternity_getocr() async {
  var pregnants = <Ocr_pregnant>[].obs;

  final api ='http://211.107.210.141:3000/api/getOcr_maternity';
  final dio = Dio();
  Response response = await dio.get(api);
  if(response.statusCode == 200) {

    List<dynamic> result = response.data;
    pregnants.assignAll(result.map((data) => Ocr_pregnant.fromJson(data)).toList());
    pregnants.refresh();
    for( int i=0; i<pregnants.length; i++){
      print(" success..."+pregnants[i].ocr_seq.toString()+" "+pregnants[i].sow_no.toString());
    }
  }else{
    print(" fail..."+response.statusCode.toString());
  }
}

//선택한 리스트 값 받아오기
maternity_selectrow() async {
  final api ='http://211.107.210.141:3000/api/ocr_maternitySelectedRow';
  final data = {
    "ocr_seq":int.parse('1'),
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  if(response.statusCode == 200) {
    print("col 1.."+response.data[0].toString());
    print("col 10.."+response.data[10].toString());
  }else{
    print(" fail..."+response.statusCode.toString());
  }
}



//임신사 수정 후 업데이트 //기록에 붙이기
pregnant_update(String? ocrSeq, String? sowNo,String? sowBirth, String? sowBuy, String? sowEstrus, String? sowCross, String? boarFir, String? boarSec,
    String? checkdate, String? expectdate, String? vaccine1, String? vaccine2, String? vaccine3, String? vaccine4, String? memo) async {
  final api ='http://211.107.210.141:3000/api/ocrpregnatUpdate';
  final data = {
    "ocr_seq": ocrSeq,
    "sow_no": sowNo,
    "sow_birth": sowBirth,
    "sow_buy":sowBuy,
    "sow_estrus":sowEstrus,
    "sow_cross":sowCross,
    "boar_fir":boarFir,
    "boar_sec":boarSec,
    "checkdate":checkdate,
    "expectdate":expectdate,
    "vaccine1":vaccine1,
    "vaccine2":vaccine2,
    "vaccine3":vaccine3,
    "vaccine4":vaccine4,
    // "ocr_imgpath":'17',
    "memo":memo,
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  if(response.statusCode == 200){
    //resultToast('Ocr 임신사 update success... \n\n');
    print('Ocr 임신사 update success... \n\n');
  }
  return 0;
}

resultToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      fontSize: 16.0
  );
}
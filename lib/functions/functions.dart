import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_rx/get_rx.dart';
import 'package:last_ocr/entities/Ocr_pregnant.dart';

//임신사 사진전송
pregnant_insert(String path) async {
  final api = 'http://211.107.210.141:3000/api/ocrImageUpl';
  final data = {
    "ocr_imgpath": path,
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api, data: data);
  if (response.statusCode == 200) {
    resultToast('Ocr 임신사 insert success... \n\n');
  }

}

//전체 기록 불러오기
pregnant_getocr() async {
  var pregnants = <Ocr_pregnant>[].obs;

  final api ='http://211.107.210.141:3000/api/getOcr_pregnant';
  final dio = Dio();

  print("기록 불러올거임");
  Response response = await dio.get(api);
  if(response.statusCode == 200) {
    List<dynamic> result = response.data;
    pregnants.assignAll(result.map((data) => Ocr_pregnant.fromJson(data)).toList());
    pregnants.refresh();
    print("기록 불러와짐");
    print(pregnants.length);
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

//수정 후 서버 전송
pregnant_update() async{
  final api ='http://211.107.210.141:3000/api/ocrpregnatUpdate';
  final data = {
    "ocr_seq":'2',
    "sow_no":'2',
    "sow_birth":'5',
    "sow_buy":'6',
    "sow_estrus":'7',
    "sow_cross":'8',
    "boar_fir":'9',
    "boar_sec":'10',
    "checkdate":'11',
    "expectdate":'12',
    "vaccine1":'13',
    "vaccine2":'14',
    "vaccine3":'15',
    "vaccine4":'16',
    // "ocr_imgpath":'17',
    "memo":'18',
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  if(response.statusCode == 200){
    resultToast('Ocr 임신사 update success... \n\n');
  }
}


//분만사 사진전송
maternity_insert(String path) async{
  final api ='http://211.107.210.141:3000/api/home/gfarm/ocrimages';
  final data = {
    "ocr_imgpath":path,
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  if(response.statusCode == 200){
    resultToast('Ocr 분만사 insert success... \n\n');
  }
}

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

//수정 후 서버로 다시 전송
maternity_update() async {
  final api ='http://211.107.210.141:3000/api/ocrmaternityUpdate';
  final data = {
    "ocr_seq":'1',
    "sow_no":'2',
    "sow_birth":'5',
    "sow_buy":'6',
    "sow_expectdate":'4',
    "sow_givebirth":'5',
    "sow_totalbaby":'6',
    "sow_feedbaby":'7',
    "sow_babyweight":'8',
    "sow_sevrerdate":'9',
    "sow_sevrerqty":'9',
    "sow_sevrerweight":'9',
    "vaccine1":'10',
    "vaccine2":'11',
    "vaccine3":'12',
    "vaccine4":'13',
    // "ocr_imgpath":'14',
    "memo":'22',
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  if(response.statusCode == 200){
    resultToast('Ocr 분만사 update success... \n\n');
  }
}

//Toast 찍기
resultToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      fontSize: 16.0
  );
}


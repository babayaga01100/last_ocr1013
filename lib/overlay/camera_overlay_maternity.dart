import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_camera_overlay/flutter_camera_overlay.dart';
import 'package:flutter_camera_overlay/model.dart';
import 'package:http_parser/http_parser.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../functions/functions.dart';
import '../page/maternity_page.dart';
import 'package:gallery_saver/gallery_saver.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';


// import 'dart:io';
// import 'package:image/image.dart' as img;

typedef XFileCallback = void Function(XFile file);

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const CameraOverlayMaternity(),
  );
}

class CameraOverlayMaternity extends StatefulWidget {

  static const routeName = '/graph-page';

  const CameraOverlayMaternity({Key? key}) : super(key: key);

  @override
  CameraOverlayMaternityState createState() => CameraOverlayMaternityState();
}

class CameraOverlayMaternityState extends State<CameraOverlayMaternity> {
  OverlayFormat format = OverlayFormat.cardID1;
  int tab = 0;

  cropImage(String cameraurl) async {
    File? croppedfile = await ImageCropper().cropImage(
        sourcePath: cameraurl,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Image Cropper',
            toolbarColor: Colors.deepPurpleAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );

    if (croppedfile != null) {
      // imagefile = croppedfile;
      setState(() { });
    }else{
      print("Image is not cropped.");
    }
    return croppedfile;
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var size = media.size;
    double width = media.orientation == Orientation.portrait
        ? size.shortestSide * .9
        : size.longestSide * .5;

    double height = width * 1.414;

    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder<List<CameraDescription>?>(
            future: availableCameras(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No camera found',
                        style: TextStyle(color: Colors.black),
                      ));
                }
                return CameraOverlay(
                    snapshot.data!.first,
                    CardOverlay.byFormat(format),
                        (XFile file) => showDialog(
                      context: context,
                      barrierColor: Colors.black,
                      builder: (context) {
                        CardOverlay overlay = CardOverlay.byFormat(format);
                        return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            backgroundColor: Colors.black,
                            // title: const Text('찰칵',
                            //     style: TextStyle(color: Colors.white),
                            //     textAlign: TextAlign.center),
                            title: Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      child: const Icon(Icons.arrow_back_rounded)
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () async {
                                    var filename = file.path.split('/').last;
                                    print(filename);

                                    // ImageProperties properties = await FlutterNativeImage.getImageProperties(file.path);
                                    // final filename = await submit_uploadimg_back(file);

                                    List list = await uploadimg_maternity(File(file.path));

                                    GallerySaver.saveImage(file.path)
                                        .then((value) => print('>>>> save value= $value'))
                                        .catchError((err) {
                                      print('error : $err');
                                    });

                                    //서버로 사진 전송
                                    // final api ='http://211.107.210.141:3000/api/ocrpregnatInsert';
                                    // final dio = Dio();
                                    // Response response;
                                    // response = await dio.post(api, data: file);
                                    // if(response.statusCode == 200){
                                    //   //resultToast('Ocr 임신사 insert success... \n\n');
                                    //   array = receiveresult();
                                    //   //_showToast(context);
                                    // }

                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                    await Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                    MaternityPage(list)),
                                    );
                                  },
                                  child: Container(
                                      alignment: Alignment.topRight,
                                      child: const Icon(Icons.send)
                                  ),
                                ),
                              ],
                            ),
                                  actions: [
                                  OutlinedButton(
                                  // onPressed: () => Navigator.of(context).pop(),
                                  //
                                  //     Navigator.pop(context, file.path);
                                  onPressed: () async {
                                    final croppedfile = await cropImage(file.path);
                                    List list = await uploadimg_maternity(File(croppedfile.path));

                                    GallerySaver.saveImage(croppedfile.path)
                                        .then((value) => print('>>>> save value= $value'))
                                        .catchError((err) {
                                    print('error : $err');
                                    });

                                    // pregnant_insert(list);
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                    await Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                    MaternityPage(list)),
                                    );
                                  },
                                  child: const Icon(Icons.edit))
                            ],
                            content: SizedBox( // 뒤로가기 버튼 만든 그 페이지 사이즈박스
                                width: double.infinity,
                                child: AspectRatio(
                                  // aspectRatio: overlay.ratio!,
                                  aspectRatio: width/height,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          alignment: FractionalOffset.center,
                                          image: FileImage(
                                            File(file.path),
                                          ),
                                        )),

                                  ),
                                )));
                      },


                    ),
                    info:
                    '박스에 맞춰 사진찍어주세요');
              } else {
                return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '분만사 카메라예용',
                      style: TextStyle(color: Colors.black),
                    ));
              }
            },
          ),
        ));
  }
}

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
import '../page/pregnant_page.dart';
import 'package:gallery_saver/gallery_saver.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';


main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const CameraOverlayPregnant(),
  );
}

class CameraOverlayPregnant extends StatefulWidget {

  static const routeName = '/graph-page';

  const CameraOverlayPregnant({Key? key}) : super(key: key);

  @override
  CameraOverlayPregnantState createState() => CameraOverlayPregnantState();
}

class CameraOverlayPregnantState extends State<CameraOverlayPregnant> {
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
                                    // File croppedfile = await FlutterNativeImage.cropImage(file.path,210,297, properties.width! - 500, 640);
                                    // final filename = await submit_uploadimg(croppedfile);

                                    List list = await uploadimg_pregnant(File(file.path));

                                    GallerySaver.saveImage(file.path)
                                        .then((value) => print('>>>> save value= $value'))
                                        .catchError((err) {
                                      print('error : $err');
                                    });

                                    // pregnant_insert(list);
                                    // await getimg("hi.jpg");
                                    // await downloadFile();
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                    await Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                        PregnantPage(list)),
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
                                    List list = await uploadimg_pregnant(File(croppedfile.path));

                                    GallerySaver.saveImage(croppedfile.path)
                                        .then((value) => print('>>>> save value= $value'))
                                        .catchError((err) {
                                      print('error : $err');
                                    });

                                    // pregnant_insert(list);
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                    await Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                        PregnantPage(list)),
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
                      '임신사 카메라임',
                      style: TextStyle(color: Colors.black),
                    ));
              }
            },
          ),
        ));
  }
}

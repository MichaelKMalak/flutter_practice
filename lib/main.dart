import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'form_build_example.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Image Upload',
    home: FormBuildExample(),
  ));


  var dio = Dio();
  dio.options.baseUrl = "http://localhost:3000/";
  dio.interceptors.add(LogInterceptor());
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.findProxy = (uri) {
      return "PROXY localhost:8888";
    };

    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  };
  Response response;

  var formDataExample = await FormDataExample();
  var bytes=await formDataExample.readAsBytes() ;

  response = await dio.post(
    "/upload",
    //"http://localhost:3000/upload",
    data: bytes,
    onSendProgress: (received, total) {
      if (total != -1) {
        print((received / total * 100).toStringAsFixed(0) + "%");
      }
    },
  );
  print(response);
}

Future<FormData> FormDataExample() async {
  var formData = FormData();
  formData.fields..add(MapEntry("name", "michael"))..add(MapEntry("age", "23"));

  formData.files.add(MapEntry(
    "file",
    await MultipartFile.fromFile("./lib/1.png",
        filename: "1.png"),
  ));

  formData.files.addAll([
    MapEntry(
      "files[]",
      await MultipartFile.fromFile("./lib/upload.txt",
          filename: "upload.txt"),
    ),
    MapEntry(
      "files[]",
      MultipartFile.fromFileSync("./lib/upload.txt",
          filename: "upload.txt"),
    ),
  ]);
  return formData;
}

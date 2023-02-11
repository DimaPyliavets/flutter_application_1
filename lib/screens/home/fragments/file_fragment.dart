import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/upload.dart';
import 'package:path_provider/path_provider.dart';

class FileFragment extends StatefulWidget {
  const FileFragment({Key? key}) : super(key: key);

  @override
  State<FileFragment> createState() => _FileFragmentState();
}

class _FileFragmentState extends State<FileFragment> {
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};

  Future onRefresh() async {
    setState(() {});
    futureFiles = FirebaseStorage.instance.ref('files/').listAll();
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
    futureFiles = FirebaseStorage.instance.ref('files/').listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.share,
          size: 30.0,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        title: const Text(
          'File Share',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
          child: FutureBuilder<ListResult>(
            future: futureFiles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final files = snapshot.data!.items;
                return ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      double? progress = downloadProgress[index];
                      return ListTile(
                        title: Text(file.name),
                        subtitle: progress != null
                            ? LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.black,
                              )
                            : null,
                        trailing: IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () => dowloadFile(index, file),
                        ),
                      );
                    });
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("error"),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          onRefresh: onRefresh),
      floatingActionButton: uploadFileButton(),
    );
  }

  Widget uploadFileButton() => FloatingActionButton(
      child: const Icon(Icons.upload),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UploadScreen()));
      });

  Future dowloadFile(int index, Reference ref) async {
    final dir = await getExternalStorageDirectory();
    final path = '${dir!.path}/Downloads/${ref.name}';

    final url = await ref.getDownloadURL();
    await Dio().download(url, path, onReceiveProgress: (count, total) {
      double progress = count / total;
      setState(() {
        downloadProgress[index] = progress;
      });
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Downloaded ${ref.name}')));
  }
}

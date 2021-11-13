import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: StreamPage(),
  ));
}

class StreamPage extends StatefulWidget {
  const StreamPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  // Bir stream oluşturabilmek için StreamControllerımımızı tanımlıyoruz.
  late final StreamController<String> _streamController;

  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    // StreamControllerımızı initiliaze ediyoruz.
    _streamController = StreamController<String>();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // İşimiz bittiğinde kapatmayı unutmayalım!
    _streamController.close();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<String>(
                // Başlangıç değerini atıyoruz.
                initialData:
                    'Merhaba bu alan TextFormField\'da değişiklik olduğunda değişecektir.',
                // Oluşturduğumuz StreamController üzerinden bir stream açıyoruz.
                stream: _streamController.stream,
                // Değişiklik olduğunda builder içerisinde ki widget build olacaktır.
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return Text(snapshot.data ?? '');
                }),
            TextFormField(
              controller: _textEditingController,
              onChanged: (val) {
                // Değişikliklerini stream'a bildiriyoruz.
                _streamController.sink.add(val);
              },
            ),
          ],
        ),
      ),
    );
  }
}

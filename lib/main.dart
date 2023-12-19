import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stream Builder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Stream Builder Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Body()],
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Body> {
  StreamController<String> streamController = StreamController<String>();
  String mensagem = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamForm,
      builder: (BuildContext ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Erro ao carregar o Stream');
        } else {
          return Text(snapshot.data.toString());
        }
      },
    );
  }

  @override
  initState() {
    super.initState();

    loading = true;
    //era pra ser exibido isso
    streamController.sink.add('Rodando...');
  }

  Stream<String> get streamForm {
    //mas através do map eh possível mudar o valor
    return streamController.stream.asyncMap(
      (event) async {
        await Future.delayed(
          const Duration(
            seconds: 5,
          ),
        );
        try {
          return 'Funcionou';
        } catch (error) {
          throw 'erro';
        }
      },
    );
  }

  @override
  dispose() {
    streamController.close();
    super.dispose();
  }
}

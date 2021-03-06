import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List listA = [Colors.green, 'A', Colors.black, Colors.brown];
  List listB = [];
  List listBRow = [];
  List listText = ['A', 'B', 'C', 'D'];
  List text = [];
  List textRow = [];
  List target = [Colors.black45];

  late int i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: listA.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.35, crossAxisCount: 4),
                itemBuilder: (BuildContext context, index) {
                  return Draggable<Color>(
                    data: listA[index] == 'A' ? Colors.white : listA[index],
                    feedback: Container(
                      padding: listA[index] == Colors.black
                          ? const EdgeInsets.all(8)
                          : listA[index] == Colors.brown
                              ? const EdgeInsets.all(8)
                              : const EdgeInsets.all(0),
                      height: 120,
                      width: 120,
                      color: listA[index] == 'A' ? Colors.white : listA[index],
                      child: listA[index] == Colors.black
                          ? Container(
                              height: 40,
                              width: 100,
                              color: Colors.white,
                              child: const Center(child: Text('Column')),
                            )
                          : listA[index] == Colors.brown
                              ? Container(
                                  height: 40,
                                  width: 100,
                                  color: Colors.white,
                                  child: const Center(child: Text('row')),
                                )
                              : listA[index] == 'A'
                                  ? Center(child: Text('A'))
                                  : null,
                    ),
                    child: Container(
                      padding: listA[index] == Colors.black
                          ? const EdgeInsets.all(8)
                          : listA[index] == Colors.brown
                              ? const EdgeInsets.all(8)
                              : const EdgeInsets.all(0),
                      height: 120,
                      width: 120,
                      color: listA[index] == 'A' ? Colors.white : listA[index],
                      child: listA[index] == Colors.black
                          ? Container(
                              height: 40,
                              width: 100,
                              color: Colors.white,
                              child: const Center(child: Text('Column')),
                            )
                          : listA[index] == Colors.brown
                              ? Container(
                                  height: 40,
                                  width: 100,
                                  color: Colors.white,
                                  child: const Center(child: Text('row')),
                                )
                              : listA[index] == 'A'
                                  ? Center(child: Text('A'))
                                  : null,
                    ),
                  );
                }),
          ),
          Expanded(
              flex: 3,
              child: DragTarget(
                builder: (context, candidates, rejects) {
                  print('$candidates $target');

                  return Stack(
                    children: [
                      target.contains(Colors.green) == true
                          ? Container(
                              height: 100,
                              width: 100,
                              color: Colors.green,
                            )
                          : target.contains(Colors.white) == true
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  child: Center(child: Text('A')),
                                )
                              : target.contains(Colors.black) == true
                                  ? targetColumn()
                                  : target.contains(Colors.brown) == true
                                      ? targetRow()
                                      : Container(
                                          height: 100,
                                          child: Text('Drag here'),
                                        ),
                      if (candidates.isNotEmpty)
                        Container(
                          color: Color(int.parse('0xff3aa9f78f')),
                          height: 100,
                        )
                    ],
                  );
                },
                onAccept: (value) {
                  print(value);
                  setState(() {
                    target[0] = value;
                  });
                },
              ))
        ],
      ),
    );
  }

  DragTarget<Object> targetColumn() {
    return DragTarget(
      builder: (context, candidates, rejects) {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listB.isEmpty ? 1 : listB.length,
                itemBuilder: (BuildContext context, int index) {
                  i = index;
                  return listB.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: Text('Drag here')),
                        )
                      : listB[index] == Colors.brown
                          ? SizedBox(height: 100, child: targetRow())
                          : DragTarget(
                              builder: (context, accept, rejects) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: listB[index] == 'A'
                                        ? Colors.white
                                        : listB[index],
                                    child: text.isEmpty
                                        ? const Text('')
                                        : Center(child: Text(text[index])),
                                    height: 70,
                                  ),
                                );
                              },
                              onAccept: (value) {
                                setState(() {});
                              },
                            );
                },
              ),
            ),
            if (candidates.isNotEmpty)
              Container(
                color: Color(int.parse('0xff3aa9f78f')),
                height: MediaQuery.of(context).size.shortestSide,
              )
          ],
        );
      },
      onAccept: (value) {
        print('value: $value');
        setState(() {
          listB.add(value);
          value == Colors.white ? text.add('A') : text.add('');
        });
      },
    );
  }

  DragTarget<Object> targetRow() {
    return DragTarget(
      builder: (context, candidates, rejects) {
        return Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: listBRow.isEmpty ? 1 : listBRow.length,
                itemBuilder: (BuildContext context, int index) {
                  print(listBRow);

                  i = index;
                  return listBRow.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: Text('Drag here')),
                        )
                      : listBRow[index] == Colors.black
                          ? SizedBox(width: 100, child: targetColumn())
                          : DragTarget(
                              builder: (context, accept, rejects) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: listBRow[index] == 'A'
                                        ? Colors.white
                                        : listBRow[index],
                                    child: textRow.isEmpty
                                        ? const Text('')
                                        : Center(child: Text(textRow[index])),
                                    height: 30,
                                    width: 100,
                                  ),
                                );
                              },
                              onAccept: (value) {
                                setState(() {});
                              },
                            );
                },
              ),
            ),
            if (candidates.isNotEmpty)
              Container(
                color: Color(int.parse('0xff3aa9f78f')),
                height: MediaQuery.of(context).size.height,
              )
          ],
        );
      },
      onAccept: (value) {
        setState(() {
          listBRow.add(value);
          value == Colors.white ? textRow.add('A') : textRow.add('');
        });
      },
    );
  }
}

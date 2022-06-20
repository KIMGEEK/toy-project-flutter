import 'package:flutter/material.dart';

class WidgetApp extends StatefulWidget {
  const WidgetApp({Key? key}) : super(key: key);

  @override
  State<WidgetApp> createState() => _WidgetAppState();
}

class _WidgetAppState extends State<WidgetApp> {
  String result = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  final List _buttonList = ['Add', 'Subtract', 'Multiply', 'Divide'];
  final List<DropdownMenuItem<String>> _dropDownMenuItems =
      new List.empty(growable: true);
  String? _buttonText;

  void initState() {
    super.initState();
    for (var item in _buttonList) {
      _dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Result : $result',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: value1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: value2,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text(_buttonText!),
                        ],
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber)),
                      onPressed: () {
                        setState(() {
                          var value1Int = double.parse(value1.value.text);
                          var value2Int = double.parse(value2.value.text);
                          var res;
                          if (_buttonText == 'Add') {
                            res = value1Int + value2Int;
                          } else if (_buttonText == 'Subtract') {
                            res = value1Int - value2Int;
                          } else if (_buttonText == 'Multiply') {
                            res = value1Int * value2Int;
                          } else if (_buttonText == 'Divide') {
                            res = value1Int / value2Int;
                          }
                          result = '$res';
                        });
                      })),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: DropdownButton(
                    items: _dropDownMenuItems,
                    onChanged: (String? value) {
                      setState(() {
                        _buttonText = value;
                      });
                    },
                    value: _buttonText,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

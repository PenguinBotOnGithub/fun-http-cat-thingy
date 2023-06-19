import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CatsPage extends StatefulWidget {
  const CatsPage({super.key});

  @override
  State<CatsPage> createState() => _CatsPageState();
}

class _CatsPageState extends State<CatsPage> {
  _CatsPageState() {
    textController.text = '100';
  }
  
  final textController = TextEditingController();
  String _imageUrl = 'https://http.cat/images/100.jpg';
  final _focusNode = FocusNode();
  final _statusCode = <int>[
    100,
    101,
    102,
    103,
    200,
    201,
    202,
    203,
    204,
    206,
    207,
    300,
    301,
    302,
    303,
    304,
    305,
    307,
    308,
    400,
    401,
    402,
    403,
    404,
    405,
    406,
    407,
    408,
    409,
    410,
    411,
    412,
    413,
    414,
    415,
    416,
    417,
    418,
    420,
    421,
    422,
    423,
    424,
    425,
    426,
    429,
    431,
    444,
    450,
    451,
    497,
    498,
    499,
    500,
    501,
    502,
    503,
    504,
    506,
    507,
    508,
    509,
    510,
    511,
    521,
    522,
    523,
    525,
    599
  ];
  
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
  
  int num = 100;
  
  void _onEditDone() {
    setState(() {
      if (textController.text.isEmpty) return;
      num = int.parse(textController.text);
      _setStatusCode(num);
    });
  }
  
  void _onAddButtonPressed() {
    if (textController.text.isNotEmpty) {
      setState(() {
        num = int.parse(textController.text);
        _addStatusCode(num);
      });   
    } 
  }
  
  void _onSubstractButtonPressed() {
    if (textController.text.isNotEmpty) {
      setState(() {
        num = int.parse(textController.text);
        _subtractStatusCode(num);
      });   
    }
  }
  
  void _setStatusCode(int num) {
    if(_statusCode.contains(num)) {
      setState(() {
        _imageUrl = 'https://http.cat/images/$num.jpg';
      });
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('There is no cat for http status code $num')));
    }
    
  }
  
  void _addStatusCode(int num) {
    int index = 0;
    for (int code = 0; code < _statusCode.length; code++) {
      if (_statusCode.elementAt(code) > num) {
        index = code;
        break;
      }
    }
    
    setState(() {
      int code = _statusCode.elementAt(index);
      _imageUrl = 'https://http.cat/images/$code.jpg';
      textController.text = '$code';
    });
  }
  
  void _subtractStatusCode(int num) {
    int index = 0;
    for (int code = 0; code < _statusCode.length; code++) {
      if (_statusCode.elementAt(code) >= num) {
        index = code - 1;
        break;
      }
    }
    
    if (index < 0) index = _statusCode.length - 1;
    
    setState(() {
      int code = _statusCode.elementAt(index);
      _imageUrl = 'https://http.cat/images/$code.jpg';
      textController.text = '$code';
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInImage.memoryNetwork(
            imageErrorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return const SizedBox(
                height: 240,
                child: Center(
                  child: Text('Something went wrong while loading the image :('),
                ),
              );
            },
            image: _imageUrl,
            placeholder: kTransparentImage,
            width: 300,
            height: 240,
            key: ValueKey('https://http.cat/images/$_imageUrl.jpg'),
          ),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _onSubstractButtonPressed, child: const Icon(Icons.remove)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: 60,
                child: TextFieldTapRegion(
                  onTapOutside:(event) => _focusNode.unfocus(),
                  child: TextField(
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Theme.of(context).focusColor
                        )
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent
                        )
                      )
                    ),
                    textAlign: TextAlign.center,
                    onEditingComplete: _onEditDone,
                    controller: textController,
                    keyboardType: TextInputType.number,
                    ),
                ),
              ),
              ElevatedButton(onPressed: _onAddButtonPressed, child: const Icon(Icons.add)),
            ],
          )
        ],
      ),
    );
  }
}
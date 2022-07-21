import 'package:flutter/material.dart';
import 'package:untitled/widget_text.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
 final TextEditingController _controller = TextEditingController();
  List inputTextRow1 = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"];
  List inputNumberRow1 = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  List inputSpCharRow1 = [];
  List inputTextRow2 = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'];
  List inputNumberRow2 = ['\u{20B9}','@', '#', '_', '&', '-', '+', '(',')', '/'];
 List inputSpCharRow2 = [];
  List inputTextRow3 = ['','z', 'x', 'c', 'v', 'b', 'n', 'm',''];
  List inputNumberRow3 = ['','*', '"', "'", ':', ';', '!', '?', '',];
 List inputSpCharRow3 = [];
 // String insertedText = "";
  late bool isCaps;
  late bool isSpecialChar;
  @override
  void initState() {
    isCaps = false;
    isSpecialChar = false;
    super.initState();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  double keyHeight = 0.0;
  void _insertText(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }
  // back space method
  void _backspace() {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end - textSelection.start;
    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }
    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }
    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }
  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextField(
                autofocus: true,
                  controller: _controller,
                  showCursor: true,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText:_controller.text.toString(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:const BorderSide(color: Colors.green,width: 2)
                    )
                  ),
                ),
              ),

             const SizedBox(height: 20,),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics:const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: isSpecialChar
                                ? inputNumberRow1.length
                                : inputTextRow1.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    isSpecialChar
                                        ? _insertText(inputNumberRow1[index])
                                        : isCaps
                                        ? _insertText(inputTextRow1[index]
                                        .toUpperCase())
                                        : _insertText(inputTextRow1[index]);
                                  });
                                },
                                child: TextWidget(
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    width: MediaQuery.of(context).size.width * 0.095,
                                    text: isSpecialChar
                                        ? inputNumberRow1[index]
                                        : isCaps
                                            ? inputTextRow1[index].toUpperCase()
                                            : inputTextRow1[index]),
                              );
                            },
                          ),
                        )),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: isSpecialChar
                                ? inputNumberRow2.length
                                : inputTextRow2.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    isSpecialChar
                                        ? _insertText(inputNumberRow2[index])
                                        : isCaps
                                        ? _insertText(inputTextRow2[index]
                                        .toUpperCase())
                                        : _insertText(inputTextRow2[index]);
                                  });
                                },
                                child: TextWidget(

                                    height: MediaQuery.of(context).size.height * 0.07,
                                    width: MediaQuery.of(context).size.width * 0.095,



                                    text: isSpecialChar
                                        ? inputNumberRow2[index]
                                        : isCaps
                                            ? inputTextRow2[index]
                                                .toUpperCase()
                                            : inputTextRow2[index]),
                              );
                            },
                          ),
                        )),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: ListView.builder(
                            physics:const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: isSpecialChar
                                ? inputNumberRow3.length
                                : inputTextRow3.length,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  width: MediaQuery.of(context).size.width * 0.14,
                                  margin: const EdgeInsets.only(right: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isCaps = !isCaps;
                                        });
                                      },
                                      icon: isSpecialChar? const Icon(Icons.menu,color: Colors.white,):const Icon(Icons.arrow_upward,color:Colors.white)),
                                );
                              } else if (index == inputTextRow3.length-1)  {
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  width: MediaQuery.of(context).size.width * 0.14,
                                  margin: const EdgeInsets.only(left: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8)
                                  ),

                                  child: IconButton(
                                      onPressed: () {
                                        if(_controller.text.isNotEmpty) {
                                          setState(() {
                                            _backspace();
                                          });
                                        }else{
                                          setState((){});
                                        }

                                      },
                                      icon: const Icon(Icons.backspace,color: Colors.white,)),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSpecialChar
                                                  ? _insertText(inputNumberRow3[index])
                                                  : isCaps
                                                      ? _insertText(inputTextRow3[index]
                                                          .toUpperCase())
                                                      : _insertText(inputTextRow3[index]);
                                    });
                                  },
                                  child: TextWidget(
                                      height: MediaQuery.of(context).size.height * 0.07,
                                      width: MediaQuery.of(context).size.width * 0.095,

                                      text: isSpecialChar
                                          ? inputNumberRow3[index]
                                          : isCaps
                                              ? inputTextRow3[index].toUpperCase()
                                              : inputTextRow3[index]),
                                );
                              }
                            },
                          ),
                        )),
                  ],
                ),
              ),

              Row(
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          isSpecialChar = !isSpecialChar;
                        });
                      },
                      child:  TextWidget(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.14,
                          text:!isSpecialChar?'123?':'abc')),
                   Expanded(
                      child: InkWell(
                         onTap: (){
                          setState((){
                           _insertText(" ");
                          });
                         },
                          child: TextWidget(height: MediaQuery.of(context).size.height * 0.07, width: MediaQuery.of(context).size.width * 0.2, text: " "))),

                  const SizedBox(width: 2,),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.14,

                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: IconButton(
                          onPressed: () {}, icon:const Icon(Icons.keyboard_return,color: Colors.white,)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

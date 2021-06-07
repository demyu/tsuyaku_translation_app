import 'package:flutter/material.dart';
import 'package:translate/languages.dart';
import 'package:translate/translateapi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tsuyaku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tsuyaku Translation App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropDownValue1 = 'English';
  TextEditingController textController1 = TextEditingController();
  late String dropDownValue2 = 'English';
  late TextEditingController resultController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> languages = [];
  List<String> langAbr = [];

  //Translation class
  translateApi transApi = translateApi();
  Languages lang = Languages();

  List<String> dropdownLangWord = [];

  void setup(){
    dropdownLangWord = lang.getLang();
  }

  void translateButtonAction() async{
    String from = lang.getAbr(dropDownValue1) ;
    String to = lang.getAbr(dropDownValue2);
    String inp = textController1.text;

    try{
      var q = await transApi.get(query: {"source":from,"target":to,"input":inp});
    
      setState(() {
        resultController.text = q['outputs'][0]["output"];
      });
    }on Exception catch(_){
      setState(() {
        resultController.text = textController1.text;
      });
    }
    
  }

  @override
  void dispose(){
    textController1.dispose();
    resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setup();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC65C),
        automaticallyImplyLeading: true,
        leading: Image.asset(
          'assets/images/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        title: Text(
          'Tsūyaku ',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFECECEC),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Align(
            alignment: Alignment(-0.4, -0.25),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              child: Stack(
                alignment: Alignment(-1, -1),
                children: [
                  Align(
                    alignment: Alignment(0, 0),
                    child: DefaultTabController(
                      length: 1,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Color(0xFF42C8B7),
                            tabs: [
                              Tab(
                                text: 'Home',
                                icon: Icon(
                                  Icons.home_filled,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0, -0.9),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'From:',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          DropdownButton<String>(
                                            value: dropDownValue1,
                                            icon: const Icon(Icons.arrow_downward),
                                            iconSize: 24,
                                            elevation: 16,
                                            style: const TextStyle(color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropDownValue1 = newValue!;
                                              });
                                            },
                                            items: dropdownLangWord.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0, -0.60),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: textController1,
                                              maxLines: 2,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: 'Enter word',
                                                hintStyle: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
                                                  ),
                                                ),
                                                filled: true,
                                              ),
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0, -0.20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'To:',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          DropdownButton<String>(
                                            value: dropDownValue2,
                                            icon: const Icon(Icons.arrow_downward),
                                            iconSize: 24,
                                            elevation: 16,
                                            style: const TextStyle(color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropDownValue2 = newValue!;
                                              });
                                            },
                                            items: dropdownLangWord
                                                .map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0, 0.1),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              enabled: false,
                                              controller: resultController,
                                              maxLines: 2,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: 'Translated word',
                                                hintStyle: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
                                                  ),
                                                ),
                                                filled: true,
                                              ),
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.8, 0.45),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          translateButtonAction();
                                        },
                                        child: const Text('Translate'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

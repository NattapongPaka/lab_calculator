import 'package:calculator/src/data/cal_service.dart';
import 'package:calculator/src/utils/index.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _calService = CalService();

  _buildTextEditer({String value}) {
    Size screen = MediaQuery.of(context).size;

    double buttonSize = screen.width / 4;
    double displayHeight = screen.height - (buttonSize * 5) - (buttonSize);

    final LinearGradient _gradient =
        const LinearGradient(colors: [Colors.black26, Colors.black45]);

    //String _output = value.toString();
    double _margin = (displayHeight / 10);
    double height = displayHeight;

    final _style = Theme.of(context)
        .textTheme
        .headline3
        .copyWith(color: Colors.white, fontWeight: FontWeight.w200);

    return Container(
      padding: EdgeInsets.only(top: _margin, bottom: _margin),
      constraints: BoxConstraints.expand(height: height),
      child: Container(
        padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
        constraints: BoxConstraints.expand(height: height - (_margin)),
        decoration: BoxDecoration(gradient: _gradient),
        child: Text(
          value,
          style: _style,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  _buildRowNumPad({List<NumPadKey> numRow}) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: numRow.map((NumPadKey e) {
          return Container(
            height: MediaQuery.of(context).size.width / 4,
            width: MediaQuery.of(context).size.width / 4,
            padding: EdgeInsets.all(2),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.grey[500],
              ),
              onPressed: () {
                //debugPrint(e.value);
                _calService.handle(value: e);
              },
              child: e == Keys.unused ? Text("") : Text(e.value),
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildNumPad() {
    return Column(
      children:
          NumPad.numPad.map<Widget>((e) => _buildRowNumPad(numRow: e)).toList(),
    );
  }

  @override
  void dispose() {
    _calService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<String>(
                stream: _calService.streamValue,
                builder: (context, snapshot) {
                  debugPrint(snapshot.connectionState.toString());
                  if (snapshot.connectionState == ConnectionState.active) {
                    String result = snapshot.data;
                    return _buildTextEditer(value: result);
                  } else {
                    return _buildTextEditer(value: "0");
                  }
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: _buildNumPad(),
            ),
          ],
        ),
      ),
    );
  }
}

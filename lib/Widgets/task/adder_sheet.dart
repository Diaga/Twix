import 'package:flutter/material.dart';

class AdderSheet extends StatefulWidget {
  final IconData iconData;
  final String text;

  AdderSheet({this.iconData , this.text});

  @override
  _AdderSheetState createState() => _AdderSheetState();
}

class _AdderSheetState extends State<AdderSheet> {
  String fieldData;
  @override
  Widget build(BuildContext context) {
    return  AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: Duration(milliseconds: 100),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Icon(widget.iconData)
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8, bottom: 8, right: 5),
                      child: TextField(
                        expands: true,
                        decoration: InputDecoration(
                          hintText: '${widget.text} name',
                          border: InputBorder.none,
                        ),
                        onChanged: (value){
                          fieldData = value;
                        },
                        autofocus: true,
                        maxLines: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(alignment:Alignment.centerRight,child: FlatButton(onPressed: (){}, child: Text('Done')))
          ],
        ),
      ),
    );
  }
}

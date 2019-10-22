import 'package:flutter/material.dart';
import 'package:twix/Database/database.dart';
import 'package:twix/Screens/task_screen.dart';
import 'package:twix/Widgets/board_list.dart';

class BuildBoardCard extends StatefulWidget {
  final BoardTableData boardItem;

  BuildBoardCard({this.boardItem});

  @override
  _BuildBoardCardState createState() => _BuildBoardCardState();
}

class _BuildBoardCardState extends State<BuildBoardCard> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    _animation = CurvedAnimation(parent: _animationController,curve: Curves.ease);
    _animationController.forward();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: BoardsList(
          iconData: Icons.developer_board,
          title: widget.boardItem.name,
          callBack: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskScreen(
                  boardId: widget.boardItem.id,
                ),
              ),
            );
          }),
    );
    ;
  }
}

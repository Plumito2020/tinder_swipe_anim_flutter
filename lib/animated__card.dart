import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import './user.dart';
import 'package:provider/provider.dart';
import './users_provider.dart';

class AnimatedCard extends StatefulWidget {
  final User user;

  AnimatedCard(this.user);

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

enum direction { left, right }

class _AnimatedCardState extends State<AnimatedCard>
    with TickerProviderStateMixin {
  AnimationController animControllerRight;
  AnimationController animControllerLeft;
  Animation<double> slideAnimR, rotateAnimR, slideAnimL, rotateAnimL;
  var dir;
  double width;
  double startDragDetails;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;

//-------Controllers---------------------
    animControllerRight = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Provider.of<Users>(context, listen: false)
              .deleteFromStack(widget.user.id);
          print(Provider.of<Users>(context, listen: false).users.toString());
        }
      });

    animControllerLeft = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Provider.of<Users>(context, listen: false)
              .deleteFromStack(widget.user.id);
        }
      });

    final curvedAnimationR = CurvedAnimation(
      parent: animControllerRight,
      curve: Curves.easeOut,
    );

    final curvedAnimationL = CurvedAnimation(
      parent: animControllerLeft,
      curve: Curves.easeOut,
    );
//------------- Right ----------------------
    slideAnimR = Tween<double>(
      begin: 0,
      end: width,
    ).animate(curvedAnimationR)
      ..addListener(() {
        setState(() {});
      });

    rotateAnimR = Tween<double>(
      begin: 0,
      end: -0.3,
    ).animate(curvedAnimationR)
      ..addListener(() {
        setState(() {});
      });

//------------- Left ----------------------
    slideAnimL = Tween<double>(
      begin: 0,
      end: -width,
    ).animate(curvedAnimationL)
      ..addListener(() {
        setState(() {});
      });

    rotateAnimL = Tween<double>(
      begin: 0,
      end: 0.3,
    ).animate(curvedAnimationL)
      ..addListener(() {
        setState(() {});
      });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: dir == direction.right ? rotateAnimR.value : rotateAnimL.value,
      child: Center(
          child: GestureDetector(
        onHorizontalDragStart: (dragDetails) {
          startDragDetails = dragDetails.localPosition.dx;
          print('Start');
        },
        onHorizontalDragUpdate: (dragDetails) {
          if (dragDetails.localPosition.dx - startDragDetails > 0) {
            dir = direction.right;
            animControllerRight.forward();
          } else {
            dir = direction.left;
            animControllerLeft.forward();
          }

          print(dragDetails.localPosition);
        },
        onHorizontalDragEnd: (dragDetails) {
          print('Ended');
        },
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed("/profile", arguments: widget.user);
          },
          child: Container(
            key: Key(widget.user.id),
            padding: EdgeInsets.all(8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 270,
                    child: Hero(
                      tag: widget.user.id,
                      child: ClipRRect(
                        child: Image.network(
                          "https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-4-300x300.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.user.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.user.bio,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            height: 400,
            width: 400,
            transform: dir == direction.right
                ? Matrix4.translationValues(slideAnimR.value, 0, 0)
                : Matrix4.translationValues(slideAnimL.value, 0, 0),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    animControllerRight.dispose();
    animControllerLeft.dispose();
    super.dispose();
  }
}

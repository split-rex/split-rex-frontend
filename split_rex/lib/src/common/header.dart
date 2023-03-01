import 'package:flutter/material.dart';

Widget header(BuildContext context, String pagename, Widget widget) =>
  Container(
    color: const Color(0XFFFFFFFF),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 35.0, bottom: 10.0, left: 5.0, right: 5.0),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                const Positioned(child: Icon(Icons.navigate_before, color: Color(0XFF4F4F4F), size: 35)),
                  Container(
                    width: MediaQuery.of(context).size.width - 10.0,
                    alignment: Alignment.center,
                    child: Text(
                      pagename, 
                      style: const TextStyle(
                        color: Color(0XFF4F4F4F),
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                      ),
                    ),
                  )
                ],
              )
            ),
          ], 
        ),
        Expanded(child: 
          Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: 
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0XFFE0F2F1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: widget
              )
            )
          ])
        )
      ],
    )
  );

import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child:
          Image.network(
            height: 48, 
            width: 48, 
            fit: BoxFit.cover,
            "https://st3.depositphotos.com/6672868/13701/v/600/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"
          ),
        ),
        const SizedBox(
          width: 12
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text (
              "Welcome back,",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              "Valentino",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: Colors.white,
              ),
            )
          ]
        ),
      ],
    );
  }
}

class FriendRequest extends StatelessWidget {
  const FriendRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Color(0X25FFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 7, 
            child: Row(children: [
              const Icon(
                Icons.group,
                color: Colors.white,
              ),
              const SizedBox(
                width: 8.0
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400
                  ), 
                  children: [
                    TextSpan(text: "You have "),
                    TextSpan(text: "3", style: TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(text: " friend requests!"),
                  ]
                ),
              ),
            ],)
          ),
          const Expanded(
            flex: 3,
            child: 
            Text(
              "Review",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              )
            )
          )
        ]
      ) 
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF59C4B0),
            Color(0XFF43A7B7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),
      padding: const EdgeInsets.only(top: 72.0, right: 28.0, left: 28.0, bottom: 40.0),
      child: 
      Column(
        children: const [
          UserDetail(),
          SizedBox(
            height: 16
          ),
          FriendRequest()
        ]
      )
    );
  }
}

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0XFFE0F2F1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 55.0, left: 28.0, right: 28.0),
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0XFFF9F7F7),
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(children: [
              Expanded(
                flex: 5,
                child: Container(
                  // color: Colors.white,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0XFF4F4F4F).withOpacity(0.1),
                        spreadRadius: 0.0,
                        blurRadius: 5.0,
                        offset: Offset.zero
                      ),
                    ],
                  ),
                  child: const Text(
                    "Owed",
                    style: TextStyle(
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  // color: Colors.white,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    // color: Colors.white,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Color(0XFF4F4F4F).withOpacity(0.1),
                    //     spreadRadius: 0.0,
                    //     blurRadius: 5.0,
                    //     offset: Offset.zero
                    //   ),
                    // ],
                  ),
                  child: const Text(
                    "Lent",
                    style: TextStyle(
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
            ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.centerLeft,
              child: Row(children: [
                Expanded(
                  flex: 9, 
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 246, 246, 246),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical:12.0, horizontal: 24.0),
                    child: const Text(
                      "Search bar...",
                    ),
                  )
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 16.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 246, 246, 246),
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(Icons.filter_alt, color: Colors.grey)
                  )
                ),
              ],)
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text(
                      "Singapore Trip",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      "03 Feb 2023 / 15.40",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0XFF4f4f4f),
                          fontWeight: FontWeight.w400
                        ), 
                        children: [
                          TextSpan(text: "You owe "),
                          TextSpan(
                            text: "Rp 32.500", 
                            style: TextStyle(
                                color: Color(0XFFF10D0D),
                                fontWeight: FontWeight.w800,
                              )
                          ),
                          TextSpan(text: " in total"),
                        ]
                      ),
                    ),
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "Rp 52.500",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      Icon(Icons.fire_extinguisher)
                  ]),
                ]
              )
            )
          ],
        ),
      )
    );
  }
}


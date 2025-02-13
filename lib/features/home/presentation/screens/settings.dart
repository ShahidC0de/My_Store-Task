import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              height: 90,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 35,
                          child: Icon(
                            Icons.add_ic_call_outlined,
                            size: 35,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'shahidzada.cs@gmail.com',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '+923433980997',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 9,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                                children: List.generate(5, (index) {
                              return const Icon(
                                Icons.star,
                                size: 10,
                              );
                            }))
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.favorite_border_outlined),
                ],
              )),
          const SizedBox(
            height: 40,
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => SelectedCategory()));
                    },
                    leading: Image.asset(
                      'assets/settings_icons/settings.png',
                      scale: 2,
                    ),
                    title: Text('Settings'),
                  ),
                  ListTile(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ProductView()));
                    },
                    leading: Image.asset(
                      'assets/settings_icons/profile_card.png',
                      scale: 2,
                    ),
                    title: Text('Mina betalmetador'),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/settings_icons/support.png',
                      scale: 2,
                    ),
                    title: Text('Support'),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

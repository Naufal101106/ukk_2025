import 'package:flutter/material.dart';
import 'package:ukk_2025/Login.dart';
import 'package:ukk_2025/Penjualan/DetailPenjualan.dart';
import 'package:ukk_2025/Pelanggan/Pelanggan.dart';
import 'package:ukk_2025/Penjualan/Penjualan.dart';
import 'package:ukk_2025/Produk/Produk.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
          //     appBar: AppBar(
          //     flexibleSpace: Container(
          //     padding: EdgeInsets.only(top: 40),
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(colors: [
          //         Color.fromARGB(205, 2, 89, 129),
          //         Color.fromARGB(255, 12, 135, 192),
          //         Color.fromARGB(255, 3, 186, 247)
          //       ], begin: Alignment.topLeft, end: Alignment.topRight),
          //     ),
          //   ),
          //   leading: Builder(
          //     builder: (context) {
          //       return IconButton(
          //         icon: Icon(
          //           Icons.menu,
          //           color: Colors.white,
          //         ),
          //         onPressed: () {
          //           Scaffold.of(context).openDrawer();
          //         },
          //       );
          //     },
          //   ),

          // ),

          floatingActionButton: Stack(
            children: [
              Positioned(
                child: Builder(
                  builder: (context) {
                      return IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                ),
                top: 20,
                left: 20,
              )
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(205, 2, 89, 129),
                        Color.fromARGB(255, 12, 135, 192),
                        Color.fromARGB(255, 3, 186, 247)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight 
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 40, color: Colors.black,),
                      ),

                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),

                // ListTile(
                //   leading: Icon(Icons.home),
                //   title: Text('Home'),
                //   onTap: () {
                //     Navigator.pop(context);
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('Home selected')),
                //     );
                //   },
                // ),

                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.push(
                      context, 
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                )
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  Color.fromARGB(205, 2, 89, 129),
                  Color.fromARGB(255, 12, 135, 192),
                  Color.fromARGB(255, 3, 186, 247)
                ] 
                ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children:[
                      Produk(),
                      Pelanggan(),
                      Penjualan(),
                      DetailPenjualan()
                    ] 
                    ),
                ),

                TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  tabs: [
                    Tab(icon: Icon(Icons.shopping_bag),text: 'Produk',),
                    Tab(icon: Icon(Icons.person_2_sharp),text: 'Pelanggan',),
                    Tab(icon: Icon(Icons.shopping_cart),text: 'Penjualan',),
                    Tab(icon: Icon(Icons.drafts),text: 'Detail Penjualan',),
                  ]
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class Penjualan extends StatefulWidget {
//   const Penjualan({super.key});

//   @override
//   State<Penjualan> createState() => _PenjualanState();
// }

// class _PenjualanState extends State<Penjualan> {
//   final supabase = Supabase.instance.client;
//   List<Map<String, dynamic>> produkList = [];
//   int totalHarga = 0;
//   int produkId = 0;
//   int jumlah = 1;
//   int pellangganID = 1;
//   final _jumlahController = TextEditingController();


//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final response = await supabase.from('produk').select('*');
//     if (response.error == null) {
      
//     }

//   }




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(18),
//             child: Column(),
//           )
//         ],
//       ),
//     );
//   }
// }
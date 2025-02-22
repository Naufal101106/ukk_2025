// import 'package:flutter/cupertino.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class Cariproduk extends StatefulWidget {
//   const Cariproduk({super.key});

//   @override
//   State<Cariproduk> createState() => _CariprodukState();
// }

// class _CariprodukState extends State<Cariproduk> {
//   final SupabaseClient supabase = Supabase.instance.client;
//   List<dynamic> _pelangganlist = [];
//   List<dynamic> _filterpelangganlist = [];
//   List<Map<String<

//   @override
//   void initstate() {
//     super.initState();
//     _fetchPelanggan();
//   }

//   Future<void> _fetchPelanggan() async{
//     final response = await supabase.from('produk').select();
//     if (response.error == null) {
//       setState(() {
//         _pelangganlist = response.data;
//         _filterpelangganlist = _pelangganlist;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
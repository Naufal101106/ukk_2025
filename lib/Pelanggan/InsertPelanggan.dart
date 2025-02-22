import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_2025/Beranda.dart';

class Insertpelanggan extends StatefulWidget {
  const Insertpelanggan({super.key});

  @override
  State<Insertpelanggan> createState() => _InsertpelangganState();
}

class _InsertpelangganState extends State<Insertpelanggan> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _namapelangganController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nomorteleponController = TextEditingController();

  Future<void>_addProduk() async{
    if (_formkey.currentState!.validate()) {
      final namapelanggan = _namapelangganController.text;
      final alamat = _alamatController.text;
      final nomortelepon = _nomorteleponController.text;

      if(namapelanggan.isEmpty || alamat.isEmpty || nomortelepon.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Semua Wajib DIisi'))
        );
        return;
      }

      final response = await Supabase.instance.client.from('pelanggan').insert({
        'NamaPelanggan' : namapelanggan,
        'Alamat' : alamat,
        'NomorTelepon' : nomortelepon,
      });

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.error!.massage}'))
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pelanggan Berhasil Ditambahkan',
              style: TextStyle(color: Colors.white), 
            ),
            backgroundColor: Colors.black, 
          )
        );

        _namapelangganController.clear();
        _alamatController.clear();
        _nomorteleponController.clear();

        Navigator.pushReplacement(
          context, 
            MaterialPageRoute(builder: (context) => const Beranda()));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pelanggan'),
      ),

       body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
             children: [
              TextFormField(
                controller: _namapelangganController,
                decoration: InputDecoration( labelText: 'Nama Pelanggan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Nama Pelanggan!';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration( labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Alamat!';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _nomorteleponController,
                decoration: InputDecoration( labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                  return 'Masukan Nomor Telepon!';
                  }
                  return null;
                },
              ),

              SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _addProduk();
                  }
                }, 
                child: Text('Tambah'))
             ], 
          ),
        ),
      ),
    );
  }
}
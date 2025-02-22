import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_2025/Beranda.dart';

class Insert extends StatefulWidget {
  const Insert({super.key});

  @override
  State<Insert> createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _namaprodukController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  Future<void>_addProduk() async{
    if (_formkey.currentState!.validate()) {
      final namaproduk = _namaprodukController.text;
      final harga = _hargaController.text;
      final stok = _stokController.text;

      if(namaproduk.isEmpty || harga.isEmpty || stok.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Semua Wajib DIisi'))
        );
        return;
      }

      final response = await Supabase.instance.client.from('produk').insert({
        'NamaProduk' : namaproduk,
        'Harga' : harga,
        'Stok' : stok,
      });

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.error!.massage}'))
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produk Berhasil Ditambahkan',
              style: TextStyle(color: Colors.white), 
            ),
            backgroundColor: Colors.black, 
          )
        );

        _namaprodukController.clear();
        _hargaController.clear();
        _stokController.clear();

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
        title: Text('Tambah Produk'),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
             children: [
              TextFormField(
                controller: _namaprodukController,
                decoration: InputDecoration( labelText: 'Nama Produk'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Nama Produk!';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _hargaController,
                decoration: InputDecoration( labelText: 'Harga'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Harga!';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _stokController,
                decoration: InputDecoration( labelText: 'Stok'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                  return 'Masukan Stok!';
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
                child: Text('Tambah Produk'))
             ], 
          ),
        ),
      ),
    );
  }
}
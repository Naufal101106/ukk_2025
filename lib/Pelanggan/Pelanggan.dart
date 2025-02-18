import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_2025/Pelanggan/InsertPelanggan.dart';

class Pelanggan extends StatefulWidget {
  const Pelanggan({super.key});

  @override
  State<Pelanggan> createState() => _PelangganState();
}

class _PelangganState extends State<Pelanggan> {

  final SupabaseClient supabase = Supabase.instance.client;
  final _formkey = GlobalKey<FormState>();

  Future<List<Map<String, dynamic>>> fetchdata() async {
    try {
      final response = await supabase.from('pelanggan').select('NamaPelanggan, Alamat, NomorTelepon');

      return response as List<Map<String, dynamic>>;
    }catch (e) {
      print("Error: $e");
      return [];
    }
  }

  void deletePelanggan(BuildContext content,String namaPelanggan) async {
    try {
      bool? confirmDelete = await  showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda Yakin Ingin Menghapus Produk ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), 
              child: Text('Batal')
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), 
              child: Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        )
      );

      if (confirmDelete == true) {
        await supabase.from('pelanggan').delete().eq('NamaPelanggan', namaPelanggan);
        setState(() {
          
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produk Berhasil Dihapus'))
        );
      }
    } catch (e) {
      print('Error deleting product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal Menghapus Produk'), backgroundColor: Colors.red,)
      );
    }
  }


  void showEditPopup(BuildContext context, Map<String, dynamic> item) {
    TextEditingController namapelangganController =
        TextEditingController(text: item['NamaPelanggan']);
    TextEditingController alamatController = 
        TextEditingController(text: item['Alamat']);
    TextEditingController nomorteleponController = 
        TextEditingController(text: item['NomorTelepon']);

      showDialog(
        context: context, 
        builder: (context) {
          return Form(
            key: _formkey,
            child: AlertDialog(
              title: Text('Edit Pelanggan'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    TextFormField(
                      controller: namapelangganController,
                      decoration: InputDecoration(label: Text('Nama Pelanggan')),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Nama Pelanggan!';
                        }
                        return null;
                      },
                    ),
            
                    TextFormField(
                      controller: alamatController,
                      decoration: InputDecoration(label: Text('Alamat')),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Alamat!';
                        }
                        return null;
                      },
                    ),
            
                    TextFormField(
                      controller: nomorteleponController,
                      decoration: InputDecoration(label: Text('Nomor Telepon')),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Nomor Telepon!';
                        }
                        return null;
                      },
                    )
                ],
              ),
            
              actions: [
                TextButton(
                  onPressed: () =>Navigator.pop(context), 
                  child: Text('Batal'),
                  ),
            
                  ElevatedButton(
                    onPressed: () async{
                      if (_formkey.currentState!.validate()){
                        await supabase.from('pelanggan').update({
                        'NamaPelanggan' : namapelangganController.text,
                        'Alamat' : (alamatController.text),
                        'NomorTelepon' : (nomorteleponController.text),
                      }).eq('NamaPelanggan', item['NamaPelanggan']);

                        Navigator.pop(context);
                        setState(() {
                        });
                      }
                    },
                    child: Text('simpan') 
                    )
              ],
            ),
          );
        }
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            final result = await Navigator.push(
              context, 
                MaterialPageRoute(builder: (context) => Insertpelanggan())
            );
            if (result == true);
            Pelanggan();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 3, 186, 247),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.add, color: Colors.white,)],
          ),
        ),
      ),

      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(left: 28),
            child: Container(
              width: MediaQuery.of(context).size.width -40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
            ),
          ),
        ),
      ),

      body: FutureBuilder(
        future: fetchdata(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Data Tidak Ditemukan'));
          } else {
            final List<Map<String, dynamic>> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      item['NamaPelanggan'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alamat :  ${item['Alamat']}'),
                        Text('Nomor Telepon : ${item['NomorTelepon']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue,),
                          onPressed: () => showEditPopup(context, item),
                          ),
                        
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red,),
                          onPressed: () => deletePelanggan(context, item['NamaPelanggan'])
                          )
                        
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
      ),

    );
  }
}
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_2025/cetak.dart';

class DetailPenjualan extends StatefulWidget {
  const DetailPenjualan({super.key});

  @override
  State<DetailPenjualan> createState() => _DetailPenjualanState();
}

class _DetailPenjualanState extends State<DetailPenjualan> {
  final SupabaseClient supabase = Supabase.instance.client;
  List detailPenjualan = [];

  Future<void> fetchDetailPenjualan() async {
    try {
      final response = await supabase
          .from('penjualan')
          .select('*, detailpenjualan(*, produk(*)), pelanggan(*)');
      setState(() {
        detailPenjualan = response;
        print(detailPenjualan);
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDetailPenjualan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 25, bottom: 6),
          child: Text("Detail Penjualan")
          )
        ),
      body: detailPenjualan.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: detailPenjualan.length,
              itemBuilder: (context, index) {
                var item = detailPenjualan[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      "${item['pelanggan']['NamaPelanggan']}",
                      
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Text("Tanggal: ${item['TanggalPenjualan']}", style: TextStyle(color: Colors.grey)),
                        Text("Total: Rp ${item['TotalHarga']}", style: TextStyle(fontWeight: FontWeight.w500)),
                        
                      ],
                    ),
                    leading: CircleAvatar(
                      child: Text(item['pelanggan']['NamaPelanggan'][0]),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),

                    trailing: IconButton(
                        icon: Icon(Icons.print),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Struk(penjualan: item)),
                          );
                        },
                      ),
                  ),
                );
              },
            ),
    );
  }
}
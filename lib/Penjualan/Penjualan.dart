import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Penjualan extends StatefulWidget {
  const Penjualan({super.key});

  @override
  State<Penjualan> createState() => _PenjualanState();
}

class _PenjualanState extends State<Penjualan> {
  final SupabaseClient supabase = Supabase.instance.client;
  List penjualan = [];
  List<Map<String, dynamic>> cartItems = [];
  List pelanggan = [];
  List produk = [];
  int? selectedPelanggan;
  int? selectedProduk;
  int jumlahProduk = 1;
  double totalAmount = 0;

  fetchpenjualan() async {
    final response = await supabase
        .from('penjualan')
        .select('*, pelanggan(*), detailpenjualan(*, produk(*))');
    setState(() => penjualan = response);
  }

  fetchPelanggan() async {
    final response = await supabase.from('pelanggan').select('*');
    setState(() => pelanggan = response);
  }

  fetchProduk() async {
    final response = await supabase.from('produk').select('*');
    setState(() => produk = response);
  }

  @override
  void initState() {
    super.initState();
    fetchpenjualan();
    fetchPelanggan();
    fetchProduk();
  }

  void tambahKeKeranjang() {
    if (selectedProduk != null) {
      var selectedProduct = produk.firstWhere((p) => p['ProdukID'] == selectedProduk);
      cartItems.add({
        "ProdukID": selectedProduct['ProdukID'],
        "NamaProduk": selectedProduct['NamaProduk'],
        "Stok": selectedProduct['Stok'],
        "JumlahProduk": jumlahProduk,
        "Harga": selectedProduct['Harga'],
        "Subtotal": jumlahProduk * selectedProduct['Harga']
      });
      totalAmount += jumlahProduk * selectedProduct['Harga'];
      setState(() {});
    }
  }

  void hapusDariKeranjang(int index) {
    setState(() {
      totalAmount -= cartItems[index]['Subtotal'];
      cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Produk dihapus dari keranjang')),
    );
  }

  void checkout() async {
    if (selectedPelanggan == null || cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pilih pelanggan dan produk terlebih dahulu')));
      return;
    }

    var penjualan = await supabase.from("penjualan").insert([
      {"TotalHarga": totalAmount, "PelangganID": selectedPelanggan}
    ]).select();

    List<Map<String, dynamic>> detailSales = cartItems.map((item) => {
      "PenjualanID": penjualan[0]["PenjualanID"],
      "ProdukID": item["ProdukID"],
      "JumlahProduk": item["JumlahProduk"],
      "Subtotal": item["Subtotal"]
    }).toList();

    await supabase.from("detailpenjualan").insert(detailSales);

    for (var item in cartItems) {
      item['Stok'] -= item['JumlahProduk'] as int;
      item.remove('JumlahProduk');
      item.remove('Subtotal');
    }

    await supabase.from('produk').upsert(cartItems);

    fetchpenjualan();
    setState(() {
      cartItems.clear();
      totalAmount = 0;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Transaksi berhasil')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 25, bottom: 6),
          child: Text("Data Penjualan")
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: "Pilih Pelanggan",
                border: OutlineInputBorder(),
              ),
              value: selectedPelanggan,
              onChanged: (val) => setState(() => selectedPelanggan = val),
              items: pelanggan.map<DropdownMenuItem<int>>((pel) {
                return DropdownMenuItem<int>(
                  value: pel['PelangganID'],
                  child: Text(pel['NamaPelanggan']),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: "Pilih Produk",
                border: OutlineInputBorder(),
              ),
              value: selectedProduk,
              onChanged: (val) => setState(() => selectedProduk = val),
              items: produk.map<DropdownMenuItem<int>>((prod) {
                return DropdownMenuItem<int>(
                  value: prod['ProdukID'],
                  child: Text("${prod['NamaProduk']} - Stok: ${prod['Stok']}")
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Jumlah: ", style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      if (jumlahProduk > 1) setState(() => jumlahProduk--);
                    },
                  ),
                  Text("$jumlahProduk", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.green),
                    onPressed: () {
                      setState(() => jumlahProduk++);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: tambahKeKeranjang,
              child: Text("Tambah ke Keranjang"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartItems[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text(item["NamaProduk"], style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Jumlah: ${item['JumlahProduk']} | Total: Rp ${item['Subtotal']}'),
                      trailing: IconButton(
                        onPressed: () => hapusDariKeranjang(index),
                        icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  )
                  );
                },
              ),
            ),
            Text("Total: Rp $totalAmount", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: checkout,
              child: Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}

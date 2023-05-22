import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../controller/kategori_barang_controller.dart';
import '../../model/kategori_barang_model.dart';
import 'add_kategori_barang.dart';
import 'edit_kategori_barang.dart';

class KategoriBarang extends StatefulWidget {
  const KategoriBarang({super.key});

  @override
  State<KategoriBarang> createState() => _KategoriBarangState();
}

class _KategoriBarangState extends State<KategoriBarang> {
  final kategoriBarangController = BarangController();
  List<KategoriBarangModel> listKategoriBarang = [];

  @override
  void initState() {
    // TODO: implement initState
    getKategoriBarang();
    super.initState();
  }

  void getKategoriBarang() async {
    final kategoriBarang = await kategoriBarangController.getKategoriBarang();
    setState(() {
      listKategoriBarang = kategoriBarang;
    });
  }

  void deleteKategoriBarang(int id) async {
    await kategoriBarangController.deleteKategoriBarang(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori Barang"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: listKategoriBarang.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
                    title: Text(listKategoriBarang[index].nama),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditKategoriBarang(
                                            prevname:
                                                listKategoriBarang[index].nama,
                                            id: listKategoriBarang[index].id,
                                          )));
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                          onPressed: () {
                            deleteKategoriBarang(listKategoriBarang[index].id);
                            setState(() {
                              listKategoriBarang.removeAt(index);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Data Deleted Successfully')));
                            });
                          },
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    )));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddKategoriBarang()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

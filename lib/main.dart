import 'package:flutter/material.dart';

void main() {
  runApp(NilaiSiswaApp());
}

class NilaiSiswaApp extends StatefulWidget {
  @override
  _NilaiSiswaAppState createState() => _NilaiSiswaAppState();
}

class _NilaiSiswaAppState extends State<NilaiSiswaApp> {
  ThemeMode _themeMode = ThemeMode.light; // Default theme mode

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengelompokan Nilai Siswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: _themeMode,
      home: NilaiSiswaHomePage(toggleTheme: _toggleTheme),
    );
  }
}

class NilaiSiswaHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  NilaiSiswaHomePage({required this.toggleTheme});

  @override
  _NilaiSiswaHomePageState createState() => _NilaiSiswaHomePageState();
}

class _NilaiSiswaHomePageState extends State<NilaiSiswaHomePage> {
  final TextEditingController _nilaiController = TextEditingController();
  String _hasilKategori = '';

  void _hitungKategori() {
    setState(() {
      final nilai = int.tryParse(_nilaiController.text);

      if (nilai == null || nilai < 0 || nilai > 100) {
        _hasilKategori = 'Nilai tidak valid. Masukkan nilai antara 0 - 100.';
      } else if (nilai >= 85 && nilai <= 100) {
        _hasilKategori = 'Kategori A';
      } else if (nilai >= 70 && nilai <= 84) {
        _hasilKategori = 'Kategori B';
      } else if (nilai >= 55 && nilai <= 69) {
        _hasilKategori = 'Kategori C';
      } else {
        _hasilKategori = 'Kategori D';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengelompokan Nilai Siswa'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nilaiController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Masukkan Nilai Siswa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
              onPressed: _hitungKategori,
              child: Text('Hitung'),
            ),
            SizedBox(height: 20),
            Text(
              _hasilKategori,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

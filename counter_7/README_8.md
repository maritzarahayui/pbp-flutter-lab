# Tugas 8: Flutter Form

## Jelaskan perbedaan `Navigator.push` dan `Navigator.pushReplacement`
Navigator.push dan Navigator.pushReplacement berguna saat switch dari satu screen ke screen lainnya. Namun, saat menggunakan Navigator.push, kita bisa kembali ke route sebelumnya karena route tersebut tidak dihapus. Sedangkan, saat menggunakan Navigator.pushReplacement, kita tidak bisa kembali ke route sebelumnya karena route tersebut dihapus.

## Sebutkan widget apa saja yang kamu pakai di proyek kali ini dan jelaskan fungsinya.
- Drawer : untuk membuat hamburger menu pada sisi kiri appbar yang dapat digunakan untuk navigasi.
- SizedBox : sebagai container dari layout lain dengan ukuran tertentu.
- ListView : untuk menampilkan children widget dalam sebuah list sehingga dapat di-scroll
- ListTile : widget yang dapat menampilkan 1-3 baris teks dalam sebuah list.
- TextFormField : untuk menerima input teks.
- DropdownButton : untuk menampilkan pilihan input.
- OutlinedButton, TextButton : untuk membuat input berupa tombol.
- Icon : untuk menampilkan ikon.
- Padding, EdgeInsets : untuk mengatur padding dari suatu widget.

## Sebutkan jenis-jenis event yang ada pada Flutter (contoh: onPressed).
- onPressed: event terjadi saat widget ditekan
- onChanged: event terjadi saat widget diubah
- onSaved: event terjadi saat widget disimpan

## Jelaskan bagaimana cara kerja Navigator dalam "mengganti" halaman dari aplikasi Flutter.
Ketika kita menjalankan Navigator.push, screen baru akan ditambahkan ke stack sehingga screen sebelumnya tertimpa dengan screen yang baru. Screen yang di-push akan berada di stack paling atas, sehingga screen seolah olah berganti dan dapat dilihat oleh user. Jika kita menjalankan Navigator.pushReplacement, screen sebelumnya seolah-olah di-pop terlebih dahulu kemudian di-push.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas.
1. Menambahkan drawer/hamburger menu pada app yang telah dibuat sebeumnya dengan menambahkan potongan code berikut ke dalam file `main.dart`

    ```shell
    class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Program Counter'),
        );
    }
    }

    class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key, required this.title});

    final String title;

    @override
    State<MyHomePage> createState() => _MyHomePageState();
    }
    ```

2. Menambahkan tiga tombol navigasi pada drawer/hamburger dengan membuat file baru bernama `drawer.dart` dan mengisinya dengan code berikut.

    ```shell
    enum ScreenName { Home, Form, ShowForm }

    class DrawerClass extends StatefulWidget {
    final ScreenName parentScreen;
    const DrawerClass({super.key, required this.parentScreen});
    @override
    State<DrawerClass> createState() => _DrawerClassState();
    }

    class _DrawerClassState extends State<DrawerClass> {
    @override
    Widget build(BuildContext context) {
        return Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
            ListTile(
                title: Text('Counter_7'),
                onTap: () {
                if (widget.parentScreen != ScreenName.Home) {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Program Counter',)),
                    );
                } else {
                    Navigator.pop(context);
                }
                },
            ),
            ListTile(
                title: Text('Tambah Budget'),
                onTap: () {
                if (widget.parentScreen != ScreenName.Form) {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const FormPage()),
                    );
                } else {
                    Navigator.pop(context);
                }
                },
            ),
            ListTile(
                title: Text('Data Budget'),
                onTap: () {
                if (widget.parentScreen != ScreenName.ShowForm) {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyShowForm()),
                    );
                } else {
                    Navigator.pop(context);
                }
                },
            ),
            ],
        ),
        );
    }
    }
    ```

    Menambahkan potongan code berikut ke dalam file `main.dart`

    ```shell
    ...,
    drawer: DrawerClass(parentScreen: ScreenName.Home),
    ...
    ```

3. Menambahkan halaman form dengan membuat file baru bernama `form.dart` dan mengisinya dengan code berikut.

    ```shell
    var data = <Map>[];

    class FormPage extends StatefulWidget {
    const FormPage({super.key});
    @override
    State<FormPage> createState() => _FormPageState();
    }

    class _FormPageState extends State<FormPage> {
    final _formKey = GlobalKey<FormState>();
    String _title = '';
    String _nominal = '';
    List<String> _categories = ['Pemasukan', 'Pengeluaran'];
    var _selectedCategory = null;

    TextEditingController dateInput = TextEditingController();

    @override
    void initState() {
        dateInput.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: Text('Form'),
        ),
        drawer: DrawerClass(parentScreen: ScreenName.Form),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                children: [
                    Padding(
                    // Menggunakan padding sebesar 8 pixels
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                        icon: Icon(Icons.title),
                        hintText: "Beli Buku",
                        labelText: "Judul",
                        // Menambahkan icon agar lebih intuitif
                        // Menambahkan circular border agar lebih rapi
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                        ),
                        ),
                        // Menambahkan behavior saat nama diketik
                        onChanged: (String? value) {
                        setState(() {
                            _title = value!;
                        });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                        setState(() {
                            _title = value!;
                        });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                        if (value == null || value.isEmpty) {
                            return 'Judul tidak boleh kosong!';
                        }
                        return null;
                        },
                    ),
                    ),
                    Padding(
                    // Menggunakan padding sebesar 8 pixels
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                        icon: Icon(Icons.attach_money),
                        hintText: "5000",
                        labelText: "Nominal",
                        // Menambahkan icon agar lebih intuitif
                        // Menambahkan circular border agar lebih rapi
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                        ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                        ],

                        // Menambahkan behavior saat nama diketik
                        onChanged: (String? value) {
                        setState(() {
                            _nominal = value!;
                        });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                        setState(() {
                            _nominal = value!;
                        });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.startsWith('0')) {
                            return 'Nominal tidak boleh kosong!';
                        }
                        return null;
                        },
                    ),
                    ),
                    TextFormField(
                    controller: dateInput,
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Masukkan tanggal",
                    ),
                    readOnly: true,
                    onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                        String formattedDate =
                        DateFormat('dd-MM-yyy').format(pickedDate);

                        setState(() {
                            dateInput.text = formattedDate;
                        });
                        } else {}
                    },
                    ),
                    DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                        hint: Text('Pilih jenis'),
                        items: _categories.map((jenis) {
                            return DropdownMenuItem(
                            value: jenis,
                            child: Text(jenis),
                            );
                        }).toList(),
                        value: _selectedCategory,
                        onChanged: (newValue) {
                            setState(() {
                            _selectedCategory = newValue!;
                            });
                        },
                        validator: (value) {
                            if (value == null) {
                            return 'Jenis tidak boleh kosong!';
                            }
                            return null;
                        },
                    ),
                    ),
                    TextButton(
                    child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(16)),
                    ),
                    onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        var map = {};
                        map['title'] = _title;
                        map['nominal'] = _nominal;
                        map['category'] = _selectedCategory;
                        map['date'] = dateInput.text;
                        data.add(map);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                            content: Text('Data berhasil disimpan!'),
                            backgroundColor: Colors.green,
                            ),
                        );
                        }
                    },
                    ),
                ],
                ),
            ),
            ),
        ),
        );
    }
    }
    ```

4. Menambahkan halaman data budget dengan membuat file baru bernama `budget.dart` dan mengisinya dengan code berikut.

    ```shell
    class MyShowForm extends StatefulWidget {
    const MyShowForm({super.key});
    @override
    State<MyShowForm> createState() => _MyShowFormState();
    }

    class _MyShowFormState extends State<MyShowForm> {
    final _formKey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: Text('Data Budget'),
        ),
        drawer: DrawerClass(parentScreen: ScreenName.ShowForm),
        body: ListView.builder(
            itemCount: form.data.length,
            itemBuilder: (context, index) {
            return Card(
                child: ListTile(
                title: Text(form.data[index]['title']),
                subtitle: Text(form.data[index]['nominal']),
                trailing: Text(form.data[index]['category'] + " " + form.data[index]['date']),
                ),
            );
            },
        ),
        );
    }
    }
    ```
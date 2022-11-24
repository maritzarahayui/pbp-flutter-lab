# Tugas 9: Integrasi Web Service pada Flutter

## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
Bisa, tapi lebih baik membuat model terlebih dahulu. Dengan membuat model terlebih dahulu, data-data yang diambil dari JSON tersebut akan lebih terstruktur dan lebih mudah untuk mengakses detailnya. Selain itu, kita dapat memastikan apakah tipe datanya sesuai atau tidak dan dapat menyesuaikan ulang fields mana yg perlu dipakai.

## Sebutkan widget apa saja yang kamu pakai di proyek kali ini dan jelaskan fungsinya.
- Expanded : membuat jarak kosong antar elemen
- ListView : menampilkan children widget yang tersimpan dalam sebuah list (menampilkan data film)
- EdgeInsets : mengatur padding dari suatu widget
- CheckBox : membuat form boolean toggle dengan checkbox (mengubah status watched)

## Jelaskan mekanisme pengambilan data dari json hingga dapat ditampilkan pada Flutter.
1. Membuat model dari data yang ada pada page json menggunakan generator yang tersedia di Google agar lebih mudah.
2. Letakkan link json yang diperoleh ke dalam method fetchMyWatchList agar data tersebut bisa kita fetch.
3. Convert data ke dalam bentuk objek yang sesuai dengan class model MyWatchList yang sudah dibuat sebelumnya.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas.
1. Menambahkan tombol navigasi pada drawer/hamburger untuk ke halaman mywatchlist dengan menambahkan kode berikut pada file drawer.dart

    ```shell
    ...
    ListTile(
        title: Text('My WatchList'),
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
    ```

2. Membuat satu file dart yang berisi model mywatchlist di dalam folder `model` dengan nama `my_watch_list.dart`

3. Menambahkan halaman mywatchlist yang berisi semua watch list yang ada pada endpoint JSON di Django yang telah kamu deploy ke Heroku sebelumnya (Tugas 3). Pada bagian ini, kamu cukup menampilkan judul dari setiap mywatchlist yang ada dengan menambahkan kode berikut pada file `my_watchlist.dart`

    ```shell
    import 'package:counter_7/model/my_watch_list.dart';
    import 'package:http/http.dart' as http;
    import 'dart:convert';

    Future<List<MyWatchList>> fetchMyWatchList() async {
        var url = Uri.parse('https://caca-watchlist.herokuapp.com/mywatchlist/json/');
        var response = await http.get(
        url,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json",
        },
        );

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object MyWatchList
        List<MyWatchList> listMyWatchList = [];
        for (var d in data) {
            if (d != null) {
                listMyWatchList.add(MyWatchList.fromJson(d));
            }
        }

        return listMyWatchList;
    }
    ```

4. Membuat navigasi dari setiap judul watch list ke halaman detail dengan menambahkan potongan kode berikut pada file `my_watch_list_page.dart`

    ```shell
    return ListView.builder(
        ...
        onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DetailPage(film: snapshot.data![index])),
            );
        },
        ...
    )
    ```    

5. Menambahkan halaman detail untuk setiap mywatchlist yang ada pada daftar tersebut. Halaman ini menampilkan judul, release date, rating, review, dan status (sudah ditonton/belum) dengan membuat file baru di dalam folder `page` bernama `detail.dart`

6. Menambahkan tombol untuk kembali ke daftar mywatchlist dengan menambahkan potongan kode berikut pada file `detail.dart`

    ```shell
    Container( 
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(25),
        child: TextButton(
        child: const Text(
            "Back", style: TextStyle(color: Colors.white)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue)),
        onPressed: () {
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyWatchListPage()),
            );
        }
        ),
    ),
    ``` 

7. Menambahkan checkbox pada setiap watchlist pada halaman mywatchlist. Dimana checkbox akan tercentang jika status ditonton bernilai true dan tidak jika bernilai false dengan menambahkan potongan kode berikut pada file `my_watch_list_page.dart`

    ```shell
    Checkbox(  
        value: snapshot.data![index].fields.watched == "Sudah"? true:false,  
        onChanged: (value) {  
        setState(() {  
            snapshot.data![index].fields.watched = value!? "Sudah":"Belum"; 
        });  
        },  
    ),
    ``` 

8. Menambahkan warna untuk outline pada setiap mywatchlist pada halaman mywatchlist berdasarkan status ditonton (Dua warna yang dipilih bebas) dengan menambahkan potongan kode berikut pada file `my_watch_list_page.dart`

    ```shell
    decoration: BoxDecoration(
        color: snapshot.data![index].fields.watched == "Sudah"? 
            Color.fromARGB(255, 113, 222, 160) : Color.fromARGB(255, 220, 123, 116),
        
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
        BoxShadow(
            color: Colors.black,
            blurRadius: 2.0
        )
        ]
    ),
    ```

9. Refactor function fetch data dari web service ke sebuah file terpisah dengan membuat file bernama `fetch_my_watchlist.dart` berisikan potongan kode berikut.

    ```shell
    import 'package:counter_7/model/my_watch_list.dart';
    import 'package:http/http.dart' as http;
    import 'dart:convert';

    Future<List<MyWatchList>> fetchMyWatchList() async {
        var url = Uri.parse('https://caca-watchlist.herokuapp.com/mywatchlist/json/');
        var response = await http.get(
        url,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json",
        },
        );

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object MyWatchList
        List<MyWatchList> listMyWatchList = [];
        for (var d in data) {
        if (d != null) {
            listMyWatchList.add(MyWatchList.fromJson(d));
        }
        }

        return listMyWatchList;
    }
    ```
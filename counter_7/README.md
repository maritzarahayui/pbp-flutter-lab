# Tugas 7: Elemen Dasar Flutter

## Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget dan jelaskan perbedaan dari keduanya.
Stateless widget adalah widget yang statusnya tidak dapat diubah setelah dibuat (bersifat statis), sedangkan stateful widget adalah widget yang statusnya dapat diubah setelah dibuat (bersifat dinamis).

## Sebutkan widget apa saja yang kamu pakai di proyek kali ini dan jelaskan fungsinya.
- Scaffold : Mengatur layout dari widget yang ada di dalamnya
- Text : Untuk menampilkan text dengan style tertentu
- FloatingActionButton : Untuk membuat button yang dapat melakukan action tertentu
- Row : Memposisikan widget secara horizontal
- Column : Memposisikan widget secara vertikal
- Padding : Menambahkan padding atau empty space
- Center : Memposisikan elemen ke tengah
- Icon : Memberi icon ke sebuah elemen

## Apa fungsi dari `setState()?` Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.
Fungsi dari setState() adalah untuk memperbarui status dari komponen yang digunakan. Hal ini untuk memastikan bahwa komponen telah diperbarui dan program akan meminta untuk me-rendering ulang komponen tersebut. setState() bersifat asynchronous, artinya jika panggilan tersebut dipanggil, mungkin tidak akan langsung diperbarui pada waktu yang sama, sehingga tidak memberikan pembaruan yang terjadi saat ini. Untuk mendapatkan perilaku secara synchronous, fungsi tersebut harus diteruskan ke setState().

## Jelaskan perbedaan antara `const` dengan `final`.
`const` dan `final` adalah keyword yang dapat digunakan untuk membuat variabel yang bersifat immutable. Perbedaannya terdapat pada saat inisiasi nilai dari variabelnya, `const` mengharuskan variabel diinisiasi pada saat kompilasi. Nilai tersebut bersifat konstan dan eksplisit pada saat kompilasi, variabel `const` tersebut sudah memiliki nilai, sedangkan variabel `final` tidak memiliki nilai yang bersifat eksplisit pada saat kompilasi.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas.
1. Membuat aplikasi Flutter bernama counter_7 menggunakan kode berikut.

    ```shell
    flutter create counter_7
    ```

2. Membuat fungsi `_decrementCounter` untuk mengurangi angka sebanyak satu satuan berisikan kode berikut.

    ```shell
    void _decrementCounter() {
        setState(() {
            if (_counter > 0) {
                _counter--;
            }
        });
    }
    ```

3. Membuat kondisi counter bernilai ganjil dan membuat teks indikator berubah menjadi "GANJIL" dengan warna biru, kemudian membuat kondisi counter bernilai genap dan membuat teks indikator berubah menjadi "GENAP" dengan warna merah menggunakan kode berikut.

    ```shell
    if (_counter % 2 == 0) ...[
        const Text(
        'GENAP',
        style: TextStyle(color: Colors.red),
        ),
    ] else ...[
        const Text(
        'GANJIL',
        style: TextStyle(color: Colors.blue),
        ),
    ],
    ```

4. Membuat tombol untuk menambah dan mengurangi nilai counter menggunakan kode berikut.

    ```shell
    floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (_counter != 0) ...[
            FloatingActionButton(
                onPressed: _decrementCounter,
                tooltip: 'Decrement',
                child: const Icon(Icons.remove),
            ),
            ],
            const Spacer(),
            FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add)),
        ]),
    )
    ```

5. Menghilangkan tombol ketika counter bernilai 0 dengan menambahkan kondisi pada saat membuat tombol decrement seperti kode berikut.

    ```shell
    if (_counter != 0) ...[
        FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
        ),
    ],
    ```
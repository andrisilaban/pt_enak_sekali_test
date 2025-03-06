# PT Enak Sekali Test

Aplikasi Flutter ini menerapkan arsitektur **Domain Driven Design (DDD)** dan menggunakan Fake API dari [DummyJSON](https://dummyjson.com/products) untuk menampilkan daftar produk.

## Fitur

- **Splash Screen** saat aplikasi dibuka.
- **Infinite Scroll**: Data produk dimuat secara bertahap dengan limit 10 produk setiap fetch.
- **Search Product**: Pengguna dapat mencari produk berdasarkan nama.
- **Filter by Category**: Pengguna dapat memfilter produk berdasarkan kategori.

## Teknologi yang Digunakan

- **Flutter**: Framework utama untuk membangun aplikasi.
- **Dart**: Bahasa pemrograman yang digunakan.
- **Dio/Http**: Untuk melakukan HTTP request ke DummyJSON API.

## Arsitektur Domain Driven Design (DDD)

Aplikasi ini dibangun dengan pendekatan DDD yang memisahkan kode menjadi beberapa lapisan utama:

1. **Domain**: Berisi model entitas, repository abstrak, dan logika bisnis.
   - `entities/` → Model entitas seperti `product.dart`
   - `repositories/` → Abstraksi repository seperti `product_repository.dart`
   - `usecases/` → Logika bisnis seperti `get_products.dart` dan `search_products.dart`

2. **Data**: Berisi implementasi repository dan komunikasi dengan API.
   - `data_sources/` → Data sumber seperti `remote_data_source.dart`
   - `repositories/` → Implementasi repository seperti `product_repository_impl.dart`

3. **Presentation**: UI, state management, dan event handlers.
   - `pages/` → Halaman UI seperti `product_list_page.dart`
   - `widgets/` → Komponen UI seperti `product_grid_item.dart`

4. **Main Entry Point**:
   - `main.dart` → Entry point utama aplikasi.

## Cara Menjalankan Aplikasi

1. Clone repositori ini:
   ```sh
   git clone https://github.com/andrisilaban/pt_enak_sekali_test.git
   cd pt_enak_sekali_test
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Jalankan aplikasi di emulator atau perangkat fisik:
   ```sh
   flutter run
   ```

## API Endpoint

Aplikasi ini menggunakan API dari [DummyJSON](https://dummyjson.com/products) dengan endpoint utama:

- **GET** `/products` → Mendapatkan daftar produk.
- **GET** `/products/search?q=keyword` → Mencari produk berdasarkan kata kunci.
- **GET** `/products/category/category_name` → Filter produk berdasarkan kategori.

## Kontributor

Jika ingin berkontribusi, silakan buat pull request atau laporkan issue melalui GitHub.

---

🚀 **Happy Coding!**


![image alt](https://github.com/andrisilaban/pt_enak_sekali_test/blob/b91d8e34d809bd2b666fd436ff87d678137c0923/produk_pt_enak_sekali.jpg)

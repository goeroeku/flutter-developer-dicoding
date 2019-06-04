# Meals Catalogue - Submission Final

Dicoding Menjadi Flutter Developer Expert

## Challenge

- Menerapkan Unit Tests dan Instrumentation Tests

  - Syarat:
    - Pertahankan semua fitur pada aplikasi sebelumnya.
    - Menerapkan Unit Tests menggunakan Mockito pada beberapa fungsi, misalnya fungsi untuk request data ke server.
    - Menerapkan Instrumentation Tests dengan skenario yang Anda buat sendiri sesuai behaviour pada aplikasi.

- Menambahkan Flavors

  - Syarat:
    - Aplikasi wajib menambahkan Flavors, untuk iconnya bebas.

- Pencarian Makanan

  - Syarat:
    - Pengguna dapat melakukan pencarian Desert.
    - Pengguna dapat melakukan pencarian Seafood.

- Favorite Resep Makanan

  - Syarat:
    - Dapat menyimpan makanan ke database favorite.
    - Dapat menghapus makanan dari database favorite.
    - Terdapat halaman untuk menampilkan daftar Favorite Desert.
    - Terdapat halaman untuk menampilkan daftar Favorite Seafood.

- Teknis
  - Menggunakan library pihak ketiga seperti HTTP Request, dsb.
  - Menerapkan konsep Material Design pada penyusunan layout.
  - Menerapkan konsep Hero Animation.
  - Menggunakan SearchView pada fitur pencarian film.
  - Menerapkan Flavor untuk membuat app mode debug dan mode release.
  - Menerapkan Unit Tests dengan Mockito.
  - Menerapkan Instrumentation Tests.
  - Aplikasi bisa memberikan pesan eror jika data tidak berhasil ditampilkan.

## Author

goeroeku

## Requirement

- Flutter
- Android SDK & Emulator

## Run

This project consists of 2 types of flavors, namely free and paid.

```sh
flutter run --flavor free -t lib/main.dart
```

or

```sh
flutter run --flavor paid -t lib/main_paid.dart
```

## Testing

Unit Testing

```sh
flutter test

```

Integration Testing

```sh
flutter driver --target=test_driver/app.dart --flavor free
```

or

```sh
flutter driver --target=test_driver/app.dart --flavor paid
```

## Build Android

```sh
flutter build apk --flavor free -t lib/main.dart
```

or

```sh
flutter build apk --flavor paid -t lib/main_paid.dart
```

# Toxic Gases Detector
*---Proyek Akhir SSF oleh Kelompok 4---*

  Toxic Gases Detector merupakan sistem yang dirancang sebagai pendeteksi konsentrasi gas berbahaya dalam ruangan. Di dalam rangkaian ini terdapat sensor gas MQ-2 yang berfungsi penting untuk menjadi pendeteksi kandungan gas berbahaya, seperti LPG, alkohol, asap, propana, hidrogen, metana, maupun karbon monoksida di udara. Sensor ini mengambil data secara langsung dari udara dan mengirimkan data pembacaan tersebut ke Arduino Uno.

# How to Use
  1. Hubungkan seluruh hardware yang diperlukan sesuai seperti rangkaian pada Proteus.
  2. Clone repositori ini untuk menyimpan kode pada penyimpanan lokal Anda menggunakan command:
     > git clone https://github.com/rantiaaa/Toxic-Gases-Detector.git
  4. Buka file MQ2toMAX7219.S dengan menggunakan Arduino IDE.
  5. Cek konektivitas Arduino Uno dengan komputer.
  6. Ubah tipe board pada Arduino IDE menjadi board Arduino Uno yang telah terhubung pada port COM.
  7. Lakukan uploading dan verifying kode dengan meng-klik tanda centang dan panah yang berada di bagian kiri atas tampilan software.
  8. Selamat! Rangkaian berhasil berjalan dan silahkan amati status pada MAX7219 berdasarkan hasil pembacaan sensor gas MQ-2.

# Software
## 1. Arduino IDE
  Software ini digunakan untuk mengeksekusi kode Assembly yang telah dibuat, dimana kode dapat diupload dan dicompile ke Arduino Uno R3.
  ![image](https://github.com/rantiaaa/Toxic-Gases-Detector/assets/87708733/32343e82-e458-4c07-a4d5-d847d033f425)
## 2. Proteus
  Software ini digunakan untuk membuat desain virtual dari rangkaian yang akan dibuat. Selain itu, dengan menghubungkan Proteus dengan kode pada Arduino IDE, rangkaian dapat disimulasikan dengan tepat sesuai dengan keinginan pengguna.
  ![image](https://github.com/rantiaaa/Toxic-Gases-Detector/assets/87708733/61f53bfb-bcff-4928-8e9a-951729766104)

# Hardware
## 1. Arduino Uno R3
  Mikrokontroler yang menggunakan ATmega328p yang menyediakan pin analog dan digital I/O, serta dapat diprogram dengan bahasa pemrograman C/C++ hingga Assembly. Pada proyek kami, Arduino digunakan untuk mengontrol kinerja seluruh komponen dalam rangkaian.
  ![image](https://github.com/rantiaaa/Toxic-Gases-Detector/assets/87708733/a8792629-211c-4bf0-a161-e7bc4799f7d6)
## 2. Sensor Gas MQ-2
  Suatu sensor yang dapat mendeteksi beberapa jenis gas berbahaya, seperti LPG, alkohol, asap, propana, hidrogen, metana, hingga karbon monoksida. Sensor ini dapat menghasilkan output analog maupun digital.
  ![image](https://github.com/rantiaaa/Toxic-Gases-Detector/assets/87708733/5aebbd15-6d53-4976-8644-9b75e004ced8)
## 3. 8-bit 7-Segment MAX7219
  Komponen elektronik ini digunakan sebagai display status udara setelah dilakukan pendeteksian oleh sensor gas. Dengan menggunakan komunikasi SPI, 8-bit 7-segment display dikendalikan oleh IC MAX7219. Pada proyek kami, display ini dirancang untuk dapat menampilkan status "-SAFE-" ketika tidak ada gas berbahaya yang terdeteksi dan akan menampilkan status "danger" ketika sensor gas mendeteksi adanya konsentrasi gas berbahaya di udara.
  ![image](https://github.com/rantiaaa/Toxic-Gases-Detector/assets/87708733/73e99ed3-8fc2-4ee5-a726-83879de3c196)
## 4. HYDZ Piezo Buzzer
  Suatu komponen elektronik yang dapat menghasilkan suara ketika menerima sinyal elektrik. Buzzer ini umumnya digunakan sebagai alarm, khususnya pada proyek kami, buzzer dimanfaatkan sebagai indikator adanya gas berbahaya di udara.
  ![image](https://github.com/rantiaaa/Toxic-Gases-Detector/assets/87708733/6d652c67-fb23-40c2-a88c-665e58515389)
## 5. Exhaust Fan
  Kipas pada rangkaian ini dirancang untuk aktif ketika sensor gas mendeteksi adanya gas berbahaya di udara, dimana komponen elektronik ini kinerjanya dikontrol penuh melalui Arduino.
  ![image](https://github.com/rantiaaa/Toxic-Gases-Detector/assets/87708733/ef8d5b47-87e9-4767-aae2-a7b0f840b5f8)

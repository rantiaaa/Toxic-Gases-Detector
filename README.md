# Toxic Gases Detector
*---Proyek Akhir SSF oleh Kelompok 4---*

  Toxic Gases Detector merupakan sistem yang dirancang sebagai pendeteksi konsentrasi gas berbahaya dalam ruangan. Di dalam rangkaian ini terdapat sensor gas MQ-2 yang berfungsi penting untuk menjadi pendeteksi kandungan gas berbahaya, seperti LPG, alkohol, asap, propana, hidrogen, metana, maupun karbon monoksida di udara. Sensor ini mengambil data secara langsung dari udara dan mengirimkan data pembacaan tersebut ke Arduino Uno.

# How to Use
  1. Hubungkan seluruh hardware yang diperlukan sesuai seperti rangkaian pada Proteus.
  2. Clone repositori ini untuk menyimpan kode pada penyimpanan lokal Anda menggunakan command:
     > git clone https://github.com/rantiaaa/Toxic-Gases-Detector.git
  4. Buka folder MQ2toMAX7219 dengan menggunakan Arduino IDE.
  5. Cek konektivitas Arduino Uno dengan komputer.
  6. Ubah tipe board pada Arduino IDE menjadi board Arduino Uno yang telah terhubung pada port COM.
  7. Lakukan uploading dan verifying kode dengan meng-klik tanda centang dan panah yang berada di bagian kiri atas tampilan software.
  8. Selamat! Rangkaian berhasil berjalan dan silahkan amati status pada MAX7219 berdasarkan hasil pembacaan sensor gas MQ-2.

## i. Introduction to the Problem and the Solution
  Dalam era modern saat ini, keberadaan gas berbahaya dalam ruangan dapat menjadi ancaman serius bagi kesehatan manusia dan keamanan lingkungan. Gas-gas seperti LPG, karbon monoksida (CO), metana (CH4), propana, dan gas berbahaya lainnya sering kali tidak terdeteksi oleh indera manusia sehingga menimbulkan risiko tersembunyi. Oleh karena itu, diperlukan sebuah sistem yang dapat secara real-time mendeteksi keberadaan gas berbahaya dan mengambil tindakan pencegahan yang diperlukan untuk memastikan keselamatan.
  Proyek ini bertujuan untuk mengembangkan sebuah sistem deteksi konsentrasi gas berbahaya dalam ruangan menggunakan sensor gas MQ. Sistem ini akan memantau konsentrasi gas secara kontinu dan jika konsentrasi gas melebihi ambang batas yang telah ditetapkan, indikator seperti buzzer akan menyala sebagai peringatan. Selain itu, untuk menampilkan tingkat konsentrasi gas yang terdeteksi, sistem akan menggunakan modul display MAX7219 yang terhubung melalui protokol komunikasi Serial Peripheral Interface (SPI). Sebagai langkah mitigasi tambahan, ketika terdeteksi konsentrasi gas berbahaya yang tinggi, sistem ini juga akan mengaktifkan exhaust fan untuk membuang gas berbahaya dari ruangan, sehingga membantu menjaga kualitas udara dan mengurangi potensi bahaya.

## ii. Hardware Design and Implementation Details
  Berdasarkan rangkaian yang telah dibuat secara fisik maupun yang telah dibuat pada software Proteus, dapat dilihat bahwa sensor MQ-2 disambungkan dengan Arduino Uno melalui pin analog dengan menghubungkan pin A0 pada sensor dengan pin PC0 pada Arduino Uno, dan juga pin VCC dihubungkan ke VCC breadboard dan pin GND dihubungkan ke GROUND breadboard. Selain itu, terdapat juga modul MAX7219 dihubungkan dengan Arduino Uno. Dimana pin DIN dihubungkan dengan pin PB3, pin CS/LOAD dihubungkan dengan pin PB2, pin CLK dihubungkan dengan pin PB5, serta pin ISET disambungkan dengan ground. Kami juga menggunakan buzzer yang dihubungkan dengan pin PB0 sebagai output, serta exhaust fan yang terhubung ke pin PB1 sebagai output.

## iii. Software Implementation Details
  Pada proyek ini, kami mengimplementasikan modul-modul yang telah dipelajari selama mengikuti praktikum Sistem Siber Fisik pada Semester Genap 2023/2024. Berikut ini penjelasan terperinci mengenai setiap implementasi modul yang kami gunakan:
  ### Implementasi I/O
  Pada mikrokontroler yang digunakan dalam proyek ini, terdapat tiga port digital yang dapat diakses untuk input/output, yaitu Port B, C, dan D. Setiap port memiliki 8 bit yang mewakili 8 pin digital yang dapat dikendalikan atau dibaca. Port B memiliki pin 8 hingga 15, Port C memiliki pin 0 hingga 7, dan Port D memiliki pin 0 hingga 7.	
  Port B digunakan untuk mengendalikan perangkat elektronik seperti buzzer dan fan. Pin 0 dan 1 dari Port B digunakan untuk mengontrol buzzer dan fan secara langsung. Port tersebut diatur dengan menggunakan instruksi SBI dan CBI untuk menetapkan pin sebagai output atau input. Port C digunakan sebagai input dengan mengatur PC0 sebagai input untuk membaca sensor. Pengaturan mode input dilakukan dengan instruksi CBI pada register DDRC. Port B juga digunakan untuk komunikasi SPI dengan perangkat MAX7219. Pin 2, 3, dan 5 dari Port B digunakan untuk SPI (Serial Peripheral Interface) untuk berkomunikasi dengan perangkat tersebut. Instruksi OUT digunakan untuk mengatur register DDRB untuk menetapkan pin-pin tersebut sebagai output.
  ### Aritmatika
  Pada proyek ini, kami mengimplementasikan beberapa instruksi aritmatika di dalam kode untuk dapat menjalankan rangkaian. Kami menggunakan modul aritmatika ini untuk melakukan perbandingan antara nilai yang dibaca oleh sensor MQ-2 dengan nilai HIGH atau 1 sebagai indikator bahwa adanya gas berbahaya yang terdeteksi oleh sensor dengan menggunakan instruksi CPI dan BREQ, serta dalam kode delay. Untuk memberikan delay pada program, digunakan instruksi DEC atau decrement untuk mengurangi nilai pada register dan terus melakukan pengulangan hingga nilai pada register mencapai 0.
  ### Communication
  Pada proyek ini, kami menggunakan protokol komunikasi SPI untuk menghubungkan sensor MQ-2 dengan Arduino, dan hasilnya akan ditampilkan pada MAX7219. Dengan menggunakan SPI, data dapat dikirim dan diterima dengan cepat antara mikrokontroler dan perangkat keras eksternal, memungkinkan kontrol dan akses data yang efisien. MAX7219 akan menampilkan teks "Safe" yang menandakan tidak ada gas, dan "Danger" yang menunjukkan adanya gas yang terdeteksi oleh sensor MQ-2.
  ### Sensor
  Untuk implementasi modul ini, digunakan sensor gas MQ-2. Sensor ini digunakan untuk mendeteksi keberadaan gas berbahaya dalam ruangan, seperti LPG, alkohol, propana, hidrogen, metana, dan karbon monoksida. Sensor terhubung dengan Arduino dan menghasilkan output berupa 1 (jika mendeteksi gas berbahaya) dan 0 (jika tidak mendeteksi gas berbahaya).

## iv. Test Result and Performance Evaluation
  Proyek Toxic Gases Detector bertujuan untuk mendeteksi keberadaan gas berbahaya dalam suatu ruangan secara efektif. Sistem ini menggunakan sensor MQ-2 yang membaca data mengenai keberadaan gas, kemudian mengirimkannya ke Arduino untuk diproses. Ketika gas berbahaya terdeteksi, sistem akan mengaktifkan beberapa respon: buzzer akan berbunyi sebagai alarm, tampilan 7 segment akan menampilkan teks “danger” sebagai peringatan visual, dan motor DC akan mengaktifkan kipas untuk membantu mengurangi konsentrasi gas. Dengan demikian, sistem ini memungkinkan pengguna untuk mengetahui keberadaan gas berbahaya lebih awal, sehingga risiko yang ditimbulkan dapat diminimalisir atau dihindari.
  
![Screenshot 2024-05-28 152830](https://github.com/rantiaaa/Toxic-Gases-Detector/assets/87708733/0b6911ef-8abb-486f-9f86-5f0bb4f85b63)
![Screenshot 2024-05-28 152906](https://github.com/rantiaaa/Toxic-Gases-Detector/assets/87708733/5a670068-a25c-42e6-9b09-e87829aa6cab)

## v. Conclusion and Future Work
  Toxic Gases Detector yang dirancang sebagai pendeteksi gas berbahaya dalam ruangan ini melibatkan penggunaan sensor gas MQ-2 yang dapat mendeteksi kandungan gas berbahaya, seperti LPG, alkohol, asap, propana, hidrogen, metana, 
maupun karbon monoksida di udara. Sensor ini mengambil data secara langsung dari udara dan mengirimkan data pembacaan tersebut ke Arduino Uno. Berdasarkan data yang telah diterima ini, Arduino akan melakukan analisis data, dimana apabila hasil yang didapat menunjukkan bahwa terdapat gas berbahaya yang terdeteksi, maka buzzer akan menyala sebagai indikator dan exhaust fan akan aktif untuk meminimalisir konsentrasi gas berbahaya di udara sekitar.
  Dengan ini kami harapkan proyek Toxic Gases Detector dapat membantu masyarakat dalam tindak pencegahan terjadinya keracunan gas, maupun bencana kebakaran. Kami harap proyek kami dapat dipergunakan dengan baik, kemudian juga kami berharap bahwa Toxic Gases Detector dapat dikembangkan menjadi rangkaian yang lebih baik lagi.

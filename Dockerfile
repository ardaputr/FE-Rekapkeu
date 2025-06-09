# Gunakan image Nginx resmi yang ringan sebagai base image
FROM nginx:alpine

# Hapus default konfigurasi Nginx
# Ini opsional, tapi baik untuk memastikan tidak ada konfigurasi yang tidak diinginkan
RUN rm -rf /etc/nginx/conf.d/*

# Salin file-file HTML Anda ke dalam direktori Nginx default
# Pastikan struktur folder Anda sesuai dengan path di bawah.
# Jika file HTML Anda berada langsung di root folder proyek Anda,
# maka perintah ini akan menyalinnya ke /usr/share/nginx/html/
COPY . /usr/share/nginx/html/

# Salin konfigurasi Nginx kustom Anda (jika ada)
# Anda bisa membuat file `nginx.conf` atau `default.conf` di folder yang sama dengan Dockerfile
# Jika tidak ada, Anda bisa menghapus baris ini atau menggunakan konfigurasi default Nginx
# Misalnya, buat file `default.conf` di root proyek Anda dengan isi:
# server {
#     listen 80;
#     location / {
#         root   /usr/share/nginx/html;
#         index  index.html;
#         try_files $uri $uri/ /index.html; # Penting untuk aplikasi SPA atau jika Anda ingin fallback ke index.html
#     }
# }
# COPY default.conf /etc/nginx/conf.d/default.conf

# Exposure port 80 karena Nginx berjalan di port tersebut secara default
EXPOSE 80

# Jalankan Nginx saat container dimulai
CMD ["nginx", "-g", "daemon off;"]
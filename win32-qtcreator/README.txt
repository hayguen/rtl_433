
1) aquire and install Qt 5.5.x for Windows 32-bit (MinGW 4.9.2) from
https://www.qt.io/download-open-source/#section-2

2) aquire and install QtCreator 4.0.x
from same site as 1)
probably this step is not necessary and you can use the qtcreator IDE from 1)

3) aquire LibUSB 1.0.20 from
https://sourceforge.net/projects/libusb/files/
last tested: libusb-1.0.20.7z

and place the file at C:/src/_foreign/libusb-1.0.20

or replace LIBUSBBASE path in CMakeLists.txt

4) clone https://github.com/hayguen/librtlsdr
or https://github.com/librtlsdr/librtlsdr
at same level as https://github.com/hayguen/rtl_433

5) start qtcreator and open the (modified) CMakeLists.txt
configure compiler/environment and compile


the resulting executable has no relevant dependency at all

# rtl_433 is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# rtl_433 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.

########################################################################
# Project setup
########################################################################
cmake_minimum_required(VERSION 2.8)
project(rtl433 C)

# created and tested with
# Qt 5.6.1 for Windows 32-bit (MinGW 4.9.2) from
# https://www.qt.io/download-open-source/#section-2
#
# and QtCreator 4.1.0
#
# and LibUSB 1.0.20 from
# https://sourceforge.net/projects/libusb/files/
#   libusb-1.0.20.7z
#

# edit this path
SET( LIBUSBBASE C:/src/_foreign/libusb-1.0.20 )

SET( LIBRTLSDRBASE  ../../librtlsdr )

SET( RTL433BASE ../src )

OPTION(RTL_FULL_STATIC_BUILD "Build rtl-tools fully static." OFF)

########################################################################
# Compiler specific setup
########################################################################
if(CMAKE_COMPILER_IS_GNUCC AND (NOT WIN32) OR (WIN32 AND MINGW) )
    ADD_DEFINITIONS(-Wall)
    ADD_DEFINITIONS(-Wextra)
    ADD_DEFINITIONS(-Wno-unused)
    ADD_DEFINITIONS(-Wsign-compare)
#    ADD_DEFINITIONS(-g3 -O0)
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g3 -O0")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -g0 -O2")
    ADD_DEFINITIONS(-std=gnu99)
    #http://gcc.gnu.org/wiki/Visibility
    add_definitions(-fvisibility=hidden)
endif()

if(RTL_FULL_STATIC_BUILD)
    if (WIN32)
        if(MINGW)
            # Special MINGW stuff here
            # see https://cmake.org/pipermail/cmake/2012-September/051970.html
            # see http://stackoverflow.com/questions/13768515/how-to-do-static-linking-of-libwinpthread-1-dll-in-mingw
            set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -static -static-libgcc")
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static -static-libgcc -static-libstdc++")
            set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "${CMAKE_SHARED_LIBRARY_LINK_C_FLAGS} -static -static-libgcc -s")
            set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "${CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS} -static -static-libgcc -static-libstdc++ -s")
        endif()
    endif()
endif()


add_definitions( -DWIN32 -D_WIN32 -DNDEBUG )

########################################################################
# Setup the include and linker paths
########################################################################
include_directories(
	../include
#	${LIBRTLSDR_INCLUDE_DIRS}
	${LIBRTLSDRBASE}/include
	${LIBUSBBASE}/include/libusb-1.0
)

SET( LIBUSB ${LIBUSBBASE}/MinGW32/static/libusb-1.0.a )

SET( RTLLIBFILES
    ${LIBRTLSDRBASE}/include/rtl_tcp.h
    ${LIBRTLSDRBASE}/include/reg_field.h
    ${LIBRTLSDRBASE}/include/rtlsdr_i2c.h

    ${LIBRTLSDRBASE}/src/convenience/convenience.c
    ${LIBRTLSDRBASE}/src/convenience/convenience.h

    ${LIBRTLSDRBASE}/src/getopt/getopt.c
    ${LIBRTLSDRBASE}/src/getopt/getopt.h

    ${LIBRTLSDRBASE}/include/rtl-sdr_export.h
    ${LIBRTLSDRBASE}/include/rtl-sdr.h
    ${LIBRTLSDRBASE}/src/librtlsdr.c

    ${LIBRTLSDRBASE}/include/tuner_e4k.h
    ${LIBRTLSDRBASE}/src/tuner_e4k.c

    ${LIBRTLSDRBASE}/include/tuner_fc0012.h
    ${LIBRTLSDRBASE}/src/tuner_fc0012.c

    ${LIBRTLSDRBASE}/include/tuner_fc0013.h
    ${LIBRTLSDRBASE}/src/tuner_fc0013.c

    ${LIBRTLSDRBASE}/include/tuner_fc2580.h
    ${LIBRTLSDRBASE}/src/tuner_fc2580.c

    ${LIBRTLSDRBASE}/include/tuner_r82xx.h
    ${LIBRTLSDRBASE}/src/tuner_r82xx.c
)

add_executable(rtl_433
	${RTL433BASE}/baseband.c
	${RTL433BASE}/bitbuffer.c
	${RTL433BASE}/data.c
	${RTL433BASE}/pulse_demod.c
	${RTL433BASE}/pulse_detect.c
	${RTL433BASE}/rtl_433.c
	${RTL433BASE}/optparse.c
	${RTL433BASE}/util.c

	${RTL433BASE}/devices/flex.c
	${RTL433BASE}/devices/acurite.c
	${RTL433BASE}/devices/alecto.c
	${RTL433BASE}/devices/ambient_weather.c
	${RTL433BASE}/devices/blyss.c
	${RTL433BASE}/devices/brennenstuhl_rcs_2044.c
	${RTL433BASE}/devices/calibeur.c
	${RTL433BASE}/devices/cardin.c
	${RTL433BASE}/devices/chuango.c
	${RTL433BASE}/devices/current_cost.c
	${RTL433BASE}/devices/danfoss.c
	${RTL433BASE}/devices/dsc.c
	${RTL433BASE}/devices/ec3k.c
	${RTL433BASE}/devices/efergy_e2_classic.c
	${RTL433BASE}/devices/elv.c
	${RTL433BASE}/devices/emontx.c
	${RTL433BASE}/devices/esperanza_ews.c
	${RTL433BASE}/devices/fineoffset.c
	${RTL433BASE}/devices/fineoffset_wh1080.c
	${RTL433BASE}/devices/ft004b.c
	${RTL433BASE}/devices/ge_coloreffects.c
	${RTL433BASE}/devices/generic_remote.c
	${RTL433BASE}/devices/generic_temperature_sensor.c
	${RTL433BASE}/devices/gt_wt_02.c
	${RTL433BASE}/devices/hideki.c
	${RTL433BASE}/devices/ht680.c
	${RTL433BASE}/devices/inovalley-kw9015b.c
	${RTL433BASE}/devices/intertechno.c
	${RTL433BASE}/devices/kedsum.c
	${RTL433BASE}/devices/lacrosse.c
	${RTL433BASE}/devices/lacrosse_TX141TH_Bv2.c
	${RTL433BASE}/devices/lacrossews.c
	${RTL433BASE}/devices/lightwave_rf.c
	${RTL433BASE}/devices/mebus.c
	${RTL433BASE}/devices/newkaku.c
	${RTL433BASE}/devices/nexus.c
	${RTL433BASE}/devices/oil_watchman.c
	${RTL433BASE}/devices/oregon_scientific.c
	${RTL433BASE}/devices/oregon_scientific_v1.c
	${RTL433BASE}/devices/prologue.c
	${RTL433BASE}/devices/rubicson.c
	${RTL433BASE}/devices/silvercrest.c
	${RTL433BASE}/devices/springfield.c
	${RTL433BASE}/devices/steffen.c
	${RTL433BASE}/devices/tfa_twin_plus_30.3049.c
	${RTL433BASE}/devices/tfa_pool_thermometer.c
	${RTL433BASE}/devices/valeo.c
	${RTL433BASE}/devices/waveman.c
	${RTL433BASE}/devices/wg_pb12v1.c
	${RTL433BASE}/devices/wt450.c
	${RTL433BASE}/devices/x10_rf.c
	${RTL433BASE}/devices/s3318p.c
	${RTL433BASE}/devices/akhan_100F14.c
	${RTL433BASE}/devices/quhwa.c
	${RTL433BASE}/devices/proove.c
	${RTL433BASE}/devices/bresser_3ch.c
	${RTL433BASE}/devices/oregon_scientific_sl109h.c
	${RTL433BASE}/devices/steelmate.c
	${RTL433BASE}/devices/schraeder.c
	${RTL433BASE}/devices/elro_db286a.c
	${RTL433BASE}/devices/efergy_optical.c
	${RTL433BASE}/devices/hondaremote.c
	${RTL433BASE}/devices/new_template.c
	${RTL433BASE}/devices/radiohead_ask.c
	${RTL433BASE}/devices/kerui.c
	${RTL433BASE}/devices/fineoffset_wh1050.c
	${RTL433BASE}/devices/honeywell.c
	${RTL433BASE}/devices/maverick_et73x.c
	${RTL433BASE}/devices/rftech.c
	${RTL433BASE}/devices/lacrosse_tx35.c
	${RTL433BASE}/devices/vaillant_vrt340f.c
	${RTL433BASE}/devices/ibis_beacon.c
	${RTL433BASE}/devices/oil_standard.c
	${RTL433BASE}/devices/tpms_citroen.c
	${RTL433BASE}/devices/thermopro_tp11.c
	${RTL433BASE}/devices/solight_te44.c
	${RTL433BASE}/devices/smoke_gs558.c
	${RTL433BASE}/devices/generic_motion.c
	${RTL433BASE}/devices/tpms_toyota.c
	${RTL433BASE}/devices/tpms_ford.c
	${RTL433BASE}/devices/tpms_renault.c
	${RTL433BASE}/devices/infactory.c
	${RTL433BASE}/devices/fordremote.c
	${RTL433BASE}/devices/philips.c
	${RTL433BASE}/devices/nexa.c
	${RTL433BASE}/devices/thermopro_tp12.c
	${RTL433BASE}/devices/x10_sec.c
	${RTL433BASE}/devices/interlogix.c
	${RTL433BASE}/devices/dish_remote_6_3.c

	${RTLLIBFILES}
)

# add_library(data data.c)

target_link_libraries(rtl_433
#	${LIBRTLSDR_LIBRARIES}
	${LIBUSB}
	${CMAKE_THREAD_LIBS_INIT}
)

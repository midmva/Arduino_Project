import qbs
import qbs.FileInfo

Project{
    CppApplication {
        name: "Arduino Due"
        type: "application" // To suppress bundle generation on Mac
        consoleApplication: true
        Depends { name: "cpp" }
        cpp.executableSuffix: ".elf"
        cpp.compilerName: ["arm-none-eabi-g++"]
        cpp.compilerPath: ["/opt/Arduino/hardware/tools/arm-none-eabi-gcc/bin/arm-none-eabi-g++.exe"]
        cpp.linkerName: ["arm-none-eabi-g++"]
        cpp.linkerPath: ["/opt/Arduino/hardware/tools/arm-none-eabi-gcc/bin/arm-none-eabi-g++.exe"]
        cpp.includePaths: [
            "src",
            "/opt/Arduino/hardware/arduino/sam/system/libsam/",
            "/opt/Arduino/hardware/arduino/sam/system/CMSIS/CMSIS/Include/",
            "/opt/Arduino/hardware/arduino/sam/system/CMSIS/Device/ATMEL/",
            "/opt/Arduino/hardware/arduino/sam/cores/arduino",
            "/opt/Arduino/hardware/arduino/sam/variants/arduino_due_x",
            "/opt/Arduino/hardware/arduino/sam/libraries/SPI",
            "/opt/Arduino/hardware/arduino/sam/cores/arduino/avr"
        ]
        cpp.defines: [
            "-Dprintf=iprintf",
            "-DF_CPU=84000000L",
            "-DARDUINO=152",
            "-D__SAM3X8E__",
            "-DUSB_PID=0x003e",
            "-DUSB_VID=0x2341",
            "-DUSBCON"
        ]
        cpp.architecture: "arm"
        cpp.cxxFlags: [
            "-g",
            "-Os",
            "-w",
            "-ffunction-sections",
            "-fdata-sections",
            "-nostdlib",
            "--param max-inline-insns-single=500",
            "-mcpu=cortex-m3",
            "-mthumb",
            "-fno-rtti",
            "-fno-exceptions"
        ]
        //        $(TMPDIR)/$(PROJNAME).elf:
        //            $(TMPDIR)/core.a $(TMPDIR)/core/syscalls_sam3.c.o $(MYOBJFILES)
        //            $(CXX) -Os -Wl,
        //            -T$(HWDIR)/$(SAM)/variants/arduino_due_x/linker_scripts/gcc/flash.ld
        //            -Wl,-Map,$(NEWMAINFILE).map -o $@
        //            -L$(TMPDIR) -lm -lgcc -mthumb -Wl,--cref -Wl,--check-sections
        //            -Wl,--gc-sections -Wl,--entry=Reset_Handler -Wl,--unresolved-symbols=report-all
        //            -Wl,--warn-common -Wl,--warn-section-align -Wl,--warn-unresolved-symbols
        //            -Wl,
        //            --start-group
        //            $(TMPDIR)/core/syscalls_sam3.c.o $(MYOBJFILES)
        //            $(HWDIR)/$(SAM)/variants/arduino_due_x/libsam_sam3x8e_gcc_rel.a $(TMPDIR)/core.a -Wl,
        //            --end-group
        cpp.linkerFlags: [
            "-Os -Wl -Map",
            "main.map -o $@",
            "--gc-sections -mcpu=cortex-m3",
            "-mthumb -lm -lgcc, -Wl",
            "--cref -Wl",
            "--check-sections -Wl",
            "--unresolved-symbols=report-all -Wl",
            "--gc-sections -Wl",
            "--entry=Reset_Handler -Wl",
            "--warn-common -Wl",
            "--warn-section-align -Wl",
            "--warn-unresolved-symbols -Wl",
            "-mabi=aapcs",
            "-L", "C:/Users/thutt/nRF51_Template/nrf51822/Source/templates/gcc/",
            "-T/opt/Arduino/hardware/arduino/sam/variants/arduino_due_x/linker_scripts/gcc/flash.ld"
        ]



        Group {     // Properties for the produced executable
            fileTagsFilter: product.type
            qbs.install: true
        }

        Properties  {
            condition: cpp.debugInformation
            cpp.defines: outer.concat("DEBUG")
        }
        //path in project
        Group {
            name: "sources"
            prefix: "src/"
            files: [
                "*.c",
                "*.cpp",
                "*.h",
                "*.s"
            ]
            cpp.cxxFlags: [ "-std=c++11" ]
            cpp.cFlags: [ "-std=gnu99" ]
            cpp.warningLevel: "all"
        }

        cpp.commonCompilerFlags: [
            "-mcpu=cortex-m4",
            "-mthumb",
            "-mfpu=fpv4-sp-d16",
            "-mfloat-abi=softfp"
        ]
    }
}





//===-- ARMMCTargetDesc.h - ARM Target Descriptions -------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file provides ARM specific target descriptions.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_ARM_MCTARGETDESC_ARMMCTARGETDESC_H
#define LLVM_LIB_TARGET_ARM_MCTARGETDESC_ARMMCTARGETDESC_H

#include "llvm/Support/DataTypes.h"
#include <string>

namespace llvm {
class formatted_raw_ostream;
class MCAsmBackend;
class MCCodeEmitter;
class MCContext;
class MCInstrInfo;
class MCInstPrinter;
class MCObjectWriter;
class MCRegisterInfo;
class MCSubtargetInfo;
class MCStreamer;
class MCRelocationInfo;
class StringRef;
class Target;
class raw_ostream;

extern Target TheARMLETarget, TheThumbLETarget;
extern Target TheARMBETarget, TheThumbBETarget;

namespace ARM_MC {

  // Krait Integer and NEON/VFP Pipelines
  // L Integer Load Pipeline
  // S Integer Store Pipeline
  // X_Y_M_B_Z: Integer Execute Pipelines
  // B Integer Execute Pipeline
  // Z Integer Execute Pipeline
  // VL VFP/NEON Load, Permute and MOV Pipeline
  // VS VFP/NEON Store and MOV Pipeline
  // VX VFP/NEON Execute Pipeline

  typedef enum {
    PipeType_Unknown,


    // Krait
    PipeType_Krait_L,
    PipeType_Krait_S,
    PipeType_Krait_X_Y_M_B_Z,
    PipeType_Krait_VL,
    PipeType_Krait_VS,
    PipeType_Krait_VX
  } PipeType;


  // Returns an instruction pipe affinity given the
  // instruction itinerary units in Krait2.
  PipeType getKrait2PipeType(unsigned Units);

  // Returns the number of different execution pipelines
  // used by the instruction itinerary units in Krait2.
  unsigned int getKrait2PipeCount(unsigned Units);

  std::string ParseARMTriple(StringRef TT, StringRef CPU);

  /// createARMMCSubtargetInfo - Create a ARM MCSubtargetInfo instance.
  /// This is exposed so Asm parser, etc. do not need to go through
  /// TargetRegistry.
  MCSubtargetInfo *createARMMCSubtargetInfo(StringRef TT, StringRef CPU,
                                            StringRef FS);
}

MCStreamer *createMCAsmStreamer(MCContext &Ctx, formatted_raw_ostream &OS,
                                bool isVerboseAsm, bool useDwarfDirectory,
                                MCInstPrinter *InstPrint, MCCodeEmitter *CE,
                                MCAsmBackend *TAB, bool ShowInst);

MCStreamer *createARMNullStreamer(MCContext &Ctx);

MCCodeEmitter *createARMLEMCCodeEmitter(const MCInstrInfo &MCII,
                                        const MCRegisterInfo &MRI,
                                        const MCSubtargetInfo &STI,
                                        MCContext &Ctx);

MCCodeEmitter *createARMBEMCCodeEmitter(const MCInstrInfo &MCII,
                                        const MCRegisterInfo &MRI,
                                        const MCSubtargetInfo &STI,
                                        MCContext &Ctx);

MCAsmBackend *createARMAsmBackend(const Target &T, const MCRegisterInfo &MRI,
                                  StringRef TT, StringRef CPU,
                                  bool IsLittleEndian);

MCAsmBackend *createARMLEAsmBackend(const Target &T, const MCRegisterInfo &MRI,
                                  StringRef TT, StringRef CPU);

MCAsmBackend *createARMBEAsmBackend(const Target &T, const MCRegisterInfo &MRI,
                                  StringRef TT, StringRef CPU);

MCAsmBackend *createThumbLEAsmBackend(const Target &T, const MCRegisterInfo &MRI,
                                      StringRef TT, StringRef CPU);

MCAsmBackend *createThumbBEAsmBackend(const Target &T, const MCRegisterInfo &MRI,
                                      StringRef TT, StringRef CPU);

/// createARMWinCOFFStreamer - Construct a PE/COFF machine code streamer which
/// will generate a PE/COFF object file.
MCStreamer *createARMWinCOFFStreamer(MCContext &Context, MCAsmBackend &MAB,
                                     MCCodeEmitter &Emitter, raw_ostream &OS);

/// createARMELFObjectWriter - Construct an ELF Mach-O object writer.
MCObjectWriter *createARMELFObjectWriter(raw_ostream &OS,
                                         uint8_t OSABI,
                                         bool IsLittleEndian);

/// createARMMachObjectWriter - Construct an ARM Mach-O object writer.
MCObjectWriter *createARMMachObjectWriter(raw_ostream &OS,
                                          bool Is64Bit,
                                          uint32_t CPUType,
                                          uint32_t CPUSubtype);

/// createARMWinCOFFObjectWriter - Construct an ARM PE/COFF object writer.
MCObjectWriter *createARMWinCOFFObjectWriter(raw_ostream &OS, bool Is64Bit);

/// createARMMachORelocationInfo - Construct ARM Mach-O relocation info.
MCRelocationInfo *createARMMachORelocationInfo(MCContext &Ctx);
} // End llvm namespace

// Defines symbolic names for ARM registers.  This defines a mapping from
// register name to register number.
//
#define GET_REGINFO_ENUM
#include "ARMGenRegisterInfo.inc"

// Defines symbolic names for the ARM instructions.
//
#define GET_INSTRINFO_ENUM
#include "ARMGenInstrInfo.inc"

#define GET_SUBTARGETINFO_ENUM
#include "ARMGenSubtargetInfo.inc"

#endif

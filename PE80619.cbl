      *SKEL-WRITTEN.  SKEL BATCH  24 ENERO 2025.      V03.01
      *=================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID.   PE80619.
      *AUTHOR.       DID.
      *DATE-WRITTEN.
      *     PE80619 Generado el 24/01/2025 por GenSKL V03.3.
      *=================================================================
      *=================================================================
      *= APLICACION: PE                                                =
      *=================================================================
      *=                                                               =
      *= PROGRAMA:        PE89945                                      =
      *= FECHA CREACION:  24-01-2025                                   =
      *=                                                               =
      *= DESCRIPCION   :  BUSCAR TODAS LAS RELACIONES QUE TIENEN POR-  =
      *=                  CERNTAJE EN ACCIONES SUPERIOR A LA INDICADA  =
      *=                  EN LA TPA EE003, O EN SU DEFECTO UN 25%, Y SI=
      *=                  NO SE ENCUENTRA LAS RELACIONES QUE TENGA EL  =
      *=                  INDICADOR DE FIRMA A "S"                     =
      *=================================================================
      *= TABLAS/VISTAS    DESCRIPCION DE LA TABLA/VISTA UTILIZADA      =
      *= --------------  --------------------------------------------- =
      *=                                                               =
      *=================================================================
      *= PROGRAMAS/RUTINAS DESCRIPCION DEL PROGRAMA/RUTINA UTILIZADO   =
      *= ----------------- ------------------------------------------- =
      *=                                                               =
      *=================================================================
      *= FICHERO   COPYBOOK  DESCRIPCION                               =
      *= --------  --------  ----------------------------------------- =
      *= PE0001R                                                       =
      *= PE0001W                                                       =
      *=                                                               =
      *=================================================================
      *= HISTORICO DE CAMBIOS                                          =
      *= ----------------------------------------------------------    =
      *= FECHA    COD.CAMBIO   RESPONSABLE   DESCRIPCION DEL CAMBIO    =
      *= -------- ------------ ------------- ----------------------    =
      **                                                               s
      *=                                                               =
      *=================================================================
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.   IBM-zSeries.
       OBJECT-COMPUTER.   IBM-zSeries.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT PE0001R  ASSIGN TO  PE0001R
                  ORGANIZATION SEQUENTIAL
                  ACCESS       SEQUENTIAL
                  FILE STATUS FS-PE0001R.

           SELECT PE0001W  ASSIGN TO  PE0001W
                  ORGANIZATION SEQUENTIAL
                  ACCESS       SEQUENTIAL
                  FILE STATUS FS-PE0001W.


      *=================================================================
       DATA DIVISION.

      *=================================================================
       FILE SECTION.
      *=================================================================

       FD  PE0001R     BLOCK CONTAINS 0 CHARACTERS
                        RECORDING MODE F
                        LABEL RECORDS STANDARD.
       01  REG-1R                  PIC  X(101).
      *
       FD  PE0001W     BLOCK CONTAINS 0 CHARACTERS
                        RECORDING MODE F
                        LABEL RECORDS STANDARD.
       01  REG-1W                  PIC  X(101).


      *=================================================================
       WORKING-STORAGE SECTION.
      *=================================================================
      * LITERALES SIGNIFICATIVOS (EVITAR NUMEROS GENERALES)
      *
       77  WLT-MODULO         PIC X(8)   VALUE 'PE80619'.
       77  WLT-WARNING        PIC X      VALUE 'W'.
       77  WLT-ERROR          PIC X      VALUE 'E'.
       77  WLT-FATAL          PIC X      VALUE 'F'.
       77  WLT-RAYAS          PIC X(120) VALUE ALL '-'.
       77  WLT-S              PIC X      VALUE 'S'.
       77  WLT-N              PIC X      VALUE 'N'.
       77  WLT-FECHA-MAX      PIC X(10)  VALUE '9999-12-31'.
      *
       77  WLT-SOC-INTERMEDIA-ACC       PIC S9(4) COMP VALUE 41.
       77  WLT-ACCIONISTA-DIR           PIC S9(4) COMP VALUE 56.
       77  WLT-ACCIONISTA-IND           PIC S9(4) COMP VALUE 57.
       77  WLT-ULTIMO-BENEFICIARIO      PIC S9(4) COMP VALUE 58.
       77  WLT-ADMINISTRADOR            PIC S9(4) COMP VALUE 59.
      *@M001-I
      *77  WLT-DIRECTOR-GENERAL         PIC S9(4) COMP VALUE 60.
       77  WLT-DIRECTOR-GENERAL         PIC S9(4) COMP VALUE 80.
      *77  WLT-CONSEJERO                PIC S9(4) COMP VALUE 61.
       77  WLT-CONSEJERO                PIC S9(4) COMP VALUE 81.
      *77  WLT-CONSEJERO-DELEGADO       PIC S9(4) COMP VALUE 62.
       77  WLT-CONSEJERO-DELEGADO       PIC S9(4) COMP VALUE 82.
      *77  WLT-PRESIDENTE               PIC S9(4) COMP VALUE 63.
       77  WLT-PRESIDENTE               PIC S9(4) COMP VALUE 83.
      *77  WLT-PATRONO                  PIC S9(4) COMP VALUE 64.
       77  WLT-PATRONO                  PIC S9(4) COMP VALUE 84.
      *77  WLT-INTERVENTOR              PIC S9(4) COMP VALUE 65.
       77  WLT-INTERVENTOR              PIC S9(4) COMP VALUE 85.
      *77  WLT-COMUNERO                 PIC S9(4) COMP VALUE 66.
       77  WLT-COMUNERO                 PIC S9(4) COMP VALUE 86.
      *77  WLT-ALCALDE                  PIC S9(4) COMP VALUE 67.
       77  WLT-ALCALDE                  PIC S9(4) COMP VALUE 87.
      *77  WLT-FIDEICOMITENTE           PIC S9(4) COMP VALUE 68.
       77  WLT-FIDEICOMITENTE           PIC S9(4) COMP VALUE 74.
      *77  WLT-FIDUCIARIO               PIC S9(4) COMP VALUE 59.
       77  WLT-FIDUCIARIO               PIC S9(4) COMP VALUE 75.
      *77  WLT-FIDEICOMISARIO           PIC S9(4) COMP VALUE 70.
       77  WLT-FIDEICOMISARIO           PIC S9(4) COMP VALUE 76.
      *77  WLT-PROTECTOR                PIC S9(4) COMP VALUE 71.
       77  WLT-PROTECTOR                PIC S9(4) COMP VALUE 77.
      *@M001-F
      *
      *-----------------------------------------------------------------
      * INDICADORES  SWITCHES (OPTIMO 1 BYTE)
      *
       01  W-SWITCHES.
           05  SW-TRATAMIENTO        PIC X.
               88  FIN-TRATAMIENTO-NO   VALUE 'N'.
               88  FIN-TRATAMIENTO      VALUE 'S'.
           05  SW-FIN-CURSOR-TRE-EA  PIC X.
               88  NO-FIN-CURSOR-TRE-EA VALUE 'N'.
               88  SI-FIN-CURSOR-TRE-EA VALUE 'S'.
           05  SW-TITULAR-REAL       PIC X.
               88  NO-TITULAR-REAL      VALUE 'N'.
               88  SI-TITULAR-REAL      VALUE 'S'.
           05  SW-RELACION-TRE       PIC X.
               88  NO-RELACION-TRE      VALUE 'N'.
               88  SI-RELACION-TRE      VALUE 'S'.
           05  SW-SALIDA-LIMPIA       PIC X.
               88  NO-SALIDA-LIMPIA      VALUE 'N'.
               88  SI-SALIDA-LIMPIA      VALUE 'S'.
           05  SW-CLASIFICA-PORC       PIC X.
               88  NO-CLASIFICA-PORC      VALUE 'N'.
               88  SI-CLASIFICA-PORC      VALUE 'S'.
      *
      *-----------------------------------------------------------------
      * VARIABLES DE TRABAJO
       01 W-FECHA-CORTE.
          05 W-FECHA-ALTA OCCURS 200 TIMES PIC X(10).
          05 W-FECHA-BAJA OCCURS 200 TIMES PIC X(10).

       01 W-SUMA-ACTUAL     PIC S9(9)V99 COMP-3.
       01 W-SOLAPA          PIC X VALUE 'N'.
       01 W-FECALTA         PIC X(10).
       01 W-FECBAJA         PIC X(10).

       01  W-VARIABLES.
           05 W-INDEX                PIC 9(2) COMP.
           05 W-I1                   PIC 9(2) COMP.
           05 W-I2                   PIC 9(2) COMP.
           05 W-C1                   PIC 9(3) COMP.
           05 W-C2                   PIC 9(3) COMP.
           05 W-PORCENTMIN           PIC S9(3) COMP-3.
           05 W-BS8500P-SAL          PIC X(769).
           05 W-CODRELPEPE-1         PIC S9(4) COMP.
           05 W-CODRELPEPE-2         PIC S9(4) COMP.
           05 W-CODRELPEPE-3         PIC S9(4) COMP.
           05 W-CODRELPEPE-4         PIC S9(4) COMP.
           05 W-CODRELPEPE-5         PIC S9(4) COMP.
           05 W-FECHA-1               PIC X(10).
           05 W-FECHA-2               PIC X(10).
           05 W-FECHA-3               PIC X(10).
           05 W-FECHA-4               PIC X(10).
           05 W-FEC-ALTA               PIC X(10).
           05 W-FEC-BAJA               PIC X(10).
           05 W-TRE-TIPO.
              10 W-TRE-TIPO-N        PIC 9.
           05 WS-PE8062I.
             07 WS-PE8062I-NUMPERSEMP PIC S9(9) COMP.
             07 WS-PE8062I-NUMPERSACC PIC S9(9) COMP.
             07 WS-PE8062I-NUMPERSNIV PIC S9(9) COMP.
             07 WS-PE8062I-CODRELPEPE PIC S9(4) COMP.
             07 WS-PE8062I-TMSTALTA  PIC X(26).
             07 WS-PE8062I-NIVELACC  PIC S9(3) COMP-3.
             07 WS-PE8062I-PORPARTEMP PIC S9(3)V99 COMP-3.
             07 WS-PE8062I-FECALTA   PIC X(10).
             07 WS-PE8062I-FECBAJA   PIC X(10).
             07 WS-PE8062I-FECULTACT PIC X(10).
             07 WS-PE8062I-HORULTACT PIC X(8).
             07 WS-PE8062I-CODTERMINA PIC X(8).
             07 WS-PE8062I-CODUSUARIO PIC X(8).
             07 WS-PE8062I-ORDEN    PIC 9(2).

           05 WSS-PE8062O.
             07 WSS-PE8062O-NUMPERSEMP PIC S9(9) COMP.
             07 WSS-PE8062O-NUMPERSACC PIC S9(9) COMP.
             07 WSS-PE8062O-NUMPERSNIV PIC S9(9) COMP.
             07 WSS-PE8062O-CODRELPEPE PIC S9(4) COMP.
             07 WSS-PE8062O-TMSTALTA  PIC X(26).
             07 WSS-PE8062O-NIVELACC  PIC S9(3) COMP-3.
             07 WSS-PE8062O-PORPARTEMP PIC S9(3)V99 COMP-3.
             07 WSS-PE8062O-FECALTA   PIC X(10).
             07 WSS-PE8062O-FECBAJA   PIC X(10).
             07 WSS-PE8062O-FECULTACT PIC X(10).
             07 WSS-PE8062O-HORULTACT PIC X(8).
             07 WSS-PE8062O-CODTERMINA PIC X(8).
             07 WSS-PE8062O-CODUSUARIO PIC X(8).
             07 WSS-PE8062O-ORDEN   PIC 9(2).

           05 WS1-PE8062I.
             07 WS1-PE8062I-NUMPERSEMP PIC 9(9).
             07 WS1-PE8062I-NUMPERSACC PIC 9(9).
             07 WS1-PE8062I-NUMPERSNIV PIC 9(9).
             07 WS1-PE8062I-CODRELPEPE PIC 9(4).
             07 WS1-PE8062I-TMSTALTA  PIC X(26).
             07 WS1-PE8062I-NIVELACC  PIC  9(3).
             07 WS1-PE8062I-PORPARTEMP PIC 9(3)V99.
             07 WS1-PE8062I-FECALTA   PIC X(10).
             07 WS1-PE8062I-FECBAJA   PIC X(10).
             07 WS1-PE8062I-FECULTACT PIC X(10).
             07 WS1-PE8062I-HORULTACT PIC X(8).
             07 WS1-PE8062I-CODTERMINA PIC X(8).
             07 WS1-PE8062I-CODUSUARIO PIC X(8).
             07 WS1-PE8062I-ORDEN   PIC 9(2).

             05 TITREA-1 OCCURS 5000 TIMES.
               07 T1R-PE8062I-NUMPERSEMP PIC S9(9) COMP.
               07 T1R-PE8062I-NUMPERSACC PIC S9(9) COMP.
               07 T1R-PE8062I-NUMPERSNIV PIC S9(9) COMP.
               07 T1R-PE8062I-CODRELPEPE PIC S9(4) COMP.
               07 T1R-PE8062I-TMSTALTA   PIC X(26).
               07 T1R-PE8062I-NIVELACC   PIC S9(3) COMP-3.
               07 T1R-PE8062I-PORPARTEMP PIC S9(3)V99 COMP-3.
               07 T1R-PE8062I-FECALTA    PIC X(10).
               07 T1R-PE8062I-FECBAJA    PIC X(10).
               07 T1R-PE8062I-FECULTACT  PIC X(10).
               07 T1R-PE8062I-HORULTACT  PIC X(8).
               07 T1R-PE8062I-CODTERMINA PIC X(8).
               07 T1R-PE8062I-CODUSUARIO PIC X(8).
               07 T1R-PE8062I-ORDEN PIC 9(2).

             05 TITREA-SAL OCCURS 5000 TIMES.
               07 SAL-PE8062I-NUMPERSEMP PIC S9(9) COMP.
               07 SAL-PE8062I-NUMPERSACC PIC S9(9) COMP.
               07 SAL-PE8062I-NUMPERSNIV PIC S9(9) COMP.
               07 SAL-PE8062I-CODRELPEPE PIC S9(4) COMP.
               07 SAL-PE8062I-TMSTALTA   PIC X(26).
               07 SAL-PE8062I-NIVELACC   PIC S9(3) COMP-3.
               07 SAL-PE8062I-PORPARTEMP PIC S9(3)V99 COMP-3.
               07 SAL-PE8062I-FECALTA    PIC X(10).
               07 SAL-PE8062I-FECBAJA    PIC X(10).
               07 SAL-PE8062I-FECULTACT  PIC X(10).
               07 SAL-PE8062I-HORULTACT  PIC X(8).
               07 SAL-PE8062I-CODTERMINA PIC X(8).
               07 SAL-PE8062I-CODUSUARIO PIC X(8).
               07 SAL-PE8062I-ORDEN PIC 9(2).

             05 T1R                      PIC 9(4) COMP-3 VALUE ZEROS.
             05 DIFERENTE                PIC 9    COMP-3 VALUE ZEROS.
             05 CON-56-57-58             PIC 9(4) COMP-3 VALUE ZEROS.
             05 CON-59                   PIC 9(4) COMP-3 VALUE ZEROS.
             05 VEZ                      PIC 9(4) COMP-3 VALUE ZEROS.
             05 VECES                    PIC 9(4) COMP-3 VALUE ZEROS.
             05 VECES2                   PIC 9(4) COMP-3 VALUE ZEROS.
             05 ITERO                    PIC 9(5) COMP-3 VALUE ZEROS.
             05 SALIR                    PIC 9(2) COMP-3 VALUE ZEROS.
             05 VALIDA                   PIC 9(5) COMP-3 VALUE ZEROS.
             05 REG-EN-TABLA             PIC 9(4) COMP-3 VALUE ZEROS.
             05 CONTADOR-59              PIC 9(4) COMP-3 VALUE ZEROS.

           05 WS-FECHA-ALTA.
             07 WS-FECHA-ALTA-ANIO   PIC 9999.
             07 FILLER               PIC X.
             07 WS-FECHA-ALTA-MES    PIC 99.
             07 FILLER               PIC X.
             07 WS-FECHA-ALTA-DIA    PIC 99.

           05 WS-FECHA-BAJA.
             07 WS-FECHA-BAJA-ANIO   PIC 9999.
             07 FILLER               PIC X.
             07 WS-FECHA-BAJA-MES    PIC 99.
             07 FILLER               PIC X.
             07 WS-FECHA-BAJA-DIA    PIC 99.
      *
       01  W-TABLA-TRE-EA.
           05 W-TAB-TRE-EA OCCURS 10 TIMES.
              10 W-REG-TRE-TIPO         PIC 9.
              10 W-REG-INDEX            PIC S9 COMP.
              10 W-REG-CODRELPEPE-1     PIC S9(4) COMP.
              10 W-REG-CODRELPEPE-2     PIC S9(4) COMP.
              10 W-REG-CODRELPEPE-3     PIC S9(4) COMP.
              10 W-REG-CODRELPEPE-4     PIC S9(4) COMP.
              10 W-REG-CODRELPEPE-5     PIC S9(4) COMP.
              10 W-TAB-REG-TRE-EA.
                 15 W-REG-TRE-IND          PIC S99 COMP.
                 15 W-REG-TRE-EA OCCURS 50 TIMES.
                    20 W-NUMPERSACC-TRE    PIC S9(9) COMP.
                    20 W-PORPARTEMP-TRE    PIC S9(03)V9(02) COMP-3.
      *
       01  W-TABLA-ESTRUC.
           05 W-REG-ESTRUC OCCURS 100 TIMES.
              10 W-EETP004-CODRELPE  PIC 9(03).
              10 W-EETP004-INPOROBL  PIC X(01).
              10 W-EETP004-INCOMPOR  PIC X(01).
              10 W-EETP004-INFIRDOC  PIC X(01).
              10 W-EETP004-INESTFID  PIC X(01).
      *

       01  W-FECHA.
           05 W-FECHA1               PIC 9(8).
           05 W-FEC1  REDEFINES W-FECHA1.
              07 W-ANY1              PIC 9(4).
              07 W-MES1              PIC 9(2).
              07 W-DIA1              PIC 9(2).
           05 W-FECHA2               PIC 9(8).
           05 W-FEC2  REDEFINES W-FECHA2.
              07 W-ANY2              PIC 9(4).
              07 W-MES2              PIC 9(2).
              07 W-DIA2              PIC 9(2).
      *
       01  W-CLAVE.
           05 W-NUMPERSEMP-ANT       PIC S9(9) COMP.
           05 W-NUMPERSACC-ANT       PIC S9(9) COMP.
      *
       01  WS-SUMA                   PIC S9(10)V99 COMP.
      *
       01  DATA-PROCESS.
           05 W-DATA-PROCESS         PIC  9.
      *
       01  EDITABLES.
           05 W-SQLCODE              PIC ---9.
           05 W-NUMPERSEMP           PIC 9(9).
      *
      *-----------------------------------------------------------------
      * CAMPOS ESPECIALES PARA RUTINAS
      *
       77  CTRL-DISPL          PIC S9(9) COMP-5 VALUE 0.
       77  CTRL-FREQ-DISPL     PIC S9(9) COMP-5 VALUE 0.
      *
       77  SKLAUX3             PIC S9(15)  COMP-3 VALUE 0.
       77  SKLAUX5             PIC S9(9)   COMP-5 VALUE 0.
       77  WRC                 PIC S9(4)   COMP-5 VALUE 0.
       77  MEM-NUM-ERROR       PIC 9(5)    VALUE ZEROES.
       77  MEM-TIPO-ERROR      PIC X       VALUE SPACES.
       01  MEM-OTROS-DATOS     PIC X(159)  VALUE SPACES.
      *
      * Rutina general de mensajes
      * MEM-PARRAFO Substituido por MEMSG-LBL
      *
       77  R-MEMSGM            PIC X(8)    VALUE 'MEMSGM'.
           COPY MEMSGP.
      *
      *-----------------------------------------------------------------
      * Fecha hora de AHORA.  TIME LOCAL, TIME GTM/UT
      *
       77  R-AHTOD            PIC X(8) VALUE 'AHTOD'.
       77  SKL-TODOPC         PIC X(3) VALUE 'TST'.
      *                                VALUE 'TDX'.   GTM/UT
       01  AHTODP.
           02  AHTOD-TOD      PIC 9(15)  COMP-5.
           02  FILLER         PIC X.
           02  AHTOD-AD       PIC S9(7)  COMP-3.
           02  AHTOD-OPC      PIC X(3).
           02  AHTOD-HMS      PIC S9(12) COMP-3.
           02  FILLER         PIC X.
           02  AHTOD-AMD      PIC S9(8)  COMP-3.
           02  FILLER         PIC XXX.
           02  FILLER         PIC X(48).
      *-----------------------------------------------------------------
      * timestamp
      *
       01  SKLTMSTP.
           02  SKLJA2      PIC 9999.99.99.
           02  FILLER      PIC X  VALUE '-'.
           02  SKLJA3      PIC 99.99.99.999999.
      *
       01  SKLCURDAT.
           02  SKLFECHA    PIC 9(8).
           02  SKLFECHAR   REDEFINES SKLFECHA.
               03  SKLCC   PIC 99.
               03  SKLAA   PIC 99.
               03  SKLMM   PIC 99.
               03  SKLDD   PIC 99.
           02  SKLFECHAR2  REDEFINES SKLFECHA.
               03  SKLAAAA PIC 9(4).
               03  SKLMMDD PIC 9(4).
      *
           02  SKLHORACNU  PIC 9(12).
           02  SKLHORACNUR REDEFINES SKLHORACNU.
               03  SKLHORA PIC 9(8).
               03  FILLER  PIC 9(4).
           02  SKLHORACNU2 REDEFINES SKLHORACNU.
               03  SKLHOR  PIC 99.
               03  SKLMIN  PIC 99.
               03  SKLSEG  PIC 99.
               03  SKLCNU  PIC 9(6).
      *
      *-----------------------------------------------------------------
      *-----------------------------------------------------------------
       77  WLT-LEIDOS          PIC X(10)  VALUE 'LEIDOS    '.
       77  WLT-REGEE02         PIC X(10)  VALUE 'TAB-EE02: '.
       77  WLT-GRABADOS        PIC X(10)  VALUE 'GRABADOS  '.
      *
       77  WLT-INSERTS         PIC X(10)  VALUE 'Inserts   '.
       77  WLT-DELETES         PIC X(10)  VALUE 'Deletes   '.
       77  WLT-UPDATES         PIC X(10)  VALUE 'Updates   '.
      *
       77  WLT-INSERTS-RB      PIC X(10)  VALUE 'Ins.Rback '.
       77  WLT-DELETES-RB      PIC X(10)  VALUE 'Del.Rback '.
       77  WLT-UPDATES-RB      PIC X(10)  VALUE 'Upd.Rback '.
      *
       01  WRK-DISP-GEN.
           02  WRK-DISP-WLT    PIC X(10).
           02  WRK-DISP-REG    PIC Z(09)9.

       01  WS-FIN-ENTRADA      PIC 9(01)  VALUE ZEROS.
       01  WS-BUCLE-10         PIC 9(02)  VALUE ZEROS.
       01  REG-ESCRITO         PIC 9(01)  VALUE ZEROS.
       01  CONTADORES.
           03  REG-LEIDOS      PIC 9(10)  COMP VALUE ZEROS.
           03  REG-ESCRITOS    PIC 9(10)  COMP VALUE ZEROS.
           03  REG-TOTAL       PIC Z.ZZZ.ZZZ.ZZ9.
      *
      *-----------------------------------------------------------------
      * COPYS DE ENTRADA/SALIDA
      *
       01  ENTRADA.
           COPY PE8062I.
       01  SALIDA.
           COPY PE8062O.
      *-----------------------------------------------------------------
      * Working de la FD PE0001R
      *
      *
       01  ARC-PE0001R.
           02  DDN-PE0001R      PIC X(8)  VALUE 'PE0001R'.
           02  DSN-PE0001R      PIC X(44) VALUE SPACES.
           02  MBR-PE0001R      PIC X(8)  VALUE SPACES.
      *
       77  LRG-PE0001R          PIC 9(4) COMP-5 VALUE 0.
       01  WFD-PE0001R.
           02  IDE-PE0001R.
               03  FID-PE0001R  PIC X(8)  VALUE 'PE0001R'.
           02  FS-PE0001R       PIC XX.
           02  FSW-PE0001R      PIC X    VALUE SPACES.
               88  EOF-PE0001R           VALUE 'F' 'I'.
               88  FOK-PE0001R           VALUE 'S' 'N'.
               88  SEL-PE0001R           VALUE 'S'.
               88  NOS-PE0001R           VALUE 'N'.
               88  INK-PE0001R           VALUE 'K'.
               88  MAL-PE0001R           VALUE 'M'.
               88  ERR-PE0001R           VALUE 'M' 'K'.
               88  NOP-PE0001R           VALUE ' '.
               88  IDL-PE0001R           VALUE 'I'.
      *
       77  WCT-RGR-PE0001R      PIC 9(9) COMP-5 VALUE 0.
       77  WCT-RGT-PE0001R      PIC 9(9) COMP-5 VALUE 0.
      *
       77  WEOF-PE0001R   PIC 99 VALUE ZERO.
      *
      *
      *-----------------------------------------------------------------
      * Working de la FD PE0001W
      *
      *
       01  ARC-PE0001W.
           02  DDN-PE0001W      PIC X(8)  VALUE 'PE0001W'.
           02  DSN-PE0001W      PIC X(44) VALUE SPACES.
           02  MBR-PE0001W      PIC X(8)  VALUE SPACES.
      *
       77  LRG-PE0001W          PIC 9(4) COMP-5 VALUE 0.
       01  WFD-PE0001W.
           02  IDE-PE0001W.
               03  FID-PE0001W  PIC X(8)  VALUE 'PE0001W'.
           02  FS-PE0001W       PIC XX.
           02  FSW-PE0001W      PIC X    VALUE SPACES.
               88  EOF-PE0001W           VALUE 'F' 'I'.
               88  FOK-PE0001W           VALUE 'S' 'N'.
               88  SEL-PE0001W           VALUE 'S'.
               88  NOS-PE0001W           VALUE 'N'.
               88  INK-PE0001W           VALUE 'K'.
               88  MAL-PE0001W           VALUE 'M'.
               88  ERR-PE0001W           VALUE 'M' 'K'.
               88  NOP-PE0001W           VALUE ' '.
               88  IDL-PE0001W           VALUE 'I'.
      *
       77  WCT-RGR-PE0001W      PIC 9(9) COMP-5 VALUE 0.
       77  WCT-RGT-PE0001W      PIC 9(9) COMP-5 VALUE 0.
      *
       77  WCT-RGW-PE0001W      PIC 9(9) COMP-5 VALUE 0.
       77  OPN-PE0001W          PIC X    VALUE SPACES.
           88   OPN-EXT-PE0001W    VALUE 'E' 'R'.
      *
      *-----------------------------------------------------------------
      *  Zona de recepcion de parametros  PARM=
      *
       01  SKL-PARM.
           02  SKL1PARM   PIC X(100).
      *
      *-----------------------------------------------------------------
      * CODIGOS DE CONDICION  DB2
      *
      *
       77  CC-DB2-OK                PIC S9(8) COMP-5  VALUE ZEROES.
       77  CC-DB2-END               PIC S9(8) COMP-5  VALUE +100.
       77  CC-DB2-NOEX              PIC S9(8) COMP-5  VALUE +100.
       77  CC-DB2-DUP               PIC S9(8) COMP-5  VALUE -803.
       77  CC-DB2-MASDE1            PIC S9(8) COMP-5  VALUE -811.
       77  CC-DB2-501               PIC S9(8) COMP-5  VALUE -501.
       77  CC-DB2-305               PIC S9(8) COMP-5  VALUE -305.

      *
MOD   *==== ============================================================
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
      *
           PERFORM INICIO.
           PERFORM VARYING WS-BUCLE-10 FROM 1 BY 1
                   UNTIL WS-BUCLE-10 > 10
                      OR WS-FIN-ENTRADA = 1
               PERFORM TRATAMIENTO UNTIL WS-FIN-ENTRADA = 1
                                       OR WS-PE8062I-ORDEN <> WS-BUCLE-10
           END-PERFORM
           PERFORM FIN-PROCESO.

      *=================================================================
      * TRATAMIENTO CENTRAL
      *
       INICIO.
           INITIALIZE W-VARIABLES
           OPEN  INPUT    PE0001R
           IF    FS-PE0001R  NOT EQUAL '00'
                 DISPLAY 'ERROR AL ABRIR ARCHIVO DE ENTRADA ' FS-PE0001R
                 PERFORM ABNORMAL-ENDING
           END-IF
           OPEN  OUTPUT   PE0001W
           IF    FS-PE0001W  NOT EQUAL '00'
                 DISPLAY 'ERROR AL ABRIR ARCHIVO DE SALIDA ' FS-PE0001W
                 PERFORM ABNORMAL-ENDING
           END-IF.
           PERFORM LEE-ENTRADA-1RA.

       TRATAMIENTO.
           MOVE    0             TO   REG-ESCRITO
           MOVE    0             TO   REG-EN-TABLA CON-56-57-58
                                      DIFERENTE
           MOVE    1             TO   T1R VECES

           PERFORM  LLENA-TR1 UNTIL   DIFERENTE       = 1
                              OR      WS-FIN-ENTRADA  = 1

           IF      CON-56-57-58     >    0
                   PERFORM  GRABA-56-57-58
           END-IF

           PERFORM  PREP-T1R        VARYING VECES FROM 1 BY 1
                                    UNTIL VECES > T1R.
      *=================================================================

       PREP-T1R.
           INITIALIZE         TITREA-1(VECES).

      *=================================================================

       LLENA-TR1.
           MOVE REG-1R        TO       TITREA-1(T1R)
           IF   T1R-PE8062I-CODRELPEPE(T1R) = 56
             OR T1R-PE8062I-CODRELPEPE(T1R) = 57
             OR T1R-PE8062I-CODRELPEPE(T1R) = 58
                ADD    1      TO      CON-56-57-58
           END-IF
           IF   T1R-PE8062I-CODRELPEPE(T1R) = 59
                ADD    1      TO      CON-59
           END-IF
           ADD  1             TO      REG-EN-TABLA.
           PERFORM            LEE-ENTRADA-1RA.
           IF   WS-FIN-ENTRADA = 0
                IF WS-PE8062I-NUMPERSEMP = T1R-PE8062I-NUMPERSEMP(T1R)
                AND WS-PE8062I-NUMPERSACC = T1R-PE8062I-NUMPERSACC(T1R)
                   ADD  1             TO      T1R
                ELSE
                   MOVE 1        TO      DIFERENTE
                END-IF
           ELSE
                MOVE    1        TO      DIFERENTE
           END-IF.
      *=================================================================

       GRABA-56-57-58.
           MOVE 1 TO VEZ

           PERFORM VARYING VECES FROM 1 BY 1 UNTIL VECES > T1R
              MOVE T1R-PE8062I-FECALTA(VECES)
                   TO W-FECHA-ALTA(VECES)

              MOVE T1R-PE8062I-FECBAJA(VECES)
                   TO W-FECHA-BAJA(VECES)
           END-PERFORM

           PERFORM VARYING VECES FROM 1 BY 1 UNTIL VECES > T1R

              MOVE T1R-PE8062I-PORPARTEMP(VECES) TO W-SUMA-ACTUAL
              MOVE T1R-PE8062I-FECALTA(VECES)    TO W-FECALTA
              MOVE T1R-PE8062I-FECBAJA(VECES)    TO W-FECBAJA

              IF W-SUMA-ACTUAL > 25
                MOVE TITREA-1(VECES) TO WSS-PE8062O
                MOVE T1R-PE8062I-ORDEN(VECES) TO WSS-PE8062O-ORDEN
                PERFORM ESCRIBE-SALIDA-UNO
              END-IF
              PERFORM VARYING ITERO FROM 1 BY 1 UNTIL ITERO > T1R
                IF ITERO NOT EQUAL VECES
                  IF  W-FECALTA <= T1R-PE8062I-FECBAJA(ITERO)
                  AND W-FECBAJA >= T1R-PE8062I-FECALTA(ITERO)
                    ADD T1R-PE8062I-PORPARTEMP(ITERO) TO W-SUMA-ACTUAL


                    IF T1R-PE8062I-FECALTA(ITERO) >= W-FECALTA
                      MOVE T1R-PE8062I-FECALTA(ITERO) TO W-FECALTA
                    END-IF

                    IF T1R-PE8062I-FECBAJA(ITERO) <= W-FECBAJA
                      MOVE T1R-PE8062I-FECBAJA(ITERO) TO W-FECBAJA
                    END-IF
                  END-IF
                  IF W-SUMA-ACTUAL > 25
                    MOVE TITREA-1(VECES) TO TITREA-SAL(VEZ)
                    MOVE T1R-PE8062I-ORDEN(VECES) TO SAL-PE8062I-ORDEN(VEZ)
                    MOVE W-FECALTA TO SAL-PE8062I-FECALTA(VEZ)
                    MOVE W-FECBAJA TO SAL-PE8062I-FECBAJA(VEZ)
                    MOVE W-SUMA-ACTUAL  TO SAL-PE8062I-PORPARTEMP(VEZ)
                    PERFORM ESCRIBE-SALIDA
                    MOVE T1R-PE8062I-FECALTA(VECES)    TO W-FECALTA
                    MOVE T1R-PE8062I-FECBAJA(VECES)    TO W-FECBAJA
                    MOVE T1R-PE8062I-PORPARTEMP(VECES) TO W-SUMA-ACTUAL
                    ADD 1 TO VEZ
                  END-IF
                END-IF
              END-PERFORM
           END-PERFORM.

      *=================================================================


      *=================================================================

       VALIDA-EMPRESA-PERSONA.

           IF  PE8062I-FECALTA   <=    WS-PE8062I-FECALTA
VMRG       AND PE8062I-FECBAJA    >    WS-PE8062I-FECALTA
               MOVE PE8062I-FECALTA TO WS-PE8062I-FECALTA
           END-IF
      **
VMRG       IF  PE8062I-FECALTA   <     WS-PE8062I-FECBAJA
           AND PE8062I-FECBAJA    >    WS-PE8062I-FECBAJA
               MOVE PE8062I-FECBAJA TO WS-PE8062I-FECBAJA
           END-IF.
      *

       ESCRIBE-SALIDA.
           MOVE    SPACES   TO REG-1W.
           WRITE   REG-1W FROM TITREA-SAL(VEZ)
           ADD     1        TO REG-ESCRITOS.

       ESCRIBE-SALIDA-UNO.
           MOVE    SPACES   TO REG-1W.
           WRITE   REG-1W FROM WSS-PE8062O
           ADD     1        TO REG-ESCRITOS.

       FIN-PROCESO.
           MOVE    ZEROS            TO        REG-TOTAL
           MOVE    REG-LEIDOS       TO        REG-TOTAL
           DISPLAY 'PROCESO TERMINADO '
           DISPLAY 'REGISTROS LEIDOS EN ENTRADA  ' REG-TOTAL
           MOVE    REG-ESCRITOS     TO        REG-TOTAL
           DISPLAY 'REGISTROS ESCRITOS EN SALIDA ' REG-TOTAL.
           MOVE ZEROS   TO   RETURN-CODE.
           CLOSE    PE0001R
                    PE0001W
           PERFORM ALTO-PROCESAMIENTO.
       ABNORMAL-ENDING.
           CLOSE    PE0001R
                    PE0001W
           MOVE '847'      TO      RETURN-CODE.
           DISPLAY    'TERMINO ANORMAL ' RETURN-CODE
           PERFORM  ALTO-PROCESAMIENTO.
       ALTO-PROCESAMIENTO.
           GOBACK.
       LEE-ENTRADA-1RA.
           READ  PE0001R
           EVALUATE FS-PE0001R
           WHEN     '00'
                 ADD       1           TO REG-LEIDOS
                 MOVE REG-1R TO WS-PE8062I
           WHEN     '10'
                 MOVE      1           TO WS-FIN-ENTRADA
                 DISPLAY 'FIN DE ARCHIVO ENTRADA 1RA '
           WHEN  OTHER
                 PERFORM ABNORMAL-ENDING
           END-EVALUATE.

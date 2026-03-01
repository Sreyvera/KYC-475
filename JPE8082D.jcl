//*%OPC SCAN                                                           
//JPE8082D JOB (0000,SYST),MSGCLASS=X,MSGLEVEL=(1,1),                  
//             CLASS=F                                                 
//*                                                                    
//LIBPROC  JCLLIB ORDER=(GRBS.PRE1.PRCLIB)                             
//         INCLUDE MEMBER=INCLJBP                                      
//*                                                                    
//*********************************************************************
//*                             JPE8082D                               
//* GENERA ARCHIVO DE TRE-FTF DIARIO SEGUNDA PARTE
//*********************************************************************
//*                                                                    
//PAS00010 EXEC PGM=IDCAMS                                             
//*********************************************************************
//* PAS00010 BORRADO DE FICHEROS                                       
//*********************************************************************
//SYSPRINT  DD SYSOUT=*                                                
//SYSIN     DD *                                                       
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02A01.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02B01.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S01.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02A02.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02B02.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S02.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02A03.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02B03.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S03.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02A04.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02B04.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S04.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02A05.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02B05.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S05.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02A06.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02B06.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S06.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02A07.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02B07.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S07.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02A08.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02B08.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S08.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02A09.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02B09.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S09.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02A10.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02B10.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S10.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8082D.EE02S11.D&OYMD1.
   
   IF MAXCC < 9 THEN SET MAXCC=0       
/*                                                                     
//*                                                                    
//PAS00011 EXEC PGM=PLEXP022,COND=(0,GE,PAS00010)
//*
//PAS00020 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00020  PROGRAMA PARA CREAR TODAS LAS COMBINACIONES POSIBLES  
//*           DE SOLAPES DE FECHA CON MAS DE PORCENTAJE MINIMO 
//*           PARA AGRUPACION ACCIONISTAS 1
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S06.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A01.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80619) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00021 EXEC PGM=PLEXP022,COND=(0,GE,PAS00020)                      
//*                                                                    
//PAS00030 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00030 ORDENA REGISTROS PARA ENTRADA AL SIGUIENTE PROGRAMA       
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A01.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B01.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                                               
               5,4,BI,A,                                               
               46,10,CH,A,                                             
               56,10,CH,A)                                             
  SUM FIELDS=NONE                                                      
/*                                                                     
//*                                                                    
//PAS00031 EXEC PGM=PLEXP022,COND=(0,GE,PAS00030)                      
//*                                                                    
//PAS00040 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00040 VALIDACIóN DE PORCENTAJE DE PARTICIP. DE ACCIONISTAS 1 
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B01.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S01.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(TRK,(40000,4000),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
2                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00041 EXEC PGM=PLEXP022,COND=(0,GE,PAS00040)                      
//*                                                                     
//PAS00050 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00050  PROGRAMA PARA CREAR TODAS LAS COMBINACIONES POSIBLES  
//*           DE SOLAPES DE FECHA CON MAS DE PORCENTAJE MINIMO 
//*           PARA AGRUPACION ACCIONISTAS 2
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S07.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A02.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80619) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00051 EXEC PGM=PLEXP022,COND=(0,GE,PAS00050)                      
//*                                                                    
//PAS00060 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00060 ORDENA REGISTROS PARA ENTRADA AL SIGUIENTE PROGRAMA       
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A02.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B02.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                                               
               5,4,BI,A,                                               
               46,10,CH,A,                                             
               56,10,CH,A)                                             
  SUM FIELDS=NONE                                                      
/*                                                                     
//*                                                                    
//PAS00061 EXEC PGM=PLEXP022,COND=(0,GE,PAS00060)                      
//*                                                                    
//PAS00070 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00070 VALIDACIóN DE PORCENTAJE DE PARTICIP. DE ACCIONISTAS 2 
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B02.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S02.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(TRK,(40000,4000),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
2                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00071 EXEC PGM=PLEXP022,COND=(0,GE,PAS00070)                      
//*        
//PAS00080 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00080  PROGRAMA PARA CREAR TODAS LAS COMBINACIONES POSIBLES  
//*           DE SOLAPES DE FECHA CON MAS DE PORCENTAJE MINIMO 
//*           PARA AGRUPACION ACCIONISTAS 3
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S08.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A03.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80619) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00081 EXEC PGM=PLEXP022,COND=(0,GE,PAS00080)                      
//*                                                                    
//PAS00090 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00090 ORDENA REGISTROS PARA ENTRADA AL SIGUIENTE PROGRAMA       
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A03.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B03.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                                               
               5,4,BI,A,                                               
               46,10,CH,A,                                             
               56,10,CH,A)                                             
  SUM FIELDS=NONE                                                      
/*                                                                     
//*                                                                    
//PAS00091 EXEC PGM=PLEXP022,COND=(0,GE,PAS00090)                      
//*                                                                    
//PAS00100 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00100 VALIDACIóN DE PORCENTAJE DE PARTICIP. DE ACCIONISTAS 3 
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B03.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S03.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(TRK,(40000,4000),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
2                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00101 EXEC PGM=PLEXP022,COND=(0,GE,PAS00100)                      
//*                                                                     
//PAS00110 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00110  PROGRAMA PARA CREAR TODAS LAS COMBINACIONES POSIBLES  
//*           DE SOLAPES DE FECHA CON MAS DE PORCENTAJE MINIMO 
//*           PARA AGRUPACION ACCIONISTAS 4
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S09.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A04.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80619) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00111 EXEC PGM=PLEXP022,COND=(0,GE,PAS00110)                      
//*                                                                    
//PAS00120 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00120 ORDENA REGISTROS PARA ENTRADA AL SIGUIENTE PROGRAMA       
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A04.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B04.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                                               
               5,4,BI,A,                                               
               46,10,CH,A,                                             
               56,10,CH,A)                                             
  SUM FIELDS=NONE                                                      
/*                                                                     
//*                                                                    
//PAS00121 EXEC PGM=PLEXP022,COND=(0,GE,PAS00120)                      
//*                                                                    
//PAS00130 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00130 VALIDACIóN DE PORCENTAJE DE PARTICIP. DE ACCIONISTAS 4 
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B04.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S04.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(TRK,(40000,4000),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
2                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00131 EXEC PGM=PLEXP022,COND=(0,GE,PAS00130)                      
//*                                                                     
//PAS00140 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00140  PROGRAMA PARA CREAR TODAS LAS COMBINACIONES POSIBLES  
//*           DE SOLAPES DE FECHA CON MAS DE PORCENTAJE MINIMO 
//*           PARA AGRUPACION ACCIONISTAS 5
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S10.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A05.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80619) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00141 EXEC PGM=PLEXP022,COND=(0,GE,PAS00140)                      
//*                                                                    
//PAS00150 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00150 ORDENA REGISTROS PARA ENTRADA AL SIGUIENTE PROGRAMA       
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A05.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B05.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                                               
               5,4,BI,A,                                               
               46,10,CH,A,                                             
               56,10,CH,A)                                             
  SUM FIELDS=NONE                                                      
/*                                                                     
//*                                                                    
//PAS00151 EXEC PGM=PLEXP022,COND=(0,GE,PAS00150)                      
//*                                                                    
//PAS00160 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00160 VALIDACIóN DE PORCENTAJE DE PARTICIP. DE ACCIONISTAS 5 
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B05.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S05.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(TRK,(40000,4000),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
2                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00161 EXEC PGM=PLEXP022,COND=(0,GE,PAS00160)                      
//*                                                                     
//PAS00170 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00170  PROGRAMA PARA CREAR TODAS LAS COMBINACIONES POSIBLES  
//*           DE SOLAPES DE FECHA CON MAS DE PORCENTAJE MINIMO 
//*           PARA AGRUPACION ACCIONISTAS 6
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S11.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A06.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80619) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00171 EXEC PGM=PLEXP022,COND=(0,GE,PAS00170)                      
//*                                                                    
//PAS00180 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00180 ORDENA REGISTROS PARA ENTRADA AL SIGUIENTE PROGRAMA       
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A06.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B06.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                                               
               5,4,BI,A,                                               
               46,10,CH,A,                                             
               56,10,CH,A)                                             
  SUM FIELDS=NONE                                                      
/*                                                                     
//*                                                                    
//PAS00181 EXEC PGM=PLEXP022,COND=(0,GE,PAS00180)                      
//*                                                                    
//PAS00190 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00190 VALIDACIóN DE PORCENTAJE DE PARTICIP. DE ACCIONISTAS 6
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B06.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S06.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(TRK,(40000,4000),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
2                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00191 EXEC PGM=PLEXP022,COND=(0,GE,PAS00190)                      
//*                                                                     
//PAS00200 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00200  PROGRAMA PARA CREAR TODAS LAS COMBINACIONES POSIBLES  
//*           DE SOLAPES DE FECHA CON MAS DE PORCENTAJE MINIMO 
//*           PARA AGRUPACION ACCIONISTAS 7
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S12.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A07.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80619) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00201 EXEC PGM=PLEXP022,COND=(0,GE,PAS00200)                      
//*                                                                    
//PAS00210 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00210 ORDENA REGISTROS PARA ENTRADA AL SIGUIENTE PROGRAMA       
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A07.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B07.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                                               
               5,4,BI,A,                                               
               46,10,CH,A,                                             
               56,10,CH,A)                                             
  SUM FIELDS=NONE                                                      
/*                                                                     
//*                                                                    
//PAS00211 EXEC PGM=PLEXP022,COND=(0,GE,PAS00210)                      
//*                                                                    
//PAS00220 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00220 VALIDACIóN DE PORCENTAJE DE PARTICIP. DE ACCIONISTAS 7
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B07.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S07.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(TRK,(40000,4000),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
2                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00221 EXEC PGM=PLEXP022,COND=(0,GE,PAS00220)                      
//*                                                                     
//PAS00230 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00230  PROGRAMA PARA CREAR TODAS LAS COMBINACIONES POSIBLES  
//*           DE SOLAPES DE FECHA CON MAS DE PORCENTAJE MINIMO 
//*           PARA AGRUPACION ACCIONISTAS 8
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S13.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A08.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80619) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00231 EXEC PGM=PLEXP022,COND=(0,GE,PAS00230)                      
//*                                                                    
//PAS00240 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00240 ORDENA REGISTROS PARA ENTRADA AL SIGUIENTE PROGRAMA       
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A08.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B08.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                                               
               5,4,BI,A,                                               
               46,10,CH,A,                                             
               56,10,CH,A)                                             
  SUM FIELDS=NONE                                                      
/*                                                                     
//*                                                                    
//PAS00241 EXEC PGM=PLEXP022,COND=(0,GE,PAS00240)                      
//*                                                                    
//PAS00250 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00250 VALIDACIóN DE PORCENTAJE DE PARTICIP. DE ACCIONISTAS 8 
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B08.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S08.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(TRK,(40000,4000),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
2                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00251 EXEC PGM=PLEXP022,COND=(0,GE,PAS00250)                      
//*                                                                     
//PAS00260 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00260  PROGRAMA PARA CREAR TODAS LAS COMBINACIONES POSIBLES  
//*           DE SOLAPES DE FECHA CON MAS DE PORCENTAJE MINIMO 
//*           PARA AGRUPACION ACCIONISTAS 9
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S14.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A09.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80619) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00261 EXEC PGM=PLEXP022,COND=(0,GE,PAS00260)                      
//*                                                                    
//PAS00270 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00270 ORDENA REGISTROS PARA ENTRADA AL SIGUIENTE PROGRAMA       
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A09.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B09.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                                               
               5,4,BI,A,                                               
               46,10,CH,A,                                             
               56,10,CH,A)                                             
  SUM FIELDS=NONE                                                      
/*                                                                     
//*                                                                    
//PAS00271 EXEC PGM=PLEXP022,COND=(0,GE,PAS00270)                      
//*                                                                    
//PAS00280 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00280 VALIDACIóN DE PORCENTAJE DE PARTICIP. DE ACCIONISTAS 9 
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B09.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S09.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(TRK,(40000,4000),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
2                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00281 EXEC PGM=PLEXP022,COND=(0,GE,PAS00280)                      
//*                                                                     
//PAS00290 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00290  PROGRAMA PARA CREAR TODAS LAS COMBINACIONES POSIBLES  
//*           DE SOLAPES DE FECHA CON MAS DE PORCENTAJE MINIMO 
//*           PARA AGRUPACION ACCIONISTAS 10
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S15.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A10.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80619) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00291 EXEC PGM=PLEXP022,COND=(0,GE,PAS00290)                      
//*                                                                    
//PAS00300 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00300 ORDENA REGISTROS PARA ENTRADA AL SIGUIENTE PROGRAMA       
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02A10.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B10.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                                               
               5,4,BI,A,                                               
               46,10,CH,A,                                             
               56,10,CH,A)                                             
  SUM FIELDS=NONE                                                      
/*                                                                     
//*                                                                    
//PAS00301 EXEC PGM=PLEXP022,COND=(0,GE,PAS00300)                      
//*                                                                    
//PAS00310 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00310 VALIDACIóN DE PORCENTAJE DE PARTICIP. DE ACCIONISTAS 10
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02B10.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S10.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
2                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00311 EXEC PGM=PLEXP022,COND=(0,GE,PAS00310)                      
//*      
//PAS00320 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00320 VALIDACIóN DE ADMINISTRADORES Y/O FIRMANTES
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S16.D&OYMD1.,              
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S11.D&OYMD1.,              
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
3                                                                      
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89945) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00321 EXEC PGM=PLEXP022,COND=(0,GE,PAS00320)                      
//*                                                                                                                                                                                              
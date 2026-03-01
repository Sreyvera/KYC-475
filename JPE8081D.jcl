//*%OPC SCAN                                                           
//JPE8081D JOB (0000,SYST),MSGCLASS=X,MSGLEVEL=(1,1),                  
//             CLASS=F                                                 
//*                                                                    
//LIBPROC  JCLLIB ORDER=(GRBS.PRE1.PRCLIB)                             
//         INCLUDE MEMBER=INCLJBP                                      
//*                                                                    
//*********************************************************************
//*                             JPE8081D                               
//* GENERA ARCHIVO DE TRE-FTF DIARIO PRIMERA PARTE
//*********************************************************************
//*                                                                    
//PAS00010 EXEC PGM=IDCAMS                                             
//*********************************************************************
//* PAS00010 BORRADO DE FICHEROS                                       
//*********************************************************************
//SYSPRINT  DD SYSOUT=*                                                
//SYSIN     DD *                                                       
   DELETE PPE.C00.PUENTE11.JPE8081D.PE16S00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.PE16S01.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.PE16S02.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S01.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S02.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S03.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S04.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S05.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S06.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S07.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S08.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S09.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S10.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S11.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S12.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S13.D&OYMD1.   
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S14.D&OYMD1.   
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S15.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8081D.EE02S16.D&OYMD1.   
   
   IF MAXCC < 9 THEN SET MAXCC=0       
/*                                                                     
//*                                                                    
//PAS00011 EXEC PGM=PLEXP022,COND=(0,GE,PAS00010)
//* 
//PAS00020 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00020 ELIMINAMOS DUPLICADOS Y SE QUEDA CON FEHA ALTA MAS ANTIGUA    
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S14.D&OYMD1.,       
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8081D.PE16S00.D&OYMD1.,        
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,4,BI,A,5,3,CH,A,8,8,PD,A,18,10,CH,A)
/*                                                                     
//*                                                                    
//PAS00021 EXEC PGM=PLEXP022,COND=(0,GE,PAS00020)                      
//*         
//PAS00030 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00030 ELIMINAMOS DUPLICADOS Y SE QUEDA CON FEHA ALTA MAS ANTIGUA    
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S14.D&OYMD1.,       
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8081D.PE16S01.D&OYMD1.,        
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,4,BI,A,5,3,CH,A,8,8,PD,A,28,10,CH,D)
/*                                                                     
//*                                                                    
//PAS00031 EXEC PGM=PLEXP022,COND=(0,GE,PAS00030)                      
//*  
//PAS00040 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00040 GENERA ARCHIVO CON FECHAS MINIMAS Y MAXIMAS POR PERSONA  
//*          PARA UNA MISMA PERSONA Y CONTRATO SE QUEDA CON LA FECHA
//*          DE BAJA MAS ALTA.
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTJNF1 DD  DSN=PPE.C00.PUENTE11.JPE8081D.PE16S00.D&OYMD1.,         
//             DISP=SHR                                                                                               
//SORTJNF2 DD  DSN=PPE.C00.PUENTE11.JPE8081D.PE16S01.D&OYMD1.,         
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8081D.PE16S02.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,4,BI,A)
  JOINKEYS FILE=F1,FIELDS=(1,4,A,5,3,A,8,8,A)
  JOINKEYS FILE=F2,FIELDS=(1,4,A,5,3,A,8,8,A)
  JOIN UNPAIRED,F1,F2
  REFORMAT FIELDS=(F1:1,39,F2:28,10,18,2,?)
  OUTFIL FNAMES=SORTOUT,INCLUDE=(52,1,CH,EQ,C'B'),
          BUILD=(1,27,     -- DATOS IDENTIFICATIVOS */
                 40,10,    -- FECHA BAJA MAS RECIENTE */
				 38,2)     -- ENTIDAD */				 
  SUM FIELDS=NONE FIRSTDUP 
/*                                                                     
//*                                                                    
//PAS00041 EXEC PGM=PLEXP022,COND=(0,GE,PAS00040)                      
//*
//PAS00050 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00050 JOINKEYS POR PERSONA PARA CAMBIAR FECHA BAJA  
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTJNF1  DD DSN=PEE.C00.PUENTE11.JEE0001D.EE0201U.D&OYMD1.,           
//             DISP=SHR                                                
//SORTJNF2  DD DSN=PPE.C00.PUENTE11.JPE8081D.PE16S02.D&OYMD1.,               
//             DISP=SHR                                                
//MATCH     DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S00.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=109,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  JOIN UNPAIRED,F1,F2                                                  
  JOINKEYS FILE=F1,FIELDS=(1,4,A)                                      
  JOINKEYS FILE=F2,FIELDS=(1,4,A)                                      
  REFORMAT FIELDS=(F1:1,99,F2:28,10,?)                                  
  SORT FIELDS=COPY                                                     
  OUTFIL FNAMES=MATCH,                                                 
         INCLUDE=(110,1,CH,EQ,C'B'),                                   
         BUILD=(1,109)            --OPERACION                           
/*                                                                     
//PAS00051 EXEC PGM=PLEXP022,COND=(0,GE,PAS00050)                      
//*
//PAS00060 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS0060 SI LA FECHA DE EE0201 ES MAYOR QUE PE06                   
//*          SE REEMPLAZA LA DE EE0201 POR LA BAJA DE PE06         
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S00.D&OYMD1.,         
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S01.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=099,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                                                     
  OUTREC IFTHEN=(WHEN=(056,10,CH,GT,100,10,CH),                        
                 BUILD=(1,55,100,10,66,34)),                           
         IFTHEN=(WHEN=NONE,BUILD=(1,99))                              
/*                                                                     
//*                                                                    
//PAS00061 EXEC PGM=PLEXP022,COND=(0,GE,PAS00060)     
//*
//PAS00070 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00070 QUITA LOS QUE HAN EMPEZADO DESPUES DE HABER FINALIZADO    
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S01.D&OYMD1.,            
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S02.D&OYMD1.,            
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=099,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                                                     
  INCLUDE COND=(46,10,CH,NE,56,10,CH,AND,(56,10,CH,GT,46,10,CH))
/*                                                                     
//PAS00071 EXEC PGM=PLEXP022,COND=(0,GE,PAS00070)                      
//*           
//PAS00080 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00080 JOINKEYS POR PERSONA ADMINISTRADOR VALIDA EXISTE EN PE11  
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTJNF1  DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S02.D&OYMD1.,           
//             DISP=SHR                                                
//SORTJNF2  DD DSN=PPE.C00.PUENTE11.JPE8080D.PE11S00.D&OYMD1.,            
//             DISP=SHR                                                
//MATCH     DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S03.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=099,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15) 
  SORT FIELDS=(1,99,CH,A)   
  JOIN UNPAIRED,F1,F2                                                  
  JOINKEYS FILE=F1,FIELDS=(1,4,A)                                      
  JOINKEYS FILE=F2,FIELDS=(1,4,A)                                      
  REFORMAT FIELDS=(F1:1,99,?)                                  
  SORT FIELDS=COPY                                                     
  OUTFIL FNAMES=MATCH,                                                 
         INCLUDE=(100,1,CH,EQ,C'B'),                                   
         BUILD=(1,99)
/*                                                                     
//PAS00081 EXEC PGM=PLEXP022,COND=(0,GE,PAS00080)                      
//*
//PAS00090 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00090 JOINKEYS POR PERSONA EMPRESA VALIDA EXISTE EN PE11  
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTJNF1  DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S03.D&OYMD1.,           
//             DISP=SHR                                                
//SORTJNF2  DD DSN=PPE.C00.PUENTE11.JPE8080D.PE11S00.D&OYMD1.,            
//             DISP=SHR                                                
//MATCH     DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S04.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=099,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15) 
  SORT FIELDS=(1,99,CH,A)   
  JOIN UNPAIRED,F1,F2                                                  
  JOINKEYS FILE=F1,FIELDS=(5,4,A)                                      
  JOINKEYS FILE=F2,FIELDS=(1,4,A)                                      
  REFORMAT FIELDS=(F1:1,99,?)                                  
  SORT FIELDS=COPY                                                     
  OUTFIL FNAMES=MATCH,                                                 
         INCLUDE=(100,1,CH,EQ,C'B'),                                   
         BUILD=(1,99)
/*                                                                     
//PAS00091 EXEC PGM=PLEXP022,COND=(0,GE,PAS00090)                      
//*
//PAS00100 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00100 QUITA LOS DUPLICADOS
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S04.D&OYMD1.,            
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S05.D&OYMD1.,            
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=099,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
   SORT FIELDS=(1,99,CH,A)                                              
   SUM FIELDS=NONE     
/*                                                                     
//PAS00101 EXEC PGM=PLEXP022,COND=(0,GE,PAS00100) 
//*                                    
//PAS00110 EXEC PGM=IKJEFT1B
//*********************************************************************
//* PAS00110 DIVIDE FUCHERO POR AGRUPACION EN EE004 Y RECUPERA PORCENT.
//*PE0001W   TPA EE004 TIPO DE AGRUPACION ACCIONISTAS 1
//*PE0002W   TPA EE004 TIPO DE AGRUPACION ACCIONISTAS 2
//*PE0003W   TPA EE004 TIPO DE AGRUPACION ACCIONISTAS 3
//*PE0004W   TPA EE004 TIPO DE AGRUPACION ACCIONISTAS 4
//*PE0005W   TPA EE004 TIPO DE AGRUPACION ACCIONISTAS 5
//*PE0006W   TPA EE004 TIPO DE AGRUPACION ACCIONISTAS 6
//*PE0007W   TPA EE004 TIPO DE AGRUPACION ACCIONISTAS 7
//*PE0008W   TPA EE004 TIPO DE AGRUPACION ACCIONISTAS 8
//*PE0009W   TPA EE004 TIPO DE AGRUPACION ACCIONISTAS 9
//*PE0010W   TPA EE004 TIPO DE AGRUPACION ACCIONISTAS 0
//*PE0011W   TPA EE004 TIPO DE AGRUPACION FIRMANTES
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SYSTSPRT  DD SYSOUT=*                                                
//SYSPRINT  DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S05.D&OYMD1.,               
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S06.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB   
//PE0002W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S07.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB   
//PE0003W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S08.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB   
//PE0004W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S09.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB   
//PE0005W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S10.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB   
//PE0006W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S11.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB   
//PE0007W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S12.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB   
//PE0008W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S13.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB   
//PE0009W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S14.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB         
//PE0010W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S15.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB 
//PE0011W   DD DSN=PPE.C00.PUENTE11.JPE8081D.EE02S16.D&OYMD1.,               
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                             
//             LRECL=99,RECFM=FB   
//SYSIN     DD *                                                       
/*                                                                     
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE89016) PLAN(SIBISBAT)                                   
 END                                                                   
/*
//*
//PAS00111 EXEC PGM=PLEXP022,COND=(0,GE,PAS00110)
//*

















           

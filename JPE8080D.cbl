//*%OPC SCAN                                                           
//JPE8080D JOB (0000,SYST),MSGCLASS=X,MSGLEVEL=(1,1),                  
//             CLASS=F                                                 
//*                                                                    
//LIBPROC  JCLLIB ORDER=(GRBS.PRE1.PRCLIB)                             
//         INCLUDE MEMBER=INCLJBP                                      
//*                                                                    
//*********************************************************************
//*                             JPE8080D                               
//* GENERA ARCHIVO DE FTF DIARIO
//*********************************************************************
//*                                                                    
//PAS00010 EXEC PGM=IDCAMS                                             
//*********************************************************************
//* PAS00010 BORRADO DE FICHEROS                                       
//*********************************************************************
//SYSPRINT  DD SYSOUT=*                                                
//SYSIN     DD *                                                       
   DELETE PPE.C00.PUENTE11.JPE8080D.PE097.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE098.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE099.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE100.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE11S00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE20S00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S01.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S02.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S03.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S04.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S05.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S06.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S07.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S08.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S09.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S10.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S11.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S12.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S13.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE16S14.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE06S00.D&OYMD1.   
   DELETE PPE.C00.PUENTE11.JPE8080D.PE06S01.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE06S02.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.PE06S03.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.KC41S00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.KC41S01.D&OYMD1.   
   DELETE PPE.C00.PUENTE11.JPE8080D.DV90S00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.DV90S01.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.BAJASDV.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.AMORT00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8080D.VENTAS.D&OYMD1.
   IF MAXCC < 9 THEN SET MAXCC=0       
/*                                                                     
//*                                                                    
//PAS00011 EXEC PGM=PLEXP022,COND=(0,GE,PAS00010)
//* 
//PAS00020 EXEC PGM=IKJEFT1B
//*********************************************************************
//* PAS00020 RECUPERA PARAMETROS FTF
//*          TPA PE097   Tipo de producto FTF
//*          TPA PE098   Tipo de vinculo FTF
//*          TPA PE099   situación permitida de contrato FTF
//*          TPA PE100   Productos Operativos excluido
//*********************************************************************
//SYSOUT    DD SYSOUT=*
//SYSTSPRT  DD SYSOUT=*
//SYSPRINT  DD SYSOUT=*
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8080D.PE097.D&OYMD1.,
//             DISP=(,CATLG,DELETE),
//             SPACE=(TRK,(10,5),RLSE),
//             LRECL=3,RECFM=FB
//PE0002W   DD DSN=PPE.C00.PUENTE11.JPE8080D.PE098.D&OYMD1.,
//             DISP=(,CATLG,DELETE),
//             SPACE=(TRK,(10,5),RLSE),
//             LRECL=2,RECFM=FB
//PE0003W   DD DSN=PPE.C00.PUENTE11.JPE8080D.PE099.D&OYMD1.,
//             DISP=(,CATLG,DELETE),
//             SPACE=(TRK,(10,5),RLSE),
//             LRECL=1,RECFM=FB
//PE0004W   DD DSN=PPE.C00.PUENTE11.JPE8080D.PE100.D&OYMD1.,
//             DISP=(,CATLG,DELETE),
//             SPACE=(TRK,(10,5),RLSE),
//             LRECL=8,RECFM=FB
//SYSTSIN   DD *
 DSN SYSTEM(DBP1)
 RUN PROGRAM(PE89015) PLAN(SIBISBAT)
 END
/*
//*
//PAS00021 EXEC PGM=PLEXP022,COND=(0,GE,PAS00020)
//*
//PAS00030 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00030 SORT ARCHIVO PE1103                                       
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=PPE.C00.PUENTE1.SORTPE11.NUMPERS.V01,          
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE11S00.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=4,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,4,BI,A)
  OUTREC FIELDS=(1,4)                    -- NUMPERSONA
  SUM FIELDS=NONE
/*                                                                     
//*                                                                    
//PAS00031 EXEC PGM=PLEXP022,COND=(0,GE,PAS00030)                      
//*                                          
//PAS00040 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00040 SORT ARCHIVO PE1603                                       
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=PPE.C00.PUENTE11.FASE01.PE1603.V01,          
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S00.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                         
  OUTREC FIELDS=(1,15,18,2,31,10,42,10,145,2)
/*                                                                     
//*                                                                    
//PAS00041 EXEC PGM=PLEXP022,COND=(0,GE,PAS00040)                      
//*                                          
//PAS00050 EXEC PROC=DB0004,UTILID=&OJOBNAME.                            
//******************************************************************** 
//* PAS00050 DESCARGA DE TABLA PE2001                               
//******************************************************************** 
//SYSREC    DD DSN=PPE.C00.PUENTE11.JPE8080D.PE20S00.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                      
//SYSIN     DD DSN=GRBS.PRE1.CTCLIB(PLUNIBM2),                         
//             DISP=SHR                                                
//          DD *                                                       
    SELECT
      PE2001_NUMPERSONA,
      PE2001_TIPPRODUCT,
      PE2001_CODCONTRAT,
      PE2001_CODRELPECO,
      PE2001_FECALTA,
      PE2001_FECBAJA,
      PE2001_CODENTID
    FROM DB2PROD.PE2001
    ;                                                                  
/*                                                                     
//          DD DSN=GRBS.PRE1.CTCLIB(PLUNIBM4),                         
//             DISP=SHR                                                
//*                                                                    
//PAS00051 EXEC PGM=PLEXP022,COND=(4,GE,PAS00050.DB00041)   
//*
//PAS00060 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00060 Sort de PE16 para quedarnos con productos FTF  
//*          
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTJNF1 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S00.D&OYMD1.,         
//             DISP=SHR                                                
//         DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE20S00.D&OYMD1.,         
//             DISP=SHR                                                
//SORTJNF2 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE097.D&OYMD1.,         
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S01.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,4,BI,A,5,3,CH,A,8,8,PD,A)
  JOINKEYS FILE=F1,FIELDS=(5,3,A)
  JOINKEYS FILE=F2,FIELDS=(1,3,A)
  JOIN UNPAIRED,F1,F2
  REFORMAT FIELDS=(F1:1,39,?)
  OUTFIL FNAMES=SORTOUT,INCLUDE=(40,1,CH,EQ,C'B'),
          BUILD=(1,39) 
/*                                                                     
//*                                                                    
//PAS00061 EXEC PGM=PLEXP022,COND=(0,GE,PAS00060)                      
//*    
//PAS00070 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00070 Sort de PE16 para quedarnos con vínculos FTF  
//*          
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTJNF1 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S01.D&OYMD1.,         
//             DISP=SHR                                                
//SORTJNF2 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE098.D&OYMD1.,         
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S02.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,4,BI,A,5,3,CH,A,8,8,PD,A)
  JOINKEYS FILE=F1,FIELDS=(16,2,A)
  JOINKEYS FILE=F2,FIELDS=(1,2,A)
  JOIN UNPAIRED,F1,F2
  REFORMAT FIELDS=(F1:1,39,?)
  OUTFIL FNAMES=SORTOUT,INCLUDE=(40,1,CH,EQ,C'B'),
          BUILD=(1,39) 
/*                                                                     
//*                                                                    
//PAS00071 EXEC PGM=PLEXP022,COND=(0,GE,PAS00070)                      
//*            
//PAS00080 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00080 Solo los de la entidad 01 y que no coincida las 
//*          fechas alta/baja                                       
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S02.D&OYMD1.,          
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S03.D&OYMD1.,        
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,4,BI,A,                   -- NUMPERSONA
               5,3,CH,A,                   -- TIPOPRODUC
               8,8,PD,A,                   -- CODIGOCONTRATO
               16,2,BI,A,                  -- VINCULO
               18,10,CH,A,                 -- FECHALTA
               28,10,CH,A)                 -- FECHBAJA
  SUM FIELDS=NONE
  INCLUDE COND=(38,2,CH,EQ,C'01',AND,
                (18,10,CH,NE,28,10,CH))
/*                                                                     
//*                                                                    
//PAS00081 EXEC PGM=PLEXP022,COND=(0,GE,PAS00080)                      
//*    
//PAS00090 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00090 REEMPLAZA NULOS POR FECHA MAXIMA   
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S03.D&OYMD1.,       
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S04.D&OYMD1.,        
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                                                     
  OUTREC IFTHEN=(WHEN=(28,10,CH,EQ,X'00000000000000000000'),           
                 BUILD=(1,27,C'9999-12-31',38,2)),                   
         IFTHEN=(WHEN=NONE,BUILD=(1,39))
/*                                                                     
//*                                                                    
//PAS00091 EXEC PGM=PLEXP022,COND=(0,GE,PAS00090)                      
//*
//PAS00100 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00100 CRUCE CON PERSONAS PARA VALIDAD INTEGRIDAD REFERENCIAL  
//*          
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTJNF1 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S04.D&OYMD1.,        
//             DISP=SHR                                                                                               
//SORTJNF2 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE11S00.D&OYMD1.,        
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S05.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,4,BI,A,5,3,CH,A,8,8,PD,A)
  JOINKEYS FILE=F1,FIELDS=(1,4,A)
  JOINKEYS FILE=F2,FIELDS=(1,4,A)
  JOIN UNPAIRED,F1,F2
  REFORMAT FIELDS=(F1:1,39,?)
  OUTFIL FNAMES=SORTOUT,INCLUDE=(40,1,CH,EQ,C'B'),
          BUILD=(1,39)     
/*                                                                     
//*                                                                    
//PAS00101 EXEC PGM=PLEXP022,COND=(0,GE,PAS00100)                      
//*
//PAS00110 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00110 SORT DEL ARCHIVO DE ENTRADA PE0601 POR PRODUCTOS FTF
//*          
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE1.FASE01.PE0600.V01,          
//             DISP=SHR                                                
//SALIDA1   DD DSN=PPE.C00.PUENTE11.JPE8080D.PE06S00.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=42,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY
  OUTFIL FNAMES=SALIDA1,INCLUDE=(92,2,CH,EQ,C'01'),              
              OUTREC=(1,3,          --TIPPRODUCT
			          11,8,         --CODCONTRAT
					  21,1,         --INDSITCONT
					  35,10,        --FECALTA
					  46,10,        --FECBAJA               
					  98,8,         --CODPRODO
					  92,2)         --CODENTID
/*                                                                     
//*                                                                     
//PAS00111 EXEC PGM=PLEXP022,COND=(0,GE,PAS00110)                      
//*
//PAS00120 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00120 Sort de PE06 para quedarnos con productos FTF  
//*          
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTJNF1 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE06S00.D&OYMD1.,         
//             DISP=SHR                                                 
//SORTJNF2 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE097.D&OYMD1.,         
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE06S01.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=42,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,3,CH,A,4,8,PD,A)
  JOINKEYS FILE=F1,FIELDS=(1,3,A)
  JOINKEYS FILE=F2,FIELDS=(1,3,A)
  JOIN UNPAIRED,F1,F2
  REFORMAT FIELDS=(F1:1,42,?)
  OUTFIL FNAMES=SORTOUT,INCLUDE=(43,1,CH,EQ,C'B'),
          BUILD=(1,42) 
/*                                                                     
//*                                                                    
//PAS00121 EXEC PGM=PLEXP022,COND=(0,GE,PAS00120)                      
//*    
//PAS00130 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00130 Sort de PE06 para quedarnos con SITUACION FTF  
//*          
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTJNF1 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE06S01.D&OYMD1.,         
//             DISP=SHR                                                
//SORTJNF2 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE099.D&OYMD1.,         
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE06S02.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=42,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,3,CH,A,4,8,PD,A)
  JOINKEYS FILE=F1,FIELDS=(12,1,A)
  JOINKEYS FILE=F2,FIELDS=(1,1,A)
  JOIN UNPAIRED,F1,F2
  REFORMAT FIELDS=(F1:1,42,?)
  OUTFIL FNAMES=SORTOUT,INCLUDE=(43,1,CH,EQ,C'1'),
          BUILD=(1,42) 
/*                                                                     
//*                                                                    
//PAS00131 EXEC PGM=PLEXP022,COND=(0,GE,PAS00130)                      
//*    
//PAS00140 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00140 Sort de PE06 para EXCLUIR CODIGO DE PRODUCTOS  
//*          
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTJNF1 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE06S02.D&OYMD1.,         
//             DISP=SHR                                                 
//SORTJNF2 DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE100.D&OYMD1.,         
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE06S03.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=42,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,3,CH,A,4,8,PD,A)
  JOINKEYS FILE=F1,FIELDS=(33,8,A)
  JOINKEYS FILE=F2,FIELDS=(1,8,A)
  JOIN UNPAIRED,F1,F2
  REFORMAT FIELDS=(F1:1,42,?)
  OUTFIL FNAMES=SORTOUT,INCLUDE=(43,1,CH,EQ,C'1'),
          BUILD=(1,42) 
/*                                                                     
//*                                                                    
//PAS00141 EXEC PGM=PLEXP022,COND=(0,GE,PAS00140)                      
//*
//PAS00150 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00150 JOINKEYS POR CONTRATO  CON PE06 ASIGNA FECHA FIN                   
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTJNF1  DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S05.D&OYMD1., 
//             DISP=SHR                                                
//SORTJNF2  DD DSN=PPE.C00.PUENTE11.JPE8080D.PE06S03.D&OYMD1.,        
//             DISP=SHR                                                
//MATCH1     DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S06.D&OYMD1.,           
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=039,RECFM=FB                                      
//MATCH2     DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S07.D&OYMD1.,           
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=039,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  JOIN UNPAIRED,F1,F2
  JOINKEYS FILE=F1,FIELDS=(5,3,A,8,8,A,38,2,A)                                
  JOINKEYS FILE=F2,FIELDS=(1,3,A,04,8,A,41,2,A)                               
  REFORMAT FIELDS=(F1:1,39,F2:23,10,?)                                 
  SORT FIELDS=COPY                                                     
  OUTFIL FNAMES=MATCH1,                                                 
         INCLUDE=(28,10,CH,EQ,C'9999-12-31',AND,50,1,CH,EQ,C'B'),                                   
         BUILD=(1,27,40,10,38,2)  --CAMBIA FECHA DE BAJA                               
  OUTFIL FNAMES=MATCH2,                                                 
         INCLUDE=(28,10,CH,NE,C'9999-12-31',AND,50,1,CH,EQ,C'B'),                                   
         BUILD=(1,39)  --OPERACION                               
/*                                                                     
//PAS00151 EXEC PGM=PLEXP022,COND=(0,GE,PAS00150)                      
//*      
//PAS00160 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00160 REEMPLAZA NULOS POR FECHA MAXIMA                          
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S06.D&OYMD1.,           
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S07.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S08.D&OYMD1.,          
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=039,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                                                     
  OUTREC IFTHEN=(WHEN=(28,10,CH,EQ,X'00000000000000000000'),           
                 BUILD=(1,27,C'9999-12-31',38,2)),                          
         IFTHEN=(WHEN=NONE,BUILD=(1,39))                               
/*                                                                     
//*                                                                    
//PAS00161 EXEC PGM=PLEXP022,COND=(0,GE,PAS00160)                      
//*    
//PAS00170 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00170 QUITA LOS QUE HAN EMPEZADO DESPUES DE HABER FINALIZADO    
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S08.D&OYMD1.,          
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S09.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(TRK,(8000,800),RLSE),                            
//             LRECL=039,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                                                     
  INCLUDE COND=(18,10,CH,NE,28,10,CH,AND,(18,10,CH,LT,28,10,CH))
/*                                                                     
//PAS00171 EXEC PGM=PLEXP022,COND=(0,GE,PAS00170)                      
//*                                                       
//PAS00180 EXEC PGM=SORT,PARM=ABEND
//*********************************************************************
//* PAS00180 SE EXTRAEN LAS CUENTAS AMORTIZADAS
//*********************************************************************
//SYSOUT    DD SYSOUT=*
//SORTIN    DD DSN=PDV.C00.PUENTE1.KC4100.DIARIO.V01(0),
//             DISP=SHR
//SORTOUT1  DD DSN=PPE.C00.PUENTE11.JPE8080D.KC41S00.D&OYMD1.,
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=234,RECFM=FB                                      
//SORTOUT2  DD DSN=PPE.C00.PUENTE11.JPE8080D.KC41S01.D&OYMD1.,
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=234,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                                      
  OUTFIL FNAMES=SORTOUT1,       -- CONTENCIOSO                   
       INCLUDE=(1,2,CH,EQ,C'01',AND,29,1,CH,EQ,C'S',AND,  --- SITUCONTA
                (28,1,CH,EQ,C'S',OR,28,1,CH,EQ,C'X'))     --- SITSUBJE
  OUTFIL FNAMES=SORTOUT2,       -- VENTAS            
       INCLUDE=(1,2,CH,EQ,C'01',AND,29,1,CH,EQ,C'S',AND,  --- SITUCONTA
                28,1,CH,EQ,C'V')                          --- SITSUBJE
/*
//*
//PAS00181 EXEC PGM=PLEXP022,COND=(0,GE,PAS00180)
//*
//PAS00190 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00190 SEPARACION EL FICHERO PARA LITIGIO Y BAJAS 
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PDV.C00.PUENTE1.DV9001.UNLOAD.V01,
//             DISP=SHR                                                
//SORTOUT1  DD DSN=PPE.C00.PUENTE11.JPE8080D.DV90S00.D&OYMD1.,
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=492,RECFM=FB                                      
//SORTOUT2  DD DSN=PPE.C00.PUENTE11.JPE8080D.DV90S01.D&OYMD1.,
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=492,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                                      
  OUTFIL FNAMES=SORTOUT1,           -- LITIGIO             
       INCLUDE=(1,2,CH,EQ,C'01',AND,240,1,CH,EQ,C'L')    --- SITUACION
  OUTFIL FNAMES=SORTOUT2,           -- BAJA        
       INCLUDE=(1,2,CH,EQ,C'01',AND,
	            240,1,CH,EQ,C'B',AND,     --- SITUACION
	            361,1,CH,EQ,C'S',AND,     --- INDICATORS
				488,5,PD,EQ,0)            --  CONPEL
/*                                                                     
//*                                                                    
//PAS00191 EXEC PGM=PLEXP022,COND=(0,GE,PAS00190)                      
//*               	   
//PAS00200 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00200 JOINKEYS POR CONTRATO kc41 VS dv90 PARA SACAR AMORTIZADOS
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTJNF1  DD DSN=PPE.C00.PUENTE11.JPE8080D.KC41S00.D&OYMD1.,
//             DISP=SHR                                                
//SORTJNF2  DD DSN=PPE.C00.PUENTE11.JPE8080D.DV90S00.D&OYMD1.,    
//             DISP=SHR                                                
//MATCH     DD DSN=PPE.C00.PUENTE11.JPE8080D.AMORT00.D&OYMD1.,           
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=023,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  JOIN UNPAIRED,F1,F2 
  SORT FIELDS=(1,2,CH,A,3,3,CH,A,6,8,PD,A)    
  JOINKEYS FILE=F1,FIELDS=(1,2,A,3,3,A,6,8,A)
  JOINKEYS FILE=F2,FIELDS=(1,2,A,3,3,A,6,8,A)
  REFORMAT FIELDS=(F1:1,13,30,10,?)                                 
  SORT FIELDS=COPY                                                     
  OUTFIL FNAMES=MATCH,                                                 
         INCLUDE=(24,1,CH,EQ,C'B'),                                   
         BUILD=(1,23)  --CONTRATO AMORTIZADO                           
  SUM FIELDS=NONE
/*                                                                     
//PAS00201 EXEC PGM=PLEXP022,COND=(0,GE,PAS00200)                      
//*
//PAS00210 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00210 SORT FORMATEO DE DV90 BAJAS                                       
//*********************************************************************
//SYSOUT   DD  SYSOUT=*   
//SORTJNF1  DD DSN=PDV.C00.PUENTE1.KC4100.DIARIO.V01(0),
//             DISP=SHR                                                
//SORTJNF2  DD DSN=PPE.C00.PUENTE11.JPE8080D.DV90S01.D&OYMD1.,     
//             DISP=SHR                                                
//MATCH     DD DSN=PPE.C00.PUENTE11.JPE8080D.BAJASDV.D&OYMD1.,           
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=023,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  JOIN UNPAIRED,F1,F2 
  SORT FIELDS=(1,2,CH,A,3,3,CH,A,6,8,PD,A)    
  JOINKEYS FILE=F1,FIELDS=(1,2,A,3,3,A,6,8,A)
  JOINKEYS FILE=F2,FIELDS=(1,2,A,3,3,A,6,8,A)
  REFORMAT FIELDS=(F1:1,13,30,10,?)                                 
  SORT FIELDS=COPY                                                     
  OUTFIL FNAMES=MATCH,                                                 
         INCLUDE=(24,1,CH,EQ,C'B'),                                   
         BUILD=(1,23)  --CONTRATO BAJAS                           
  SUM FIELDS=NONE
/*                                                                     
//*                                                                    
//PAS00211 EXEC PGM=PLEXP022,COND=(0,GE,PAS00210)                      
//*
//PAS00220 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00220 SORT FORMATEO DE KC41 VENTAS                                       
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=PPE.C00.PUENTE11.JPE8080D.KC41S01.D&OYMD1.,       
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8080D.VENTAS.D&OYMD1.,  
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=23,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)
  SORT FIELDS=(1,2,CH,A,3,3,CH,A,6,8,PD,A)
  OUTREC FIELDS=(1,13,30,10)    -- CONTRATO BAJA
  SUM FIELDS=NONE
/*                                                                     
//*                                                                    
//PAS00221 EXEC PGM=PLEXP022,COND=(0,GE,PAS00220)                      
//*       
//PAS00230 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00230 JOINKEYS POR CONTRATO PARA DESCARTAR AMORTIZADOS Y VENTAS
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTJNF1  DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S09.D&OYMD1.,
//             DISP=SHR                                                
//SORTJNF2  DD DSN=PPE.C00.PUENTE11.JPE8080D.AMORT00.D&OYMD1.,     
//             DISP=SHR  
//          DD DSN=PPE.C00.PUENTE11.JPE8080D.BAJASDV.D&OYMD1.,    
//             DISP=SHR                                                 
//          DD DSN=PPE.C00.PUENTE11.JPE8080D.VENTAS.D&OYMD1.,   
//             DISP=SHR                                                 
//MATCH     DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S10.D&OYMD1.,           
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=039,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  JOIN UNPAIRED,F1,F2   
  JOINKEYS FILE=F1,FIELDS=(5,3,A,8,8,A)
  JOINKEYS FILE=F2,FIELDS=(3,3,A,6,8,A)
  REFORMAT FIELDS=(F1:1,39,?)                                 
  SORT FIELDS=COPY                                                     
  OUTFIL FNAMES=MATCH,                                                 
         INCLUDE=(40,1,CH,EQ,C'1'),                                   
         BUILD=(1,39)  --CONTRATO AMORTIZADO                           
/*                                                                     
//PAS00231 EXEC PGM=PLEXP022,COND=(0,GE,PAS00230)                      
//*
//PAS00240 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00240 JOINKEYS POR CONTRATO PARA CAMBIO FECHA BAJA AMORTIZADOS
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTJNF1  DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S09.D&OYMD1.,
//             DISP=SHR                                                
//SORTJNF2  DD DSN=PPE.C00.PUENTE11.JPE8080D.AMORT00.D&OYMD1.,     
//             DISP=SHR  
//          DD DSN=PPE.C00.PUENTE11.JPE8080D.BAJASDV.D&OYMD1.,    
//             DISP=SHR                                      
//          DD DSN=PPE.C00.PUENTE11.JPE8080D.VENTAS.D&OYMD1.,           
//             DISP=SHR                                      
//MATCH1    DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S11.D&OYMD1.,           
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=049,RECFM=FB                                      
//MATCH2    DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S12.D&OYMD1.,           
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=049,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  JOIN UNPAIRED,F1,F2   
  JOINKEYS FILE=F1,FIELDS=(5,3,A,8,8,A)
  JOINKEYS FILE=F2,FIELDS=(3,3,A,6,8,A)
  REFORMAT FIELDS=(F1:1,39,F2:14,10,?)                                 
  SORT FIELDS=COPY                                                     
  OUTFIL FNAMES=MATCH1,                                                 
         INCLUDE=(50,1,CH,EQ,C'B'),                                   
         BUILD=(1,49)                --CONTRATO AMORT MAS FECHA BAJA AMORT  
  OUTFIL FNAMES=MATCH2,                                                 
         INCLUDE=(50,1,CH,EQ,C'1'),                                   
         BUILD=(1,39,28,10)          --CONTRATOS NO AMORTIZADO                           
/*                                                                     
//PAS00241 EXEC PGM=PLEXP022,COND=(0,GE,PAS00240)                      
//*
//PAS00250 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00250 SI LA FECHA DE EE0201 ES MAYOR QUE AMORTIZADO                   
//*          SE REEMPLAZA LA DE EE0201 POR LA BAJA DE AMORTIZADO         
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S11.D&OYMD1.,         
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S12.D&OYMD1.,         
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S13.D&OYMD1.,       
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=039,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                                                     
  OUTREC IFTHEN=(WHEN=(028,10,CH,GT,40,10,CH),                   
                 BUILD=(1,27,40,10,38,02)),                           
         IFTHEN=(WHEN=NONE,BUILD=(1,39))                              
/*                                                                     
//*                                                                    
//PAS00251 EXEC PGM=PLEXP022,COND=(0,GE,PAS00250)     
//*
//PAS00260 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00260 QUITA LOS QUE HAN EMPEZADO DESPUES DE HABER FINALIZADO    
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S13.D&OYMD1.,          
//             DISP=SHR                                                
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8080D.PE16S14.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=039,RECFM=FB                                      
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                                                     
  INCLUDE COND=(18,10,CH,NE,28,10,CH,AND,(18,10,CH,LT,28,10,CH))                          
/*                                                                     
//PAS00261 EXEC PGM=PLEXP022,COND=(0,GE,PAS00260)                      
//*                                             

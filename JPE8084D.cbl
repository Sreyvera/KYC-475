//*%OPC SCAN                                                           
//JPE8084D JOB (0000,SYST),MSGCLASS=X,MSGLEVEL=(1,1),                  
//             CLASS=F                                                 
//*                                                                    
//LIBPROC  JCLLIB ORDER=(GRBS.PRE1.PRCLIB)                             
//         INCLUDE MEMBER=INCLJBP                                      
//*                                                                    
//*********************************************************************
//*                             JPE8084D                               
//* GENERA ARCHIVO DE CARGA DIARIA DE PEL4
//*********************************************************************
//*                                                                    
//PAS00010 EXEC PGM=IDCAMS                                             
//*********************************************************************
//* PAS00010 BORRADO DE FICHEROS                                       
//*********************************************************************
//SYSPRINT  DD SYSOUT=*                                                
//SYSIN     DD *                                                       
   DELETE PPE.C00.PUENTE11.JPE8084D.TRES00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8084D.PEL4S00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8084D.PEL4S01.D&OYMD1.  
   DELETE PPE.C00.PUENTE11.JPE8084D.PEL4S02.D&OYMD1.   
   
   IF MAXCC < 9 THEN SET MAXCC=0       
/*                                                                     
//*                                                                    
//PAS00011 EXEC PGM=PLEXP022,COND=(0,GE,PAS00010)
//*
//PAS00020 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00020 FORMATEA ARCHIVO TRE COMO EL FTF                                       
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=PPE.C00.PUENTE11.JPE8083D.EE02S01.D&OYMD1.,               
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8084D.TRES00.D&OYMD1.,          
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(5,4,BI,A,46,10,CH,A)                                    
  OUTREC FIELDS=(5,4,C'           ',X'0063',46,10,56,10,C'01')     
/*                                                                     
//*                                                                    
//PAS00021 EXEC PGM=PLEXP022,COND=(0,GE,PAS00020)                      
//*                                                                    
//PAS00030 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00030 UNION FICHEROS TRE Y FTF FINAL                                  
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=PPE.C00.PUENTE11.JPE8080D.PE16S14.D&OYMD1.,          
//             DISP=SHR                                                
//         DD  DSN=PPE.C00.PUENTE11.JPE8084D.TRES00.D&OYMD1.,          
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8084D.PEL4S00.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=39,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=COPY                                                     
/*                                                                     
//*                                                                    
//PAS00031 EXEC PGM=PLEXP022,COND=(0,GE,PAS00030)                      
//*                                                                    
//PAS00040 EXEC PGM=SORT,                                              
//             PARM=ABEND                                              
//*********************************************************************
//* PAS00040 ORDENAMIENTO FICHERO FINAL                                
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SORTIN   DD  DSN=PPE.C00.PUENTE11.JPE8084D.PEL4S00.D&OYMD1.,         
//             DISP=SHR                                                
//SORTOUT  DD  DSN=PPE.C00.PUENTE11.JPE8084D.PEL4S01.D&OYMD1.,          
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=30,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  OPTION DYNALLOC=(,15)                                       
  SORT FIELDS=(1,4,BI,A,18,10,CH,A,28,10,CH,A,5,3,CH,A)       
  OUTFIL FNAMES=SORTOUT,                   -- OUTPUT TO FILE 1
         INCLUDE=(18,10,CH,LT,28,10,CH),                      
         OUTREC=(1,7,16,2,18,20,C' ')                         
/*                                                                                                                                 
//*                                                                    
//PAS00041 EXEC PGM=PLEXP022,COND=(0,GE,PAS00040)                      
//*                                                                    
//PAS00050 EXEC PGM=IKJEFT1B                                           
//*********************************************************************
//* PAS00050 EJECUCIÓN PE80630 CARGA INICIAL PEL4                      
//*********************************************************************
//SYSOUT   DD  SYSOUT=*                                                
//SYSTSPRT DD  SYSOUT=*                                                
//SYSPRINT DD  SYSOUT=*                                                
//PE0001R  DD  DSN=PPE.C00.PUENTE11.JPE8084D.PEL4S01.D&OYMD1.,             
//             DISP=SHR                                                
//PE0001W  DD  DSN=PPE.C00.PUENTE11.JPE8084D.PEL4S02.D&OYMD1.,            
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                              
//             LRECL=60,RECFM=FB                                       
//SYSTSIN   DD *                                                       
 DSN SYSTEM(DBP0)                                                      
 RUN PROGRAM(PE80630) PLAN(SIBISBAT)                                   
 END                                                                   
/*                                                                     
//*                                                                    
//PAS00051 EXEC PGM=PLEXP022,COND=(0,GE,PAS00050)                      
//*                                                                    
//                                                                     
//                                                                     
//                                                                     
//                                                                     
//                                                                     
//                                                                     
//                                                                     
//                                                                     
//                                                                     
//PAS00060 EXEC PROC=DB0006,                                           
//             UTILID=&OJOBNAME.                                       
//*********************************************************************
//* PAS00060 CARGA INICIAL PEL4                                        
//*********************************************************************
//SYSREC00 DD  DSN=PPE.C00.PUENTE11.JPE8084D.PEL4S02.D&OYMD1.,          
//             DISP=SHR                                                
//SYSIN    DD  DSN=GRBS.PRE1.CTCLIB(PLIBMLO1),                         
//             DISP=SHR                                                
//          DD *                                                       
       INTO TABLE DB2PROD.PEL400                                       
       (                                                               
    PE1100_NUMPERSONA    POSITION(1)   INTEGER     ,                   
    BS2100_CODRELPECO    POSITION(5)   SMALLINT    ,                   
    PEK700_FECALTCO      POSITION(7)   DATE EXTERNAL (10),             
    PEK700_FECBAJCO      POSITION(17)  DATE EXTERNAL (10),             
    BS0000_FECULTACT     POSITION(27)  DATE EXTERNAL (10),             
    BS0000_HORULTACT     POSITION(37)  TIME EXTERNAL (08),             
    BS0000_CODTERMINA    POSITION(45)  CHAR (8) ,                      
    BS0000_CODUSUARIO    POSITION(53)  CHAR (8) ,                      
       )                                                               
//*                                                                    
//PAS00061 EXEC PGM=PLEXP022,COND=(4,GE,PAS00060.IBMLOAD)              
//*                        
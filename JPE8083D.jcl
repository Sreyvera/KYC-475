//*%OPC SCAN                                                           
//JPE8083D JOB (0000,SYST),MSGCLASS=X,MSGLEVEL=(1,1),                  
//             CLASS=F                                                 
//*                                                                    
//LIBPROC  JCLLIB ORDER=(GRBS.PRE1.PRCLIB)                             
//         INCLUDE MEMBER=INCLJBP                                      
//*                                                                    
//*********************************************************************
//*                             JPE8083D                               
//* GENERA ARCHIVO DE TRE-FTF DIARIO TERCERA PARTE
//*********************************************************************
//*                                                                    
//PAS00010 EXEC PGM=IDCAMS                                             
//*********************************************************************
//* PAS00010 BORRADO DE FICHEROS                                       
//*********************************************************************
//SYSPRINT  DD SYSOUT=*                                                
//SYSIN     DD *                                                       
   DELETE PPE.C00.PUENTE11.JPE8083D.EE02S00.D&OYMD1.
   DELETE PPE.C00.PUENTE11.JPE8083D.EE02S01.D&OYMD1.   
   
   IF MAXCC < 9 THEN SET MAXCC=0       
/*                                                                     
//*                                                                    
//PAS00011 EXEC PGM=PLEXP022,COND=(0,GE,PAS00010)
//*
//PAS00020 EXEC PGM=SORT,PARM=ABEND                                    
//*********************************************************************
//* PAS00020 ORDENA REGISTROS POR EMPRESA TIPO DE RELACIóN Y
//*          FECHA PARA ESTABLECER LOS TRAMOS HISTóRICOS DE RELACIóN CO
//*          LA EMPRESA                                                
//*********************************************************************
//SYSOUT    DD SYSOUT=*                                                
//SORTIN    DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S01.D&OYMD1.,               
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S02.D&OYMD1.,               
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S03.D&OYMD1.,               
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S04.D&OYMD1.,               
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S05.D&OYMD1.,               
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S06.D&OYMD1.,               
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S07.D&OYMD1.,               
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S08.D&OYMD1.,               
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S09.D&OYMD1.,               
//             DISP=SHR                                                
//          DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S10.D&OYMD1.,               
//             DISP=SHR     
//          DD DSN=PPE.C00.PUENTE11.JPE8082D.EE02S11.D&OYMD1.,               
//             DISP=SHR                                            
//SORTOUT   DD DSN=PPE.C00.PUENTE11.JPE8083D.EE02S00.D&OYMD1.,
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                          
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
  OPTION DYNALLOC=(,15)                                                
  SORT FIELDS=(1,4,BI,A,                    -- NUMPERSEMP              
               92,2,CH,A,                   -- ETIQUETA                
               46,10,CH,A,                  -- FECHA ALTA              
               13,2,BI,A)                   -- VINCULO                 
/*                                                                     
//*                                                                    
//PAS00021 EXEC PGM=PLEXP022,COND=(0,GE,PAS00020)                      
//*     
//PAS00030 EXEC PGM=PE80620                                            
//*********************************************************************
//* PAS00030 INTEGRA ADMINISTRADORES Y FIRMANTES EN LOS HUECOS  
//*          DE FECHA QUE HAYA EN LOS REGISTROS DE TRE DE PORCENTAJES                                  
//*********************************************************************
//SYSPRINT  DD SYSOUT=*                                                
//SYSOUT    DD SYSOUT=*                                                
//PE0001R   DD DSN=PPE.C00.PUENTE11.JPE8083D.EE02S00.D&OYMD1.,
//             DISP=SHR                                                
//PE0001W   DD DSN=PPE.C00.PUENTE11.JPE8083D.EE02S01.D&OYMD1.,         
//             DISP=(,CATLG,DELETE),                                   
//             SPACE=(CYL,(1000,100),RLSE),                            
//             LRECL=99,RECFM=FB                                       
//SYSIN     DD *                                                       
3                                                                      
/*                                                                     
//*                                                                    
//PAS00031 EXEC PGM=PLEXP022,COND=(0,GE,PAS00030)                      
//*                                                            
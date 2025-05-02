      ******************************************************************
      *
      * (C) Copyright 2010-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************

      *****************************************************************
      * This is a small mainframe unit test that always fails
      *****************************************************************
      
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MFUTASCI.
       AUTHOR. MF.
       INSTALLATION. PC.
       DATE-WRITTEN.  01/01/2015.
       DATE-COMPILED. 01/01/2015.
       SECURITY.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. PC.
       OBJECT-COMPUTER. PC.
       SPECIAL-NAMES.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       DATA DIVISION.
        FILE SECTION.
        WORKING-STORAGE SECTION.
        01 WS-FAIL-MSG    PIC x(40)
            value z"MFUTASCI has failed".

        LINKAGE SECTION.
       PROCEDURE DIVISION.
        DECLARATIVES.
        END DECLARATIVES.
        main-processing SECTION.
         mainline-paragraph.

      * This always fails
           IF WS-FAIL-MSG NOT EQUAL SPACES
             CALL "MFUFMSGZ" using
                 by reference WS-FAIL-MSG
             END-CALL
           END-IF
             MOVE 0 TO return-code
             GOBACK.
       END PROGRAM MFUTASCI.

      ******************************************************************
      *
      * (C) Copyright 2010-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************
      $set sourceformat"variable"
       identification division.
       program-id. GlobalMetaData.
       working-storage section.
       copy "mfunit.cpy".
       procedure division.
           goback.

      *> Ensure the test cases that do not have a specific metadata entry-point
      *> are setup via the global metadata entry-point.
       entry MFU-GLOBAL-METADATA-PREFIX & "GlobalMetaData".
           evaluate MFU-MD-TESTCASE
               when "MFUTASCI"
                   move "Dialect ENTCOBOL testcase example" to MFU-MD-TESTCASE-DESCRIPTION
                   move "smoke,mf,fail" to MFU-MD-TRAITS
               when "MFUT_DATECHK"
                   move "Test case for datechk.cbl" to MFU-MD-TESTCASE-DESCRIPTION
                   move "smoke,pass" to MFU-MD-TRAITS
               when "MFUT_TCOVER"
                   move "Test case that has some paragraphs for use with testcover" to MFU-MD-TESTCASE-DESCRIPTION
                   move "smoke,pass" to MFU-MD-TRAITS
           end-evaluate
           goback.
       end program GlobalMetaData.

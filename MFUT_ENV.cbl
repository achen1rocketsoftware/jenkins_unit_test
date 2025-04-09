      ******************************************************************
      *
      * (C) Copyright 2010-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************
       copy "mfunit_prototypes.cpy".
       program-id. MFUT_ENV.
       working-storage section.
       78 TEST-Env value "ENV".
       copy "mfunit.cpy".
       01 ws-stuff        pic x(60) value spaces.
       procedure division.
           *> this test will always fail unless the env var MFUT_ENV_PASS is set
           accept ws-stuff from environment "MFUT_ENV_PASS"
           exhibit named ws-stuff
           if ws-stuff equal spaces
               goback returning MFU-FAIL-RETURN-CODE
           end-if

           goback returning MFU-PASS-RETURN-CODE.

      $region Test Configuration

       entry MFU-TC-SETUP-PREFIX & TEST-Env.
           goback returning 0
       .

       entry MFU-TC-TEARDOWN-PREFIX & TEST-Env.
           goback returning 0
       .

       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-Env.
           move "A test that only passes when a environment " &
                 "variable is set " to MFU-MD-TESTCASE-DESCRIPTION
           move 10000 to MFU-MD-TIMEOUT-IN-MS
           move "smoke,env,pass" to MFU-MD-TRAITS
           set MFU-MD-SKIP-TESTCASE to false
           goback returning 0
       .

      $end-region
       end program MFUT_ENV.
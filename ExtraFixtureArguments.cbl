      ******************************************************************
      *
      * (C) Copyright 2010-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************

       program-id. ExtraFixtureArguments.
       working-storage section.
       copy "mfunit.cpy".
       procedure division.
           goback.

           entry MFU-GLOBAL-COMMANDLINE-PREFIX & "ExtraFixtureArguments".
               *> Extra argument to the unit test runner can be placed in the COBOL
               *> field called MFU-GLOBAL-COMMANDLINE-ARG.
               *>
               *> If MFU-GLOBAL-COMMANDLINE-ARG contains the -trait argument
               *>  it will only execute the test cases with this particular trait
               *>  and mark the other tests as skipped.
               *>
               *> For example to run as the tests marked with the pass trait:
               *>   move "-traits:pass" to MFU-GLOBAL-COMMANDLINE-ARG
               *> or to run all the file related tests
               *>  move "-traits:fileexample" to MFU-GLOBAL-COMMANDLINE-ARG
           goback.
       end program ExtraFixtureArguments.
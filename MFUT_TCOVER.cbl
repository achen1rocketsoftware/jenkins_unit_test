      ******************************************************************
      *
      * (C) Copyright 2010-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************
       program-id. MFUT_TCOVER.
       working-storage section.
       copy "mfunit.cpy".

       01 test-fail-count     binary-long value 0.
       01 thread-id           pointer.

       *> Testcase TCOVER
       procedure division.
       tcover-top.
           perform para-1
           perform para-3 through para-4
           perform para-3
           perform para-4 2 times
           goback returning test-fail-count.

       para-1.
           display "In Para-1"
           call "CBL_THREAD_SLEEP" using by value 1.

       para-2.
           display "In Para-2 (not used)"
           call "CBL_THREAD_SELF" using by reference thread-id.

       para-3.
           display "In Para-3".

       para-4.
           display "In Para-4".

       end program.

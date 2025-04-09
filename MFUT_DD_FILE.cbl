      ******************************************************************
      *
      * (C) Copyright 2010-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************
       program-id. MFUT_DD_FILE.
       environment division.
       input-output section.
           file-control.
           select cust assign external customers
           organization is line sequential
           file status is f-status.
       data division.
       file section.
       fd cust.
       01 cust-file.
          03 customer-id    pic 9(5).
          03 customer-info  pic x(65).

       working-storage section.
       copy "mfunit.cpy".
       78 TEST-MFUT_DD_FILE value "DD_FILE".

       01 f-status    pic xx.
       88 f-status-ok value "00".
       01 record-count      binary-long.
       01 fail-message.
           03                  pic x(19) value "Record count < 5 (".
           03 record-count-d   pic 999.
           03                  pic xx value z")".
       procedure division.
           move 0 to record-count
           open input cust
           if not f-status-ok
               exhibit named f-status
               goback returning 1
           end-if

           *> read all the records and do a simple check on each record
           perform until not f-status-ok
               read cust not end
                   add 1 to record-count
                   *> quick sanity test
                   if customer-id > 100 or customer-info equal spaces
                       call MFU-ASSERT-FAIL-Z using
                          by reference z"Invalid customer record"
                       end-call
                   end-if
               end-read
           end-perform
           close cust

           *> ensure we have at least 5 records in the file
           if record-count < 5
               move record-count to record-count-d
               call MFU-ASSERT-FAIL-Z using
                  by reference fail-message
               end-call
           end-if

           display "Customer file contains at least 5 records".

           goback returning MFU-PASS-RETURN-CODE.

       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-MFUT_DD_FILE.
           move "A I/O based test that uses DD_ to locate the file"
                 to MFU-MD-TESTCASE-DESCRIPTION
           move 10000 to MFU-MD-TIMEOUT-IN-MS
           move "smoke,fileexample,pass" to MFU-MD-TRAITS
           set MFU-MD-SKIP-TESTCASE to false
           goback returning 0
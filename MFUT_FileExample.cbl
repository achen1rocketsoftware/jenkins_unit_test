      ******************************************************************
      *
      * (C) Copyright 2010-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************

      *****************************************************************
      * This is a small unit test that shows how a setup/teardown
      * entry points can be used to make a unit test easier to maintain
      *****************************************************************
       program-id. "MFUT_FileExample".
       environment division.
       input-output section.
           file-control.
           select cust assign to 'cust.txt'
           organization is line sequential
           file status is ws-cust-file-status.
       data division.
       file section.
       fd cust.
       01 cust-file.
         02 cust-grp.
          03 customer-id     pic 9(5).
          03 customer-fname  pic x(14).
          03 customer-sname  pic x(16).
          03 customer-gender pic x.
           88 customer-valid  value "m", "M", "f", "f".
           88 customer-male   value "m", "m".
           88 customer-female value "f", "f".

       working-storage section.
       78 TEST-FileExample value "FileExample".
       copy "mfunit.cpy".
       01 ws-cust-file-status    pic xx.
        88 cust-ok-status        value "00".
        88 cust-eof-status       value "10".

       01                        pic x.
       88 delete-file-on-exist   value "y", false "n".

       01 fail-count             binary-long.
       procedure division.
           open input cust
           set cust-ok-status to true
           perform until not cust-ok-status
               read cust
               if not cust-eof-status
                perform assert-ok-read
                perform validate-record
               end-if
           end-perform
           close cust
           goback returning fail-count
       .

       validate-record section.
           if not customer-valid
               call MFU-ASSERT-FAIL-Z using
                  by reference z"Customer record is not valid"
               end-call
               add 1 to fail-count
               exhibit named cust-grp
           end-if
       .


       assert-ok-read section.
           if not cust-ok-status
               call MFU-ASSERT-FAIL-Z using
                  by reference z"Bad file status (Read)"
               end-call
               exhibit named ws-cust-file-status
               add 1 to fail-count
           end-if
       .

      $region Test Configuration

       test-case-setup section.
       entry MFU-TC-SETUP-PREFIX & TEST-FileExample.
           move 0 to fail-count
           open input cust
           if cust-ok-status
               call MFU-ASSERT-FAIL-Z using
                  by reference z"Bad file status (Open/File Exists)"
               end-call
               add 1 to fail-count
               set delete-file-on-exist to false
               *> expect all operations to fail if cust.txt already
               *> exists..
           else
               set delete-file-on-exist to true
           end-if

           *> create a cust.txt with sample data for test-case
           open output cust
           if not cust-ok-status
               call MFU-ASSERT-FAIL-Z using
                  by reference z"Bad file status (Open)"
               end-call
               add 1 to fail-count
           end-if

           *> write a customer or two
           move 1 to customer-id
           move "Peter" to customer-fname
           move "Johnson" to customer-sname
           set customer-male to true
           write cust-file

           move 2 to customer-id
           move "Rebecca" to customer-fname
           move "Smith" to customer-sname
           set customer-female to true
           write cust-file

           close cust
           if not cust-ok-status
               call MFU-ASSERT-FAIL-Z using
                  by reference z"Bad file status (Close)"
               end-call
               add 1 to fail-count
           end-if

           goback
       .

       test-case-teardown section.
       entry MFU-TC-TEARDOWN-PREFIX & TEST-FileExample.
           *> ensure we do not leave cust.txt on disk.
           if delete-file-on-exist
               delete file cust
           end-if
           goback
       .


       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-FileExample.
           move "A self-contained file I/O based test"
                to MFU-MD-TESTCASE-DESCRIPTION
           move 10000 to MFU-MD-TIMEOUT-IN-MS
           move "smoke,fileexample,pass" to MFU-MD-TRAITS
           set MFU-MD-SKIP-TESTCASE to false
           goback returning 0
       .

      $end-region
       end program.
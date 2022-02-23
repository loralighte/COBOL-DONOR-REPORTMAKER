      *****************************************************************
      * Program name:    tutorial                               
      * Original author: Kai Lyons                                
      *
      * Maintenence Log                                              
      * Date      Author        Maintenance Requirement               
      * --------- ------------  --------------------------------------- 
      * 02/22/22 MYNAME  Created for COBOL class         
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  tutorial.
       AUTHOR. Kai Lyons. 
       INSTALLATION. COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN. 02/22/22. 
       DATE-COMPILED. 02/22/22. 
       SECURITY. NON-CONFIDENTIAL.
      ******************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CustomerReport ASSIGN TO "CustReport.rpt"
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT CustomerFile ASSIGN TO "Customer.dat"
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION. 
       FILE SECTION. 
       FD CustomerReport.
       01 PrintLine PIC X(99).
       FD CustomerFile.
       01 CustomerData.
           02 IDNum PIC 9(5).
           02 CustName.
              03 FirstName PIC X(15).
              03 LastName  PIC X(15).
           02 DonationAmnt PIC 9(4)V99.
           88 WSEOF VALUE 'Y' FALSE 'N'.
       WORKING-STORAGE SECTION.
       01 WSCustomer.
           02 WSIDNum PIC 9(5).
           02 WSCustName.
              03 WSFName PIC X(15).
              03 WSLName PIC X(15).
       01 PageHeading.
           02 FILLER  PIC X(13) VALUE "DONATION LIST".
       01 PageFooting.
           02 FILLER  PIC X(15) VALUE SPACE.
           02 FILLER  PIC X(7) VALUE "Page : ".
           02 PageNum PIC Z9.
       01 Head.
           02 FILLER PIC X(10) VALUE " IDNum    ".
           02 FILLER PIC X(22) VALUE "First Name            ".
           02 FILLER PIC X(22) VALUE "Last Name             ".
           02 FILLER PIC X(22) VALUE "Donation Amount       ".
       01 CustomerDetailLine.
           02 FILLER      PIC X VALUE SPACE.
           02 PrintCustID PIC 9(5).
           02 FILLER      PIC X(4) VALUE SPACE.
           02 PrintCustFN PIC X(15).
           02 FILLER      PIC X(7) VALUE SPACE.
           02 PrintCustLN PIC X(15).
           02 FILLER      PIC X(7) VALUE SPACE.
           02 PrintCustDA PIC 9(5)V99.
       01 ReportFooting   PIC X(13) VALUE "END OF REPORT".
       01 LineCount       PIC 99 VALUE ZERO.
           88 NewPageReq  VALUE 40 THRU 99.
       01 PageCount       PIC 99 VALUE ZERO.
       PROCEDURE DIVISION.
           OPEN INPUT CustomerFile.
              OPEN OUTPUT CustomerReport.
                 PERFORM PrintPageHeading
                 READ CustomerFile
                    AT END SET WSEOF TO TRUE
                 END-READ
                 PERFORM PrintReportBody UNTIL WSEOF 
                 WRITE PrintLine FROM ReportFooting AFTER ADVANCING 3
                 LINES.
           CLOSE CustomerReport, CustomerFile.
           STOP RUN.
       
        PrintPageHeading.
           WRITE PrintLine FROM PageHeading AFTER ADVANCING PAGE 
           WRITE PrintLine FROM Head AFTER 3 LINES
           MOVE 3 TO LineCount
           ADD 1 TO PageCount.

        PrintReportBody.
           IF NewPageReq
              MOVE PageCount TO PageNum
              WRITE PrintLine FROM PageFooting AFTER ADVANCING 1 LINES
              PERFORM PrintPageHeading
           END-IF 
           MOVE IDNum        TO PrintCustID 
           MOVE FirstName    TO PrintCustFN 
           MOVE LastName     TO PrintCustLN
           MOVE DonationAmnt TO PrintCustDA
           WRITE PrintLine FROM CustomerDetailLine AFTER 
           ADVANCING 1 LINE
           ADD 1 TO LineCount
           READ CustomerFile 
              AT END SET WSEOF TO TRUE
           END-READ.

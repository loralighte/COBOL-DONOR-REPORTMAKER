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
           SELECT CustomerFile ASSIGN TO "Customer.dat"
           ORGANIZATION IS LINE SEQUENTIAL
           ACCESS IS SEQUENTIAL.
       DATA DIVISION. 
       FILE SECTION. 
       FD CustomerFile.
       01 CustomerData.
           02 IDNum PIC 9(5).
           02 CustName.
              03 FirstName PIC X(15).
              03 LastName  PIC X(15).
           02 DonationAmnt PIC 9(5)V99.
       WORKING-STORAGE SECTION.
       01 WSCustomer.
           02 WSIDNum PIC 9(5).
           02 WSCustName.
              03 WSFName PIC X(15).
              03 WSLName PIC X(15).
       01 WSDonationAmt PIC 9(5)V99.
       PROCEDURE DIVISION.
           OPEN EXTEND CustomerFile
              DISPLAY "ENTER ID: " WITH NO ADVANCING 
              ACCEPT IDNum 
              DISPLAY "ENTER FIRST NAME: " WITH NO ADVANCING 
              ACCEPT FirstName 
              DISPLAY "ENTER LAST NAME: " WITH NO ADVANCING 
              ACCEPT LastName  
              DISPLAY "ENTER DONATION AMOUNT: " WITH NO ADVANCING 
              ACCEPT DonationAmnt 
              WRITE CustomerData
              END-WRITE.
           CLOSE CustomerFile 
           STOP RUN.

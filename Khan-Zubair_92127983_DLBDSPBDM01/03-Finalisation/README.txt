DLBDSPBDM01 - Build a Data Mart in SQL
Final Submission
========================================

Author        : Zubair Ahmed Khan
Matriculation : 92127983
Programme     : B.Sc. Computer Science
University    : IU International University of Applied Sciences
Course        : DLBDSPBDM01 - Build a Data Mart in SQL
Submission    : 2026-07-29

GitHub        : https://github.com/zbr-khn/SQL


CONTENTS OF THIS FOLDER
-----------------------

1. 20250628_Zubair_Khan_92127983_DLBDSPBDM01_P3_Abstract.pdf
   - Two-page academic Abstract (Phase 3)

2. 20250628_Zubair_Khan_92127983_DLBDSPBDM01_P1.pdf
   - Phase 1: Requirements Specification, ER Diagram, Data Dictionary

3. 20250628_Zubair_Khan_92127983_DLBDSPBDM01_P2.pdf
   - Phase 2: Presentation deck (slides, SQL statements, screenshots, test cases)

4. Installation_Manual.pdf
   - Step-by-step guide for installing MySQL, deploying the database,
     and verifying the installation

5. SQL_Documentation.pdf
   - Technical documentation explaining how the SQL script is organised,
     the execution order, and the dependencies

6. Database_Metadata.pdf
   - One-page metadata summary covering tables, keys, normalisation,
     test cases, and features

7. Final_Submission_Checklist.pdf
   - Checklist verifying every deliverable required by IU before submission

8. airbnb.sql
   - Self-contained MySQL script that creates the AirbnbDB database

9. 20250628_Zubair_Khan_92127983_DLBDSPBDM01_P3.pdf
   - The single combined PDF for the portfolio
     (Phases 1, 2, and 3 merged into one file)


WHERE TO SUBMIT WHAT
--------------------

- PebblePad : upload 20250628_Zubair_Khan_92127983_DLBDSPBDM01_P3.pdf
- ATLAS     : attach the dated PDFs (P1, P2, P3_Abstract) plus
              Installation_Manual.pdf, SQL_Documentation.pdf,
              Database_Metadata.pdf, and Final_Submission_Checklist.pdf


HOW TO INSTALL THE DATABASE
---------------------------

See Installation_Manual.pdf. Quick steps:
1. Install MySQL Server 8.0 and MySQL Workbench 8.0.
2. Open airbnb.sql in Workbench (File > Open SQL Script).
3. Click Execute (Ctrl+Shift+Enter).
4. Verify with:
       SHOW DATABASES;
       USE AirbnbDB;
       SHOW TABLES;
       SELECT COUNT(*) FROM <any table>;
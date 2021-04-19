*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 04/15/2021 at 04:12:16
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZHW_DB_ALM_ASSET................................*
DATA:  BEGIN OF STATUS_ZHW_DB_ALM_ASSET              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHW_DB_ALM_ASSET              .
CONTROLS: TCTRL_ZHW_DB_ALM_ASSET
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZHW_DB_ALM_LIC..................................*
DATA:  BEGIN OF STATUS_ZHW_DB_ALM_LIC                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHW_DB_ALM_LIC                .
CONTROLS: TCTRL_ZHW_DB_ALM_LIC
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZHW_DB_ALM_PHOTO................................*
DATA:  BEGIN OF STATUS_ZHW_DB_ALM_PHOTO              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZHW_DB_ALM_PHOTO              .
CONTROLS: TCTRL_ZHW_DB_ALM_PHOTO
            TYPE TABLEVIEW USING SCREEN '0003'.
*.........table declarations:.................................*
TABLES: *ZHW_DB_ALM_ASSET              .
TABLES: *ZHW_DB_ALM_LIC                .
TABLES: *ZHW_DB_ALM_PHOTO              .
TABLES: ZHW_DB_ALM_ASSET               .
TABLES: ZHW_DB_ALM_LIC                 .
TABLES: ZHW_DB_ALM_PHOTO               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

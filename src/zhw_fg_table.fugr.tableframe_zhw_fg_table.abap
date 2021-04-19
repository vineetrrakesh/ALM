*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZHW_FG_TABLE
*   generation date: 04/13/2021 at 17:12:43
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZHW_FG_TABLE       .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.

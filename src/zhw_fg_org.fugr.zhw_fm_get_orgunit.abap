function zhw_fm_get_orgunit.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(ORG_UNIT) TYPE  HROBJID
*"     REFERENCE(BEGDA) TYPE  BEGDA
*"     REFERENCE(ENDDA) TYPE  ENDDA
*"  TABLES
*"      ORG_LIST TYPE  ZHW_T_ORG_LIST
*"----------------------------------------------------------------------
  data it_hrp1001 like hrp1001 occurs 0 with header line.
  data : temp_org like hrp1001-sobid .
  data: tstext type stext.
  select * from hrp1001 into it_hrp1001
                                              where plvar = '01'
                                                   and otype = 'O'
                                                   and objid = org_unit
                                                   and rsign = 'B'
                                                   and relat = '002'
                                                   and sclas = 'O'
                                                   and begda <= begda
                                                   and endda >= endda.
    org_list-org_id = it_hrp1001-sobid.
    select single stext from hrp1000 into tstext where plvar = '01'
                                             and objid = it_hrp1001-sobid
                                             and otype = 'O'
                                             and begda <= begda
                                             and endda >= endda.
    org_list-org_name = tstext.
    select single sobid from hrp1001 into temp_org where plvar = '01'
                                              and otype = 'O'
                                              and objid = it_hrp1001-sobid
                                              and rsign = 'B'
                                              and relat = '002'
                                              and sclas = 'O'
                                              and begda <= begda
                                              and endda >= endda.
    if sy-subrc <> 0.
      org_list-no_sub_orgs = 'X'.
    endif.
    append org_list.
    clear org_list .
  endselect.

endfunction.

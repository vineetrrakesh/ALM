class ZHW_CL_ALM_ASSIST definition
  public
  create private .

public section.

  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to ZHW_CL_ALM_ASSIST .
  methods GET_POLICIES
    importing
      !IV_COMM_CONTRACT type CACS_CTRTBU_ID
    returning
      value(RT_PFO) type ZHW_T_PFO .
protected section.
private section.

  class-data SR_INSTANCE type ref to ZHW_CL_ALM_ASSIST .
ENDCLASS.



CLASS ZHW_CL_ALM_ASSIST IMPLEMENTATION.


  method GET_INSTANCE.
    IF sr_instance IS INITIAL.
      CREATE OBJECT sr_instance.
    ENDIF.

    ro_instance = sr_instance.
  endmethod.


  method get_policies.
    data: lt_pfo       type zhw_t_pfo,
          ls_seg       type pfo_seg,
          lv_segnr     type pfo_segnr,
          lv_date_time type cacs_busitime_b.

    check iv_comm_contract is not initial.
    lv_segnr = iv_comm_contract.

    lv_date_time = sy-datlo.

    select single * from pfo_seg into ls_seg where seg_typ = '0CCS'
                                                and segnr = lv_segnr
                                                and busi_begin le lv_date_time
                                                and busi_end ge lv_date_time
                                                and flg_cancel_obj = abap_false
                                                and flg_cancel_vers = abap_false.
    if sy-subrc <> 0.
      return.
    endif.

    select * from pfo_gzo into table @data(lt_gzo) where seg_id = @ls_seg-seg_id.
    if sy-subrc <> 0.
      return.
    endif.

    select * from pfo_go_00ip into corresponding fields of table rt_pfo for all entries in lt_gzo
                                                  where go_id = lt_gzo-xo_id.
    loop at rt_pfo assigning field-symbol(<fs_pfo>).
      read table lt_gzo assigning field-symbol(<fs_gzo>) with key xo_id = <fs_pfo>-go_id.
      if sy-subrc = 0.
        move-corresponding <fs_gzo> to <fs_pfo>.
      endif.
      move-corresponding ls_seg to <fs_pfo>.
    endloop.

  endmethod.
ENDCLASS.

class ZHW_CL_ALM_LIC_LIST_FEEDER definition
  public
  final
  create public .

public section.

  interfaces IF_FPM_GUIBB .
  interfaces IF_FPM_GUIBB_LIST .
protected section.
private section.

  data MS_ALM_POWL type ZHW_S_ALM_POWL .
  data MT_ALM_LIC type ZHW_T_ALM_LICENSE .
ENDCLASS.



CLASS ZHW_CL_ALM_LIC_LIST_FEEDER IMPLEMENTATION.


  method IF_FPM_GUIBB_LIST~CHECK_CONFIG.
  endmethod.


  method IF_FPM_GUIBB_LIST~FLUSH.
  endmethod.


  method if_fpm_guibb_list~get_data.
    data: lv_comm_contract type cacs_ctrtbu_id,
          lt_alm_lic       type zhw_t_alm_license.

    check ms_alm_powl-guid is not initial or ms_alm_powl-comm_contract is not initial.

    lv_comm_contract = ms_alm_powl-comm_contract.
    select * from zhw_db_alm_lic into table @data(lT_license) where
        comm_contract = @lv_comm_contract.
    loop at lT_license assigning field-symbol(<fs_lic>).
      append initial line to lt_alm_lic assigning field-symbol(<fs_alm_lic>).
      move-corresponding <fs_lic> to <fs_alm_lic>.
    endloop.

    ct_data = lt_alm_lic.
    mt_alm_lic = lt_alm_lic.
    ev_data_changed = abap_true.
  endmethod.


  method IF_FPM_GUIBB_LIST~GET_DEFAULT_CONFIG.
  endmethod.


  method IF_FPM_GUIBB_LIST~GET_DEFINITION.
    eo_field_catalog ?= cl_abap_tabledescr=>describe_by_name( 'ZHW_T_ALM_LICENSE' ).
    append initial line to et_action_definition assigning field-symbol(<fs_action>).
    <fs_action>-id = 'ADD_LIC'.
    <fs_action>-text = 'Add License'.
    <fs_action>-visible = 'X'.
    <fs_action>-enabled = 'X'.
    append initial line to et_action_definition assigning <fs_action>.
    <fs_action>-id = 'DEL_LIC'.
    <fs_action>-text = 'Delete License'.
    <fs_action>-visible = 'X'.
    <fs_action>-enabled = 'X'.
  endmethod.


  method IF_FPM_GUIBB_LIST~PROCESS_EVENT.
    data: ls_alm_lic TYPE zhw_s_alm_license.
    CASE io_event->mv_event_id.
      WHEN 'ADD_LIC'.
        APPEND ls_alm_lic TO mt_alm_lic.
      WHEN 'DEL_LIC'.

      WHEN OTHERS.
    ENDCASE.
  endmethod.


  method IF_FPM_GUIBB~GET_PARAMETER_LIST.
  endmethod.


  method IF_FPM_GUIBB~INITIALIZE.
    data: lr_fpm_param type ref to cl_fpm_parameter,
          lo_ref       type ref to cl_abap_structdescr.

    lr_fpm_param ?= io_app_parameter.

    lo_ref ?= cl_abap_structdescr=>describe_by_name( 'ZHW_S_ALM_POWL' ).

    loop at lo_ref->get_components( ) into data(ls_component).
      assign component ls_component-name of structure ms_alm_powl to field-symbol(<fs_tgt_value>).

      try .
          lr_fpm_param->if_fpm_parameter~get_value(
            exporting
              iv_key   =  ls_component-name
            importing
              ev_value = <fs_tgt_value> ).
        catch cx_root.
      endtry.

    endloop.
  endmethod.
ENDCLASS.

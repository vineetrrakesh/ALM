class ZHW_CL_ALM_PFO_LIST_FEEDER definition
  public
  final
  create public .

public section.

  interfaces IF_FPM_GUIBB .
  interfaces IF_FPM_GUIBB_LIST .
protected section.
private section.

  data MS_ALM_HEADER type ZHW_S_ALM_POWL .
ENDCLASS.



CLASS ZHW_CL_ALM_PFO_LIST_FEEDER IMPLEMENTATION.


  method IF_FPM_GUIBB_LIST~CHECK_CONFIG.
  endmethod.


  method IF_FPM_GUIBB_LIST~FLUSH.
  endmethod.


  method IF_FPM_GUIBB_LIST~GET_DATA.

    check ms_alm_header-comm_contract is not initial.

    data(lt_pfo) = zhw_cl_alm_assist=>get_instance( )->get_policies(
                                iv_comm_contract = ms_alm_header-comm_contract ).
    ct_data = lt_pfo.
    ev_data_changed = abap_true.
  endmethod.


  method IF_FPM_GUIBB_LIST~GET_DEFAULT_CONFIG.
  endmethod.


  method if_fpm_guibb_list~get_definition.
    eo_field_catalog ?= cl_abap_tabledescr=>describe_by_name( 'ZHW_T_PFO' ).

    append initial line to et_action_definition assigning field-symbol(<fs_action>).
    <fs_action>-id = 'PFO_TRANSFER'.
    <fs_action>-text = 'Transfer Portfolio'.
    <fs_action>-visible = 'X'.
    <fs_action>-enabled = 'X'.

  endmethod.


  method IF_FPM_GUIBB_LIST~PROCESS_EVENT.
  endmethod.


  method IF_FPM_GUIBB~GET_PARAMETER_LIST.
  endmethod.


  method if_fpm_guibb~initialize.
    data: lr_fpm_param type ref to cl_fpm_parameter,
          lo_ref       type ref to cl_abap_structdescr.

    lr_fpm_param ?= io_app_parameter.

    lo_ref ?= cl_abap_structdescr=>describe_by_name( 'ZHW_S_ALM_POWL' ).

    loop at lo_ref->get_components( ) into data(ls_component).
      assign component ls_component-name of structure ms_alm_header to field-symbol(<fs_tgt_value>).

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

class ZHW_CL_ALM_ASSET_LIST_FEEDER definition
  public
  final
  create public .

public section.

  interfaces IF_FPM_GUIBB .
  interfaces IF_FPM_GUIBB_LIST .
protected section.
private section.

  data MS_ALM_POWL type ZHW_S_ALM_POWL .
ENDCLASS.



CLASS ZHW_CL_ALM_ASSET_LIST_FEEDER IMPLEMENTATION.


  method IF_FPM_GUIBB_LIST~CHECK_CONFIG.
  endmethod.


  method IF_FPM_GUIBB_LIST~FLUSH.
  endmethod.


  method if_fpm_guibb_list~get_data.
    data: lv_comm_contract type cacs_ctrtbu_id,
          lt_alm_asset     type zhw_t_alm_asset.
    check ms_alm_powl-guid is not initial or ms_alm_powl-comm_contract is not initial.
    lv_comm_contract = ms_alm_powl-comm_contract.
    select * from zhw_db_alm_asset into table @data(lt_assets) where
        comm_contract = @lv_comm_contract.
    loop at lt_assets assigning field-symbol(<fs_asset>).
      append initial line to lt_alm_asset assigning field-symbol(<fs_alm_asset>).
      move-corresponding <fs_asset> to <fs_alm_asset>.
    endloop.

    ct_data = lt_alm_asset.
    ev_data_changed = abap_true.
  endmethod.


  method IF_FPM_GUIBB_LIST~GET_DEFAULT_CONFIG.
  endmethod.


  method if_fpm_guibb_list~get_definition.
    eo_field_catalog ?= cl_abap_tabledescr=>describe_by_name( 'ZHW_T_ALM_ASSET' ).
    append initial line to et_action_definition assigning field-symbol(<fs_action>).
    <fs_action>-id = 'ADD_ASSET'.
    <fs_action>-text = 'Add Asset'.
    <fs_action>-visible = 'X'.
    <fs_action>-enabled = 'X'.
    append initial line to et_action_definition assigning <fs_action>.
    <fs_action>-id = 'DEL_ASSET'.
    <fs_action>-text = 'Delete Asset'.
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

class ZHW_CL_ALM_FORM_FEEDER definition
  public
  final
  create public .

public section.

  interfaces IF_FPM_GUIBB .
  interfaces IF_FPM_GUIBB_FORM .
protected section.
private section.

  data MS_ALM_HEADER type ZHW_S_ALM_POWL .
ENDCLASS.



CLASS ZHW_CL_ALM_FORM_FEEDER IMPLEMENTATION.


  method IF_FPM_GUIBB_FORM~CHECK_CONFIG.
  endmethod.


  method IF_FPM_GUIBB_FORM~FLUSH.
  endmethod.


  method if_fpm_guibb_form~get_data.
    data: ls_bp type but000.

    select single photo_path from zhw_db_alm_photo into ms_alm_header-agent_photo
      where comm_contract = ms_alm_header-comm_contract.
    if sy-subrc <> 0.
      select single * into ls_bp from but000 where partner = ms_alm_header-realo.
      if sy-subrc = 0.
        case ls_bp-type.
          when '1'.
            if ls_bp-xsexf = abap_true.
              ms_alm_header-agent_photo = '/SAP/PUBLIC/BC/ABAP/mime_demo/Lady.png'.
            else.
              ms_alm_header-agent_photo = '/SAP/PUBLIC/BC/ABAP/mime_demo/Person.png'.
            endif.
          when '2'.
            ms_alm_header-agent_photo = '/SAP/PUBLIC/BC/ABAP/mime_demo/Company.png'.
          when others.
        endcase.
      endif.
    endif.

    cs_data = ms_alm_header.
    ev_data_changed = abap_true.
  endmethod.


  method IF_FPM_GUIBB_FORM~GET_DEFAULT_CONFIG.
  endmethod.


  method if_fpm_guibb_form~get_definition.
    eo_field_catalog ?= cl_abap_tabledescr=>describe_by_name( 'ZHW_S_ALM_POWL' ).

    loop at eo_field_catalog->get_components( ) into data(ls_component).
      append initial line to et_field_description assigning field-symbol(<fs_field_descr>).
      <fs_field_descr>-name = ls_component-name.
      <fs_field_descr>-read_only = abap_true.
    endloop.

    append initial line to et_action_definition assigning field-symbol(<fs_action>).
    <fs_action>-id = 'CHANGE_CONTRACT'.
    <fs_action>-text = 'Change Commission Contract'.
    <fs_action>-visible = 'X'.
    <fs_action>-enabled = 'X'.

    append initial line to et_action_definition assigning <fs_action>.
    <fs_action>-id = 'CHANGE_PHOTO'.
    <fs_action>-text = ' '.
    <fs_action>-visible = 'X'.
    <fs_action>-enabled = 'X'.
  endmethod.


  method IF_FPM_GUIBB_FORM~PROCESS_EVENT.
  endmethod.


  method IF_FPM_GUIBB~GET_PARAMETER_LIST.
  endmethod.


  method if_fpm_guibb~initialize.
    data: lr_fpm_param type ref to cl_fpm_parameter,
          lr_cnr_ovp   type ref to if_fpm_cnr_ovp,
          lr_fpm       type ref to cl_fpm,
          lv_title     type string,
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
        catch cx_fpm_floorplan.
      endtry.
    endloop.


    lr_fpm  ?= cl_fpm_factory=>get_instance( ).
    lr_cnr_ovp ?= lr_fpm->if_fpm~get_service( cl_fpm_service_manager=>gc_key_cnr_ovp ).
    if ms_alm_header is not initial.
      concatenate 'Agent Details' ms_alm_header-stext into lv_title separated by ': '.
    else.
      lv_title = 'New Agent'.
    endif.
    try .

        lr_cnr_ovp->change_content_area_restricted(
          exporting
            iv_content_area_id = 'PAGE_1'
            iv_title = lv_title ).
      catch cx_fpm_floorplan.

    endtry.

  endmethod.
ENDCLASS.

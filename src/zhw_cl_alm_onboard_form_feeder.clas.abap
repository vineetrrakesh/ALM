class ZHW_CL_ALM_ONBOARD_FORM_FEEDER definition
  public
  final
  create public .

public section.

  interfaces IF_FPM_GUIBB .
  interfaces IF_FPM_GUIBB_FORM .
  interfaces IF_FPM_MULTI_INSTANTIABLE .
protected section.
private section.

  data MO_FPM type ref to IF_FPM .
  data MV_GUID type GUID_22 .
  data MS_ALM_AGENT type ZHW_S_ALM_ONBOARD .
ENDCLASS.



CLASS ZHW_CL_ALM_ONBOARD_FORM_FEEDER IMPLEMENTATION.


  method IF_FPM_GUIBB_FORM~CHECK_CONFIG.
  endmethod.


  method if_fpm_guibb_form~flush.
    assign is_data->* to field-symbol(<fs_data>).
    ms_alm_agent = <fs_data>.
  endmethod.


  method if_fpm_guibb_form~get_data.
    if mv_guid is not initial.
      select single * from zhw_db_agtonbord into corresponding fields of ms_alm_agent where guid = mv_guid.
      if sy-subrc = 0.
        cs_data = ms_alm_agent.
        ev_data_changed = abap_true.
      endif.
    endif.

    if ms_alm_agent-image is initial.
      ms_alm_agent-image = '/SAP/PUBLIC/BC/ABAP/mime_demo/Lady.png'.
      cs_data = ms_alm_agent.
      ev_data_changed = abap_true.
    endif.

  endmethod.


  method IF_FPM_GUIBB_FORM~GET_DEFAULT_CONFIG.
  endmethod.


  method if_fpm_guibb_form~get_definition.
    data: ls_action_definition type fpmgb_s_actiondef,
          ls_field_description type fpmgb_s_formfield_descr.

    eo_field_catalog ?= cl_abap_tabledescr=>describe_by_name( 'ZHW_S_ALM_ONBOARD' ).

    loop at eo_field_catalog->get_components( ) into data(ls_component).
      if ls_component-name = 'FILE_UPLOAD' or ls_component-name = 'FILE_NAME'.
        continue.
      endif.
      append initial line to et_field_description assigning field-symbol(<fs_field_descr>).
      <fs_field_descr>-name = ls_component-name.
      <fs_field_descr>-read_only = abap_false.
    endloop.

    ls_field_description-name = 'FILE_NAME'.
    ls_field_description-read_only = abap_true.
    append ls_field_description to et_field_description.

    CLEAR ls_field_description.
    ls_field_description-name = 'FILE_UPLOAD'.
    ls_field_description-mime_type_ref = 'MIME_TYPE'.
    ls_field_description-file_name_ref = 'FILE_NAME'.
    ls_field_description-default_display_type = 'FU'.
    append ls_field_description to et_field_description.

    append initial line to et_action_definition assigning field-symbol(<fs_action>).
    <fs_action>-id = 'CHANGE_PHOTO'.
    <fs_action>-text = ' '.
    <fs_action>-visible = 'X'.
    <fs_action>-enabled = 'X'.
  endmethod.


  method if_fpm_guibb_form~process_event.
    data : ls_alm_onboard    type zhw_db_agtonbord,
           ls_data_person    type bapibus1006_central_person,
           ls_data           type bapibus1006_central,
           lt_return         type table of bapiret2,
           ls_contract       type zcl_zicm_odata_onboard_dpc_ext=>ty_contract,
           lv_contractnumber type cacs_contract_id,
           ls_address        type bapibus1006_address,
           lv_url            type string.

    case io_event->mv_event_id.
      when 'CHANGE_PHOTO'.
        if ms_alm_agent-guid is initial.
          call function 'GUID_CREATE'
            importing
              ev_guid_22 = ms_alm_agent-guid.
        endif.

      when 'FPM_SAVE'.
        if ms_alm_agent is not initial.
          if ms_alm_agent-guid is initial.
            call function 'GUID_CREATE'
              importing
                ev_guid_22 = ms_alm_agent-guid.
          endif.
          move-corresponding ms_alm_agent to ls_alm_onboard.
          modify zhw_db_agtonbord from ls_alm_onboard.
          if sy-subrc = 0.
            append initial line to et_messages assigning field-symbol(<fs_msg>).
            <fs_msg>-msgid = 'ZHW_MC'.
            <fs_msg>-msgno = '001'.
            <fs_msg>-severity = 'S'.
          endif.
        endif.
      when 'FPM_FINISH'.

        if ms_alm_agent-partner is initial.
          move-corresponding ms_alm_agent to ls_data_person.
          ls_data_person-lastname = ms_alm_agent-name_last.
          ls_data_person-firstname = ms_alm_agent-name_first.
          ls_data_person-sex = ms_alm_agent-sex.

          ls_data-partnertype = ms_alm_agent-bpkind.

          move-corresponding ms_alm_agent to ls_address.
          ls_address-countryiso = ms_alm_agent-conutry.
          ls_address-city = ms_alm_agent-city.
          ls_address-district = ms_alm_agent-district.
          ls_address-street = ms_alm_agent-street.

          call function 'BUPA_CREATE_FROM_DATA'
            exporting
              iv_category    = ms_alm_agent-type
              is_data        = ls_data
              is_data_person = ls_data_person
              is_address     = ls_address
            importing
              ev_partner     = ms_alm_agent-partner
            tables
              et_return      = lt_return.

          call function 'BAPI_BUPA_ROLE_ADD_2'
            exporting
              businesspartner     = ms_alm_agent-partner
              businesspartnerrole = 'CACSA1'.

          call function 'BAPI_BUPA_ROLE_ADD_2'
            exporting
              businesspartner     = ms_alm_agent-partner
              businesspartnerrole = 'MKK'.

          COMMIT WORK.

        endif.

        ls_contract-bpnumber = ms_alm_agent-partner.
        ls_contract-to_partner-bpnumber = ms_alm_agent-partner.
        ls_contract-contractcurrency =  'VND'.
        convert date sy-datlo into time stamp ls_contract-validfrom time zone sy-zonlo.
        convert date '99991231' into time stamp ls_contract-validto time zone sy-zonlo.

        ls_contract-position = ms_alm_agent-sub_channel.
        ls_contract-standardcontractnumber = '21PRODUCER_01'.

        zcl_icm_api_helper=>icm_create_contract(
              exporting is_contractdata               = ls_contract
              importing et_return                     = lt_return
                        ev_contract_id                = lv_contractnumber ).

        if lv_contractnumber is not initial.
          delete zhw_db_agtonbord from ms_alm_agent.
          ev_result = 'OK'.

          append initial line to et_messages assigning <fs_msg>.
          <fs_msg>-msgid = 'ZHW_MC'.
          <fs_msg>-msgno = '000'.
          <fs_msg>-parameter_1 = ms_alm_agent-partner.
          <fs_msg>-parameter_2 = lv_contractnumber.
          <fs_msg>-severity = 'S'.
        endif.
      when  others.
    endcase.
  endmethod.


  method IF_FPM_GUIBB~GET_PARAMETER_LIST.
  endmethod.


  method if_fpm_guibb~initialize.
    data: lr_fpm_param type ref to cl_fpm_parameter,
          lv_guid      type guid_22.
    lr_fpm_param ?= io_app_parameter.
    try.
        lr_fpm_param->if_fpm_parameter~get_value(
          exporting
            iv_key   =  'GUID'
          importing
            ev_value = mv_guid ).
      catch cx_fpm_floorplan.
    endtry.

endmethod.


  method IF_FPM_MULTI_INSTANTIABLE~FPM_INITIALIZE.
    mo_fpm = io_fpm.
  endmethod.


  method IF_FPM_MULTI_INSTANTIABLE~FPM_IS_MULTI_INSTANTIABLE.
    rv_is_multi_instantiable = abap_true.
  endmethod.
ENDCLASS.

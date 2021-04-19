class zhw_cl_alm_powl_feeder definition
  public
  final
  create public .

public section.

  interfaces if_powl_feeder .
protected section.
private section.
ENDCLASS.



CLASS ZHW_CL_ALM_POWL_FEEDER IMPLEMENTATION.


  method if_powl_feeder~get_actions.
    data: ls_action_defs type powl_actdescr_sty,
          ls_act_choices type powl_act_choice_sty,
          lv_counter     type c.

    if c_action_defs is initial.
      ls_action_defs-actionid = 'DETAILS'.                  "#EC NOTEXT
      ls_action_defs-cardinality  = 'S'.
      ls_action_defs-placementindx = 1.
      ls_action_defs-placement = 'B'.
      ls_action_defs-enabled = 'X'.
      ls_action_defs-text = 'Agent Dashboard'.              "#EC NOTEXT
      ls_action_defs-tooltip = 'Existing Agent: Display and All Operations'.
      ls_action_defs-add_separator = 'X'.
      insert ls_action_defs into table c_action_defs.
      clear ls_action_defs.

      ls_action_defs-actionid = 'SING_ONBOARD'.             "#EC NOTEXT
      ls_action_defs-cardinality  = 'I'.
      ls_action_defs-placementindx = 2.
      ls_action_defs-placement = 'B'.
      ls_action_defs-enabled = 'X'.
      ls_action_defs-text = 'Agent On-Boarding'.            "#EC NOTEXT
      ls_action_defs-tooltip = 'New Hire: Fill Details and On-Board'.
      ls_action_defs-add_separator = 'X'.

      ls_act_choices-actionid = 'NEW_AGENT'.                "#EC NOTEXT
      ls_act_choices-placementindx = 1.
*      ls_action_defs-cardinality = 'I'.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'New Agent'.                    "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.
      clear ls_act_choices.

      ls_act_choices-actionid = 'RESUME_AGENT'.             "#EC NOTEXT
      ls_act_choices-placementindx = 2.
*      ls_action_defs-cardinality = ' '.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'Resume: On-Boarding'.          "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.
      clear ls_act_choices.

      ls_act_choices-actionid = 'DISCARD'.                  "#EC NOTEXT
      ls_act_choices-placementindx = 3.
*      ls_action_defs-cardinality = ' '.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'Discard Draft'.                "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.
      clear ls_act_choices.

      insert ls_action_defs into table c_action_defs.
      clear ls_action_defs.

      ls_action_defs-actionid = 'REORG'.                    "#EC NOTEXT
      ls_action_defs-cardinality  = 'S'.
      ls_action_defs-placementindx = 3.
      ls_action_defs-placement = 'B'.
      ls_action_defs-enabled = 'X'.
      ls_action_defs-text = 'Agent Re-Org'.                 "#EC NOTEXT
      ls_action_defs-tooltip = 'Existing Agent: Changes within Sales Hierarchy'.
      ls_action_defs-add_separator = 'X'.

      ls_act_choices-actionid = 'REPOSITION'.               "#EC NOTEXT
      ls_act_choices-placementindx = 1.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'Team Transfer'.                "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.
      clear ls_act_choices.

      ls_act_choices-actionid = 'PROM_DEMOT'.               "#EC NOTEXT
      ls_act_choices-placementindx = 2.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'Promotion / Demotion'.         "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.
      clear ls_act_choices.

      insert ls_action_defs into table c_action_defs.
      clear ls_action_defs.

      ls_action_defs-actionid = 'SING_TERM'.                "#EC NOTEXT
      ls_action_defs-cardinality  = 'S'.
      ls_action_defs-placementindx = 4.
      ls_action_defs-placement = 'B'.
      ls_action_defs-enabled = 'X'.
      ls_action_defs-text = 'Agent Termination'.            "#EC NOTEXT
      ls_action_defs-add_separator = 'X'.

      ls_act_choices-actionid = 'TERM_AGENT'.               "#EC NOTEXT
      ls_act_choices-placementindx = 1.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'Initiate: Termination'.        "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.
      clear ls_act_choices.

      ls_act_choices-actionid = 'RESUME_TERM'.              "#EC NOTEXT
      ls_act_choices-placementindx = 2.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'Resume: Termination'.          "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.
      clear ls_act_choices.

      insert ls_action_defs into table c_action_defs.
      clear ls_action_defs.

      ls_action_defs-actionid = 'OPERATION'.                "#EC NOTEXT
      ls_action_defs-cardinality  = 'I'.
      ls_action_defs-placementindx = 5.
      ls_action_defs-placement = 'B'.
      ls_action_defs-enabled = 'X'.
      ls_action_defs-text = 'Mass Operations'.              "#EC NOTEXT
      ls_action_defs-add_separator = 'X'.

      ls_act_choices-actionid = 'ONBOARD'.                  "#EC NOTEXT
      ls_act_choices-placementindx = 1.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'On-board Agents'.              "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.
      clear ls_act_choices.

      ls_act_choices-actionid = 'TRANS'.                    "#EC NOTEXT
      ls_act_choices-placementindx = 2.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'Transfer Agents'.              "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.

      ls_act_choices-actionid = 'PROM'.                     "#EC NOTEXT
      ls_act_choices-placementindx = 3.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'Promote Agents'.               "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.

      ls_act_choices-actionid = 'DEMOT'.                    "#EC NOTEXT
      ls_act_choices-placementindx = 4.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'Demote Agents'.                "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.

      ls_act_choices-actionid = 'TERM'.                     "#EC NOTEXT
      ls_act_choices-placementindx = 5.
      ls_act_choices-enabled = 'X'.
      ls_act_choices-text = 'Terminate Agents'.             "#EC NOTEXT
      insert ls_act_choices into table ls_action_defs-act_choices.
      clear ls_act_choices.

      insert ls_action_defs into table c_action_defs.
      clear ls_action_defs.



    endif.

  endmethod.


  method if_powl_feeder~get_action_conf.
  endmethod.


  method if_powl_feeder~get_detail_comp.

  endmethod.


  method if_powl_feeder~get_field_catalog.
    data: ls_fieldcat    type powl_fieldcat_sty,
          lo_structdescr type ref to cl_abap_structdescr,
          lt_component   type cl_abap_structdescr=>component_table,
          lv_col_pos     type int4.

    lo_structdescr ?= cl_abap_structdescr=>describe_by_name( 'ZHW_S_ALM_POWL' ).
    lt_component = lo_structdescr->get_components( ).

    loop at lt_component assigning field-symbol(<fs_component>).
      clear ls_fieldcat.
      ls_fieldcat-colpos         = sy-tabix.
      ls_fieldcat-colid          = <fs_component>-name.
      ls_fieldcat-allow_sort     = 'X'.
      ls_fieldcat-allow_filter   = ''.
      ls_fieldcat-col_visible    = 'X'.
      ls_fieldcat-enabled        = 'X'.
      ls_fieldcat-header_by_ddic = 'X'.
      case ls_fieldcat-colid .
        when 'PARENT_NAME'.
          ls_fieldcat-header = 'Sub-Channel Name'.
        when 'STEXT'.
          ls_fieldcat-header = 'Agent Name & Address'.
        when 'REALO'.
          ls_fieldcat-header = 'BP Number'.
        when 'BEGDA'.
          ls_fieldcat-header = 'Contract Start'.
        when 'ENDDA'.
          ls_fieldcat-header = 'Contract Number'.
        when 'PARENT_OBJID'.
          ls_fieldcat-header = 'Channel / Sub-Channel ID'.
        when 'DRAFT_ONBOARDING'.
          ls_fieldcat-header  = 'Onboarding: In Progress'.
          ls_fieldcat-width = '10'.
          ls_fieldcat-wrapping = abap_true.
        when 'DRAFT_TERMINATION'.
          ls_fieldcat-header  = 'Termination: In Progress'.
          ls_fieldcat-width = '10'.
          ls_fieldcat-wrapping = abap_true.
        when others.
      endcase.

      insert ls_fieldcat into table c_fieldcat.
    endloop.
  endmethod.


  method if_powl_feeder~get_objects.
    data: lt_objid_range   type range of objec-objid,
          lt_data          type standard table of objec,
          lt_struc         type standard table of struc,
          lt_hrvpadic      type standard table of hrvpadic,
          ls_alm_powl_data type zhw_s_alm_powl,
          lt_draft         type standard table of zhw_db_agtonbord,
          lt_alm_powl_data type standard table of zhw_s_alm_powl.

    loop at i_selcrit_values assigning field-symbol(<fs_selcrit>).
      case <fs_selcrit>-selname.
        when 'OBJID'.
          append initial line to lt_objiD_range assigning field-symbol(<fs_objid_range>).
          move-corresponding <fs_selcrit> to <fs_objid_range>.
        when  'DRAFTON'.
          data(lv_draft_onboarding) = <fs_selcrit>-low.
        when others.
      endcase.
    endloop.

    if i_selcrit_values is initial.
      return.
    endif.

    if <fs_objid_range> is assigned.
      data(lv_objid) = <fs_objid_range>-low.


      call function 'RH_PM_GET_STRUCTURE'
        exporting
          plvar           = '01'
          otype           = 'O'
          objid           = lv_objid
          begda           = sy-datlo
          endda           = '99991231'
          wegid           = 'CACS_GP'
        tables
          objec_tab       = lt_data
          struc_tab       = lt_struc
        exceptions
          not_found       = 1
          ppway_not_found = 2
          others          = 3.
      if sy-subrc <> 0.
* Implement suitable error handling here
      endif.

      select * from hrvpadic into corresponding fields of table lt_hrvpadic
                                    where contract_appl = 'ZINS01'
                                      and begda le sy-datlo
                                      and endda ge sy-datlo.

    endif.
    loop at lt_hrvpadic assigning field-symbol(<fs_hrvpadic>).
      ls_alm_powl_data-comm_contract = <fs_hrvpadic>-contract_id.
      ls_alm_powl_data-contract_start = <fs_hrvpadic>-begda.
      ls_alm_powl_data-contract_end = <fs_hrvpadic>-endda.

      read table lt_data into data(ls_data) with key otype = 'BP'
                                                     objid = <fs_hrvpadic>-sobid+2(8).
      if sy-subrc <> 0.
        continue.
      else.
        if sy-subrc = 0.
          ls_alm_powl_data-stext = ls_data-stext.
          ls_alm_powl_data-realo = <fs_hrvpadic>-sobid.
        endif.
        if <fs_hrvpadic>-otype = 'O'.
          read table lt_data into ls_data with key objid = <fs_hrvpadic>-objid.
          if sy-subrc = 0.
            ls_alm_powl_data-parent_type = 'O'.
            ls_alm_powl_data-parent_objid = <fs_hrvpadic>-objid.
            ls_alm_powl_data-parent_name = ls_data-stext.
          endif.

        else.
          select single * from hrp1001 into @data(ls_org) where sobid = @<fs_hrvpadic>-objid and subty = 'B003'.
          if sy-subrc = 0.
            read table lt_data into ls_data with key objid = ls_org-objid
                                                     otype = 'O'.
            if sy-subrc = 0.
              ls_alm_powl_data-parent_name = ls_data-stext.
              ls_alm_powl_data-parent_type = 'O'.
              ls_alm_powl_data-parent_objid = ls_data-objid.
            endif.
          endif.
        endif.
      endif.

      append ls_alm_powl_data to e_results.
    endloop.

    if lv_draft_onboarding = abap_true.
      select * from zhw_db_agtonbord into  corresponding fields of table lt_draft where partner = space.
      loop at lt_draft into data(ls_draft).
        clear ls_alm_powl_data.
        ls_alm_powl_data-parent_type = 'O'.
        ls_alm_powl_data-parent_objid = ls_draft-sub_channel.
        ls_alm_powl_data-parent_name = 'Draft: Onboarding'.
        concatenate ls_draft-name_first ls_draft-name_last into ls_alm_powl_data-stext separated by space.
        ls_alm_powl_data-contract_start = ls_draft-valid_from.
        ls_alm_powl_data-contract_end = ls_draft-valid_to.
        ls_alm_powl_data-guid = ls_draft-guid.
        ls_alm_powl_data-draft_onboarding = abap_true.
        insert ls_alm_powl_data into e_results index 1.
      endloop.
    endif.
  endmethod.


  method if_powl_feeder~get_object_definition.
    data: lt_data type standard table of zhw_s_alm_powl.
    e_object_def ?= cl_abap_tabledescr=>describe_by_data( lt_data ).
  endmethod.


  method if_powl_feeder~get_sel_criteria.
    data: lt_org type zhw_t_org_list.

    append initial line to c_selcrit_defs assigning field-symbol(<fs_selcrit>).
    <fs_selcrit>-selname = 'OBJID'.
    <fs_selcrit>-kind = 'P'.
    <fs_selcrit>-param_type = 'D'.
    <fs_selcrit>-allow_admin_change = abap_true.
    <fs_selcrit>-selopt_type = 'I'.
    <fs_selcrit>-datatype = 'PD_OBJID_R'.

    call function 'ZHW_FM_GET_ORGUNIT'
      exporting
        org_unit = '90000036'
        begda    = sy-datlo
        endda    = '99991231'
      tables
        org_list = lt_org.


    loop at lt_org assigning field-symbol(<fs_org>).
      append initial line to <fs_selcrit>-valid_values assigning field-symbol(<fs_value>).
      <fs_value>-key = <fs_org>-org_id.
      <fs_value>-value = <fs_org>-org_name.
    endloop.

    append initial line to <fs_selcrit>-valid_values assigning <fs_value>.
    <fs_value>-key = '90000036'.
    <fs_value>-value = 'Sales'.

    append initial line to c_default_values assigning field-symbol(<fs_default>).
    <fs_default>-selname = 'OBJID'.
    <fs_default>-option = 'EQ'.
    <fs_default>-low = '90000036'.
    <fs_default>-sign = 'I'.
    <fs_default>-high = ' '.

    append initial line to c_selcrit_defs assigning <fs_selcrit>.
    <fs_selcrit>-selname = 'DRAFTON'.
    <fs_selcrit>-crittext = 'On-Boarding Draft'.
    <fs_selcrit>-kind = 'P'.
    <fs_selcrit>-param_type = 'C'.
    <fs_selcrit>-allow_admin_change = abap_true.
    <fs_selcrit>-selopt_type = 'A'.
    <fs_selcrit>-datatype = 'BOOLE_D'.

  endmethod.


  method if_powl_feeder~handle_action.
    data: lr_lpd_handle  type ref to if_powl_launchpad,
          lt_lpd_content type apb_lpd_t_content,
          lo_ref         type ref to cl_abap_structdescr,
          ls_appl_param  type apb_lpd_s_params,
          lt_appl_param  type apb_lpd_t_params.


    call method cl_powl_runtime_services=>get_powl_launchpad_handle
      exporting
        iv_role                  = 'ZHW_POWL'
        iv_instance              = 'ZHW_INS_POWL'
      receiving
        rr_powl_launchpad_handle = lr_lpd_handle.

    lt_lpd_content = lr_lpd_handle->mt_content.

    read table c_selected index 1 into data(ls_sel_row).
    read table c_result_tab assigning field-symbol(<fs_sel_result>) index ls_sel_row-tabix.

    case i_actionid.
      when 'DETAILS'.
        lo_ref ?= cl_abap_structdescr=>describe_by_name( 'ZHW_S_ALM_POWL' ).

        loop at lo_ref->get_components( ) into data(ls_component).
          assign component ls_component-name of structure <fs_sel_result> to field-symbol(<fs_src_value>).

          ls_appl_param-key = ls_component-name.
          ls_appl_param-value = <fs_src_value>.
          append ls_appl_param to lt_appl_param.
          clear ls_appl_param.

        endloop.

        read table lt_lpd_content reference into data(lr_lpd_content)
          with key application_alias = 'ZHW_ALM_DET'.

        lr_lpd_handle->launch_application( iv_application_id = lr_lpd_content->application_id
                                           it_business_parameters = lt_appl_param ).
      when 'RESUME_AGENT'.
        assign component 'COMM_CONTRACT' of structure <fs_sel_result> to field-symbol(<fs_comctr>).
        if <fs_comctr> is not initial.
          append initial line to e_messages assigning field-symbol(<fs_powl_msg>).
          <fs_powl_msg>-msgid ='ZHW_MC'.
          <fs_powl_msg>-msgnumber = '002'.
          <fs_powl_msg>-msgtype = 'W'.
          return.
        endif.

        assign component 'GUID' of structure <fs_sel_result> to field-symbol(<fs_guid>).
        if <fs_guid> is not initial.
          ls_appl_param-key = 'GUID'.
          ls_appl_param-value = <fs_guid>.
          append ls_appl_param to lt_appl_param.
          clear ls_appl_param.
        endif.

        read table lt_lpd_content reference into lr_lpd_content
          with key application_alias = 'ZALM_AGT_ONBOARD'.

        lr_lpd_handle->launch_application( iv_application_id = lr_lpd_content->application_id
                                            it_business_parameters = lt_appl_param ).

      when 'DISCARD'.
        assign component 'COMM_CONTRACT' of structure <fs_sel_result> to <fs_comctr>.
        if <fs_comctr> is not initial.
          append initial line to e_messages assigning <fs_powl_msg>.
          <fs_powl_msg>-msgid ='ZHW_MC'.
          <fs_powl_msg>-msgnumber = '002'.
          <fs_powl_msg>-msgtype = 'W'.
          return.
        endif.

        assign component 'GUID' of structure <fs_sel_result> to <fs_guid>.
        delete from zhw_db_agtonbord where guid = <fs_guid>.

        append initial line to e_messages assigning <fs_powl_msg>.
        <fs_powl_msg>-msgid ='ZHW_MC'.
        <fs_powl_msg>-msgnumber = '003'.
        <fs_powl_msg>-msgtype = 'S'.

        e_do_refresh = abap_true.

      when 'NEW_AGENT'.
        read table lt_lpd_content reference into lr_lpd_content
         with key application_alias = 'ZALM_AGT_ONBOARD'.
        lr_lpd_handle->launch_application( iv_application_id = lr_lpd_content->application_id ).
      when others.
    endcase.

  endmethod.
ENDCLASS.

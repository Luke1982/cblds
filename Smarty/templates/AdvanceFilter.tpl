<!--*+********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *********************************************************************************/
-->
<style>
	.wizard .layerPopup {
		border: 0;
		position: absolute;
		z-index: 50;
		display: none;
		width: 100%;
		height:100%;
		background:transparent;
		top: 0 !important;
		left:0 !important;
	}

	.wizard .layerPopupBlock {
		width: 300px;
		position: absolute;
		top: 50%;
		left: 0;
		right: 0;
	}
</style>
<script type="text/javascript" src="include/js/advancefilter.js"></script>
{if empty($JS_DATEFORMAT)}
	{assign var="JS_DATEFORMAT" value=$APP.NTC_DATE_FORMAT|@parse_calendardate}
{/if}
<input type="hidden" id="jscal_dateformat" name="jscal_dateformat" value="{$JS_DATEFORMAT}" />
<input type="hidden" id="image_path" name="image_path" value="{$IMAGE_PATH}" />
<input type="hidden" name="advft_criteria" id="advft_criteria" value="" />
<input type="hidden" name="advft_criteria_groups" id="advft_criteria_groups" value="" />
<script>
	{if $SOURCE neq 'reports'}
		var BLOCKJS = "";
		var BLOCKCRITERIA = "";
		{if $SOURCE neq 'customview'}
			var COL_BLOCK = '{$COLUMNS_BLOCK}';
		{else}
			var COL_BLOCK = "{$COLUMNS_BLOCK}";
		{/if};
		var FOPTION_ADV = "";
		var MOMENT = "";
	{/if}
</script>
<script type="text/JavaScript">
function addColumnConditionGlue(columnIndex) {ldelim}

	var columnConditionGlueElement = document.getElementById('columnconditionglue_'+columnIndex);

	if(columnConditionGlueElement) {ldelim}
		columnConditionGlueElement.innerHTML = "<select name='fcon"+columnIndex+"' id='fcon"+columnIndex+"' class='detailedViewTextBox'>"+
			"<option value='and'>{'LBL_CRITERIA_AND'|@getTranslatedString:$MODULE}</option>"+
			"<option value='or'>{'LBL_CRITERIA_OR'|@getTranslatedString:$MODULE}</option>"+
			"</select>";
	{rdelim}
{rdelim}

function addConditionRow(groupIndex) {ldelim}
	var groupColumns = column_index_array[groupIndex];
	if(typeof(groupColumns) != 'undefined') {ldelim}
		for(var i=groupColumns.length - 1; i>=0; --i) {ldelim}
			var prevColumnIndex = groupColumns[i];
			if(document.getElementById('conditioncolumn_'+groupIndex+'_'+prevColumnIndex)) {ldelim}
				addColumnConditionGlue(prevColumnIndex);
				break;
			{rdelim}
		{rdelim}
	{rdelim}

	var columnIndex = advft_column_index_count+1;
	var nextNode = document.getElementById('conditiongroup_'+groupIndex);

	var newNode = document.createElement('tr');
	newNodeId = 'conditioncolumn_'+groupIndex+'_'+columnIndex;
  	newNode.setAttribute('id',newNodeId);
  	newNode.setAttribute('name','conditionColumn');
	nextNode.parentNode.insertBefore(newNode, nextNode);

	node1 = document.createElement('td');
	node1.setAttribute('class', 'dvtCellLabel');
	node1.setAttribute('width', '25%');
	newNode.appendChild(node1);
	{if $SOURCE eq 'reports'}
		node1.innerHTML = '<select name="fcol'+columnIndex+'" id="fcol'+columnIndex+'" onchange="updatefOptions(this, \'fop'+columnIndex+'\');addRequiredElements('+columnIndex+');updateRelFieldOptions(this, \'fval_'+columnIndex+'\');" class="detailedViewTextBox">'+
							'<option value="">{'LBL_NONE'|@getTranslatedString:$MODULE}</option>'+COL_BLOCK+
						'</select>';
	{else}
		node1.innerHTML = "<select name='fcol"+columnIndex+"' id='fcol"+columnIndex+"' onchange='updatefOptions(this, \"fop"+columnIndex+"\");addRequiredElements("+columnIndex+");' class='detailedViewTextBox'>"+
							"<option value=''>{'LBL_NONE'|@getTranslatedString:$MODULE}</option>"+COL_BLOCK+
						"</select>";
	{/if}
	node2 = document.createElement('td');
	node2.setAttribute('class', 'dvtCellLabel');
	node2.setAttribute('width', '25%');

	node2.innerHTML = '<select name="fop'+columnIndex+'" id="fop'+columnIndex+'" class="repBox" style="width:100px;" onchange="addRequiredElements('+columnIndex+');">'+FOPTION_ADV+
							'<option value="">{'LBL_NONE'|@getTranslatedString:$MODULE}</option>'+
						'</select>';
	newNode.appendChild(node2);
	node3 = document.createElement('td');
	node3.setAttribute('class', 'dvtCellLabel');
	newNode.appendChild(node3);
	{if $SOURCE eq 'reports'}
		node3.innerHTML = '<input name="fval'+columnIndex+'" id="fval'+columnIndex+'" class="repBox" type="text" value="">'+
						'<img height=20 width=20 align="absmiddle" style="cursor: pointer;" title="{$APP.LBL_FIELD_FOR_COMPARISION}" alt="{$APP.LBL_FIELD_FOR_COMPARISION}" src="themes/images/terms.gif" onClick="hideAllElementsByName(\'relFieldsPopupDiv\'); fnShowDrop(\'show_val'+columnIndex+'\');"/>'+
						'<img align="absmiddle" style="cursor: pointer;" onclick="document.getElementById(\'fval'+columnIndex+'\').value=\'\';return false;" title="{$APP.LBL_CLEAR}" alt="{$APP.LBL_CLEAR}" src="themes/images/clear_field.gif"/>'+
						'<div class="layerPopup" id="show_val'+columnIndex+'" name="relFieldsPopupDiv" >'+
							'<table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="mailClient mailClientBg layerPopupBlock">'+
								'<tr>'+
									'<td>'+
										'<table width="100%" cellspacing="0" cellpadding="0" border="0" class="layerHeadingULine">'+
											'<tr background="themes/images/qcBg.gif" class="mailSubHeader">'+
												'<td width=90% class="genHeaderSmall"><b>{$MOD.LBL_SELECT_FIELDS}</b></td>'+
												'<td align=right>'+
													'<img border="0" align="absmiddle" src="themes/images/close.gif" style="cursor: pointer;" alt="{$APP.LBL_CLOSE}" title="{$APP.LBL_CLOSE}" onclick="hideAllElementsByName(\'relFieldsPopupDiv\');"/>'+
												'</td>'+
											'</tr>'+
										'</table>'+

										'<table width="100%" cellspacing="0" cellpadding="0" border="0" class="small">'+
											'<tr>'+
												'<td>'+
													'<table width="100%" cellspacing="0" cellpadding="5" border="0" bgcolor="white" class="small">'+
														'<tr>'+
															'<td width="30%" align="left" class="cellLabel small">{$MOD.LBL_RELATED_FIELDS}</td>'+
															'<td width="30%" align="left" class="cellText">'+
																'<select name="fval_'+columnIndex+'" id="fval_'+columnIndex+'" onChange="AddFieldToFilter('+columnIndex+',this);" class="detailedViewTextBox">'+
																	'<option value="">{$MOD.LBL_NONE}</option>'+
																	REL_FIELDS+
																'</select>'+
															'</td>'+
														'</tr>'+
													'</table>'+
													'<!-- save cancel buttons -->'+
													'<table width="100%" cellspacing="0" cellpadding="5" border="0" class="layerPopupTransport">'+
														'<tr>'+
															'<td width="50%" align="center">'+
																'<input type="button" style="width: 70px;" value="{$APP.LBL_DONE}" name="button" onclick="hideAllElementsByName(\'relFieldsPopupDiv\');" class="crmbutton small create" accesskey="X" title="{$APP.LBL_DONE}"/>'+
															'</td>'+
														'</tr>'+
													'</table>'+
												'</td>'+
											'</tr>'+
										'</table>'+
									'</td>'+
								'</tr>'+
							'</table>'+
						'</div>';
	{else}
		node3.innerHTML = '<input name="fval'+columnIndex+'" id="fval'+columnIndex+'" class="repBox" type="text" value="">'+ '<img align="absmiddle" style="cursor: pointer;" onclick="document.getElementById(\'fval'+columnIndex+'\').value=\'\';return false;" title="{$APP.LBL_CLEAR}" alt="{$APP.LBL_CLEAR}" src="themes/images/clear_field.gif"/>';
	{/if}

	node4 = document.createElement('td');
	node4.setAttribute('class', 'dvtCellLabel');
	node4.setAttribute('id', 'columnconditionglue_'+columnIndex);
	node4.setAttribute('width', '60px');
	newNode.appendChild(node4);

	node5 = document.createElement('td');
	node5.setAttribute('class', 'dvtCellLabel');
	node5.setAttribute('width', '30px');
	newNode.appendChild(node5);
	node5.innerHTML = '<a onclick="deleteColumnRow('+groupIndex+','+columnIndex+');" href="javascript:;">'+
					'<img src="themes/images/delete.gif" align="absmiddle" border="0"></a>';

	if(document.getElementById('fcol'+columnIndex)) updatefOptions(document.getElementById('fcol'+columnIndex), 'fop'+columnIndex);
	if(typeof(column_index_array[groupIndex]) == 'undefined') column_index_array[groupIndex] = [];
	column_index_array[groupIndex].push(columnIndex);
	advft_column_index_count++;

{rdelim}

function addGroupConditionGlue(groupIndex) {ldelim}

	var groupConditionGlueElement = document.getElementById('groupconditionglue_'+groupIndex);
	if(groupConditionGlueElement) {ldelim}
		groupConditionGlueElement.innerHTML = "<select name='gpcon"+groupIndex+"' id='gpcon"+groupIndex+"' class='small'>"+
			"<option value='and'>{'LBL_CRITERIA_AND'|@getTranslatedString:$MODULE}</option>"+
			"<option value='or'>{'LBL_CRITERIA_OR'|@getTranslatedString:$MODULE}</option>"+
		"</select>";
	{rdelim}
{rdelim}

function addConditionGroup(parentNodeId) {ldelim}

	for(var i=group_index_array.length - 1; i>=0; --i) {ldelim}
		var prevGroupIndex = group_index_array[i];
		if(document.getElementById('conditiongroup_'+prevGroupIndex)) {ldelim}
			addGroupConditionGlue(prevGroupIndex);
			break;
		{rdelim}
	{rdelim}

	var groupIndex = advft_group_index_count+1;
	var parentNode = document.getElementById(parentNodeId);

	var newNode = document.createElement('li');
	newNodeId = 'conditiongroup_'+groupIndex;
  	newNode.setAttribute('id',newNodeId);
  	newNode.setAttribute('name','conditionGroup');
  	newNode.className = "slds-expression__group";

  	var condGroupFieldSet = document.createElement("fieldset");
  	condGroupFieldSet.id = "conditiongroup_" + groupIndex;

  	var condGroupList = document.createElement("ul");
  	condGroupList.id = "conditiongrouplist_" + groupIndex;

  	condGroupFieldSet.appendChild(condGroupList);
  	newNode.appendChild(condGroupFieldSet);

  	newNode.innerHTML = "<table class='small crmTable' border='0' cellpadding='5' cellspacing='1' width='100%' valign='top' id='conditiongrouptable_"+groupIndex+"'>"+
			"<tr id='groupheader_"+groupIndex+"'>"+
				"<td colspan='5' align='right'>"+
					"<a href='javascript:void(0);' onclick='deleteGroup(\""+groupIndex+"\");'><img border=0 src={'close.gif'|@vtiger_imageurl:$THEME} alt='{$APP.LBL_DELETE_GROUP}' title='{$APP.LBL_DELETE_GROUP}'/></a>"+
				"</td>"+
			"</tr>"+
			"<tr id='groupfooter_"+groupIndex+"'>"+
				"<td colspan='5' align='left'>"+
					"<input type='button' class='crmbutton edit small' value='{$APP.LBL_NEW_CONDITION}' onclick='addConditionRow(\""+groupIndex+"\")' />"+
				"</td>"+
			"</tr>"+
		"</table>"+
		"<table class='small' border='0' cellpadding='5' cellspacing='1' width='100%' valign='top'>"+
			"<tr><td align='center' id='groupconditionglue_"+groupIndex+"'>"+
			"</td></tr>"+
		"</table>";


	parentNode.appendChild(newNode);

	group_index_array.push(groupIndex);
	advft_group_index_count++;
{rdelim}

function add_grouping_criteria(grouping_criteria) {ldelim}
	if(grouping_criteria == null)
		return false;
	var grouping_criteria_length = Object.keys(grouping_criteria).length;

	if(grouping_criteria_length > 0) {
		for(var i = 1;i <= grouping_criteria_length; i++) {
			var group_columns = grouping_criteria[i].columns;
			addConditionGroup('adv_filter_div');
			for (var key in group_columns) {
				if (group_columns.hasOwnProperty(key)) {

					addConditionRow(i);
					var conditionColumnRowElement = document.getElementById('fcol'+advft_column_index_count);

					conditionColumnRowElement.value = group_columns[key].columnname;
					updatefOptions(conditionColumnRowElement, 'fop'+advft_column_index_count);
					document.getElementById('fop'+advft_column_index_count).value = group_columns[key].comparator;
					addRequiredElements(advft_column_index_count);
					{if $SOURCE eq 'reports'}
						updateRelFieldOptions(conditionColumnRowElement, 'fval_'+advft_column_index_count);
					{/if}
					var columnvalue = group_columns[key].value;
					if(group_columns[key].comparator == 'bw' && columnvalue != '') {
						var values = columnvalue.split(",");
						document.getElementById('fval'+advft_column_index_count).value = values[0];
						if(values.length == 2 && document.getElementById('fval_ext'+advft_column_index_count))
							document.getElementById('fval_ext'+advft_column_index_count).value = values[1];
					} else {
						document.getElementById('fval'+advft_column_index_count).value = columnvalue;
					}
                                        var keyprev=key-1;
					if(document.getElementById('fcon'+keyprev))
						document.getElementById('fcon'+keyprev).value = group_columns[keyprev].column_condition;
				}
			}
                        var iprev=i-1;
			if(document.getElementById('gpcon'+iprev))
				document.getElementById('gpcon'+iprev).value = grouping_criteria[iprev].condition;
		}
	} else {
		addNewConditionGroup('adv_filter_div');
	}
{rdelim}
</script>
{* <pre>{$COLUMNS_BLOCK|print_r}</pre> *}
{* Get selected value to start out the dropdown with *}
{foreach from=$COLUMNS_BLOCK item=BLOCK}
	{foreach from=$BLOCK item=FIELD}
		{if $FIELD.selected}
			{$SELECTEDFIELD = $FIELD}
		{/if}
	{/foreach}
{/foreach}
<ul id="cbds-adv-cond__groups">
    <li class="slds-expression__group" data-group-no="1" data-rowcount="1">
    	<div class="slds-grid slds-gutters_xx-small adv-filt-group-controls slds-hide">
    		<div class="slds-col slds-grid slds-grid_align-end">
    			<div class="col">
                    <div class="slds-combobox_container">
                        <div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click adv-filt-glue-combo" aria-expanded="false" aria-haspopup="listbox" role="combobox">
                            <div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
                                <input class="slds-input slds-combobox__input slds-combobox__input-value adv-filt-group__glue" autocomplete="off" role="textbox" type="text" readonly="" value="{$APP.LBL_CRITERIA_AND}" data-valueholder="nextsibling" />
                                <input type="hidden" value="{$APP.LBL_CRITERIA_AND}" />
                                <span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
                                    <svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
                                        <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#down"></use>
                                    </svg>
                                </span>
                            </div>
                            <div class="slds-dropdown slds-dropdown_length-2 slds-dropdown_fluid" role="listbox">
                            	<ul class="slds-listbox slds-listbox_vertical" role="group">
                            		<li role="presentation" class="slds-listbox__item" data-value="{$APP.LBL_CRITERIA_AND}">
                            			<div class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                            				<span class="slds-media__figure slds-listbox__option-icon"></span>
                            				<span class="slds-media__body">
                            					<span class="slds-truncate" title="{$APP.LBL_CRITERIA_AND}">{$APP.LBL_CRITERIA_AND}</span>
                            				</span>
                            			</div>
                            		</li>
                            		<li role="presentation" class="slds-listbox__item" data-value="{$APP.LBL_CRITERIA_OR}">
                            			<div class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                            				<span class="slds-media__figure slds-listbox__option-icon"></span>
                            				<span class="slds-media__body">
                            					<span class="slds-truncate" title="{$APP.LBL_CRITERIA_OR}">{$APP.LBL_CRITERIA_OR}</span>
                            				</span>
                            			</div>
                            		</li>
                            	</ul> 
                            </div>
                        </div>
                    </div>    				
    			</div>
    			<div class="slds-col">
	    			<button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_DELETE_GROUP}">
	    				<svg class="slds-button__icon" aria-hidden="true">
	    					<use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#close"></use>
	    				</svg>
	    				<span class="slds-assistive-text">{$APP.LBL_DELETE_GROUP}</span>
	    			</button>
    			</div>    			
    		</div>
    	</div>
        <fieldset>
            <ul class="adv-filt-row-holder">
                <li class="slds-expression__row slds-expression__row_group slds-p-horizontal_none" data-row-no="1">
                    <fieldset>
                        <div class="slds-grid slds-gutters_xx-small">
                            <div class="slds-col slds-size_1-of-12">
                                <div class="slds-form-element">
                                    <label class="slds-form-element__label">Glue</label>
                                    <div class="slds-form-element__control">
                                        <div class="slds-combobox_container">
                                            <div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click" aria-expanded="false" aria-haspopup="listbox" role="combobox">
                                                <div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
                                                    <input class="slds-input slds-combobox__input slds-combobox__input-value adv-filt-row__glue" autocomplete="off" role="textbox" type="text" readonly="" disabled="" value="{$APP.LBL_CRITERIA_AND}" data-valueholder="nextsibling" />
                                                    <input type="hidden" value="{$APP.LBL_CRITERIA_AND}" />
                                                    <span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
                                                        <svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
                                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#down"></use>
                                                        </svg>
                                                    </span>
                                                </div>
                                                <div class="slds-dropdown slds-dropdown_length-2 slds-dropdown_fluid" role="listbox">
                                                	<ul class="slds-listbox slds-listbox_vertical" role="group">
                                                		<li role="presentation" class="slds-listbox__item" data-value="{$APP.LBL_CRITERIA_AND}">
                                                			<div id="option1" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                				<span class="slds-media__figure slds-listbox__option-icon"></span>
                                                				<span class="slds-media__body">
                                                					<span class="slds-truncate" title="{$APP.LBL_CRITERIA_AND}">{$APP.LBL_CRITERIA_AND}</span>
                                                				</span>
                                                			</div>
                                                		</li>
                                                		<li role="presentation" class="slds-listbox__item" data-value="{$APP.LBL_CRITERIA_OR}">
                                                			<div id="option1" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                				<span class="slds-media__figure slds-listbox__option-icon"></span>
                                                				<span class="slds-media__body">
                                                					<span class="slds-truncate" title="{$APP.LBL_CRITERIA_OR}">{$APP.LBL_CRITERIA_OR}</span>
                                                				</span>
                                                			</div>
                                                		</li>
                                                	</ul> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="slds-col">
                                <div class="slds-form-element">
                                    <label class="slds-form-element__label">{$APP.LBL_GENERAL_FIELDS}</label>
                                    <div class="slds-form-element__control">
                                        <div class="slds-combobox_container">
                                            <div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click adv-filt-field-sel" aria-expanded="false" aria-haspopup="listbox" role="combobox">
                                                <div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
                                                    <input class="slds-input slds-combobox__input slds-combobox__input-value" autocomplete="off" role="textbox" type="text" placeholder="{$SELECTEDFIELD.label}" readonly="" value="{$SELECTEDFIELD.label}" data-valueholder="nextsibling" />
                                                    <input type="hidden" value="{$SELECTEDFIELD.value}" />
                                                    <span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
                                                        <svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
                                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#down"></use>
                                                        </svg>
                                                    </span>
                                                </div>
                                                <div class="slds-dropdown slds-dropdown_length-4 slds-dropdown_fluid" role="listbox">
                                                	{foreach from=$COLUMNS_BLOCK item='BLOCK' key='BLOCKLABEL'}
                                                	<ul class="slds-listbox slds-listbox_vertical" role="group">
                                                		<li role="presentation" class="slds-listbox__item">
                                                			<div class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="presentation">
                                                				<h3 class="slds-text-title_caps" role="presentation">{$BLOCKLABEL}</h3>
                                                			</div>
                                                		</li>
                                                		{foreach from=$BLOCK item='FIELD' key='FIELDLABEL'}
                                                		<li role="presentation" class="slds-listbox__item" data-value="{$FIELD.value}">
                                                			<div class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                				<span class="slds-media__figure slds-listbox__option-icon"></span>
                                                				<span class="slds-media__body">
                                                					<span class="slds-truncate" title="{$FIELD.label}">{$FIELD.label}</span>
                                                				</span>
                                                			</div>
                                                		</li>
                                                		{/foreach}
                                                	</ul> 
                                                	{/foreach}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="slds-col slds-grow-none">
                                <div class="slds-form-element">
                                    <label class="slds-form-element__label">Operator</label>
                                    <div class="slds-form-element__control adv-filt-operator-wrapper">
                                        <div class="slds-combobox_container">
                                        	{* Filled by JS *}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="slds-col">
                                <div class="slds-form-element">
                                    <label class="slds-form-element__label">Value</label>
                                    <div class="slds-form-element__control">
                                        <input class="slds-input adv-filt-row__main-input" type="text" value="">
                                    </div>
                                </div>
                            </div>
                            <div class="slds-col slds-grow-none slds-size_1-of-12">
                                <div class="slds-form-element">
                                	<span class="slds-form-element__label">&nbsp;</span>
                                    <div class="slds-form-element__control">
                                        <button type="button" disabled="disabled" class="adv-filt-row__date-but slds-button slds-button_icon slds-button_icon-border-filled" title="{$APP.LBL_ACTION_DATE}" data-onclick="pick-date">
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#event"></use>
                                            </svg>
                                            <span class="slds-assistive-text">
                                               {$APP.LBL_ACTION_DATE} 
                                            </span>
                                        </button>
                                        <button type="button" disabled="disabled" class="slds-button slds-button_icon slds-button_icon-border-filled adv-filt-row__delete" title="{$APP.LBL_DELETE_BUTTON}" data-onclick="delete-cond">
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
                                            </svg>
                                            <span class="slds-assistive-text">
                                                {$APP.LBL_DELETE_BUTTON}
                                            </span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </li>
            </ul>
            <div class="slds-expression__buttons">
                <button type="button" class="slds-button slds-button_neutral" data-onclick="add-condition">
                    <svg class="slds-button__icon slds-button__icon_left" aria-hidden="true">
                        <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
                    </svg>
                    {$APP.LBL_NEW_CONDITION}
                </button>
            </div>
        </fieldset>
    </li>
</ul>
<div class="slds-expression__buttons">
    <button type="button" class="slds-button slds-button_neutral" data-onclick="add-group">
        <svg class="slds-button__icon slds-button__icon_left" aria-hidden="true">
            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
        </svg>{'LBL_NEW_GROUP'|@getTranslatedString:$MODULE}
    </button>
</div>

<div id="cbds-combo-oper-templ__box" style="display: none;">
    <div class="slds-combobox_container">
        <div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click" aria-expanded="false" aria-haspopup="listbox" role="combobox">
            <div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
                <input class="slds-input slds-combobox__input" autocomplete="off" role="textbox" type="text" readonly="" value="" data-valueholder="nextsibling">
                <input type="hidden" value="" />
                <span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
                    <svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
                        <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#down"></use>
                    </svg>
                </span>
            </div>
            <div class="slds-dropdown slds-dropdown_length-4 slds-dropdown_fluid" role="listbox">
                <ul class="slds-listbox slds-listbox_vertical" role="presentation">
                </ul>
            </div>
        </div>
    </div>
</div>

<div id="cbds-combo-oper-templ__item" style="display: none;">
    <li role="presentation" class="slds-listbox__item">
        <div class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
            <span class="slds-media__figure slds-listbox__option-icon"></span>
            <span class="slds-media__body">
                <span class="slds-truncate" title="">
                    
                </span>
            </span>
        </div>
    </li>	
</div>

<script>
	window.addEventListener("load", function(){
		var advancedFilter = document.getElementById("cbds-advanced-search");
		window.AdvancedFilter = new cbAdvancedFilter(advancedFilter);
	});
</script>

{* <div style="overflow:auto;margin-top: 30px;" id='adv_filter_div' name='adv_filter_div'>
	<table class="small" border="0" cellpadding="5" cellspacing="0" width="100%">
		<tr>
			<td class="detailedViewHeader" align="left"><b>{'LBL_ADVANCED_FILTER'|@getTranslatedString:$MODULE}</b></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="button" class="crmbutton create small" value="{'LBL_NEW_GROUP'|@getTranslatedString:$MODULE}" onclick="addNewConditionGroup('adv_filter_div')" />
			</td>
		</tr>
	</table>
<script>
	{if $SOURCE neq 'reports'}
		{if isset($CRITERIA_GROUPS) && $CRITERIA_GROUPS|@count > 0}
			add_grouping_criteria({json_encode($CRITERIA_GROUPS)});
		{else}
			addNewConditionGroup('cbds-adv-cond__groups');
		{/if}
	{/if}
</script>
</div>*}

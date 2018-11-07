{*<!--
/*********************************************************************************
 ** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
********************************************************************************/
-->*}
{if !empty($smarty.request.ajax)}
&#&#&#{if isset($ERROR)}{$ERROR}{/if}&#&#&#
{else}
{include file='applicationmessage.tpl'}
{/if}
<script type="text/javascript" src="include/js/ListView.js"></script>
<form name="massdelete" method="POST" id="massdelete" onsubmit="VtigerJS_DialogBox.block();">
	<input name='search_url' id="search_url" type='hidden' value='{$SEARCH_URL}'>
	<input name="idlist" id="idlist" type="hidden">
	<input name="change_owner" type="hidden">
	<input name="change_status" type="hidden">
	<input name="action" type="hidden">
	<input name="where_export" type="hidden" value="{$export_where}">
	<input name="step" type="hidden">
	<input name="excludedRecords" type="hidden" id="excludedRecords" value="">
	<input name="numOfRows" id="numOfRows" type="hidden" value="">
	<input name="allids" type="hidden" id="allids" value="{if isset($ALLIDS)}{$ALLIDS}{/if}">
	<input name="selectedboxes" id="selectedboxes" type="hidden" value="{$SELECTEDIDS}">
	<input name="allselectedboxes" id="allselectedboxes" type="hidden" value="{$ALLSELECTEDIDS}">
	<input name="current_page_boxes" id="current_page_boxes" type="hidden" value="{$CURRENT_PAGE_BOXES}">
	<!-- LDS listview table -->
	<div class="cbds-shadow-c--small slds-box slds-m-around_medium slds-p-around_none" style="overflow: hidden;">
	    <div class="slds-theme_inverse slds-p-around_small">
	        <div class="slds-grid slds-gutters">
	            <div class="slds-col slds-size_8-of-12">
	            	<!-- Listview buttons -->
	                <div class="slds-button-group" role="group">
	                	{foreach key=button_check item=button_label from=$BUTTONS}
	                	{if $button_check == 'del'}
	                    <button class="slds-button slds-button_destructive" onclick="return massDelete('{$MODULE}')">
	                        <svg class="slds-button__icon slds-button__icon_left" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
	                        </svg>
	                        {$button_label}
	                    </button>
	                    {elseif $button_check eq 'mass_edit'}
	                    <button class="slds-button slds-button_inverse" onclick="document.getElementById('cbds-massedit').classList.add('cbds-massedit--active');return mass_edit(this, 'massedit', '{$MODULE}', '{$CATEGORY}');">
	                        <svg class="slds-button__icon slds-button__icon_left" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#mark_all_as_read"></use>
	                        </svg>
	                        {$button_label}
	                    </button>
	                    {elseif $button_check eq 's_mail'}
	                    <button class="slds-button slds-button_inverse" onclick="return eMail('{$MODULE}',this);">
	                        <svg class="slds-button__icon slds-button__icon_left" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#email"></use>
	                        </svg>
	                        {$button_label}
	                    </button>
	                    {elseif $button_check eq 'mailer_exp'}
	                    <button class="slds-button slds-button_inverse" onclick="return mailer_export()">
	                        <svg class="slds-button__icon slds-button__icon_left" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#email"></use>
	                        </svg>
	                        {$button_label}
	                    </button>
	                    {/if}
	                    {/foreach}
						{if $CUSTOM_LINKS && $CUSTOM_LINKS.LISTVIEWBASIC}
							{foreach item=CUSTOMLINK from=$CUSTOM_LINKS.LISTVIEWBASIC}
								{assign var="customlink_href" value=$CUSTOMLINK->linkurl}
								{assign var="customlink_label" value=$CUSTOMLINK->linklabel}
								{assign var="customlink_id" value=$CUSTOMLINK->linklabel|replace:' ':''}
								{if $customlink_label eq ''}
									{assign var="customlink_label" value=$customlink_href}
								{else}
									{* Pickup the translated label provided by the module *}
									{assign var="customlink_label" value=$customlink_label|@getTranslatedString:$CUSTOMLINK->module()}
								{/if}
			                    <button class="slds-button slds-button_inverse" onclick="{$customlink_href}" id="LISTVIEWBASIC_{$customlink_id}">
			                        {$customlink_label}
			                    </button>						
							{/foreach}
						{/if}
						{* TO-DO: $CUSTOM_LINKS.LISTVIEW in ListViewCustomButtons.tpl *}
	                </div>
	                <!-- // Listview buttons -->                   
	            </div>
	            <div class="slds-col  slds-size_3-of-12">
	                <div class="slds-form-element__control">
	                    <div class="slds-combobox-group">
	                        <div class="slds-combobox_object-switcher slds-combobox-addon_start">
	                            <div class="slds-form-element slds-text-color_default">
	                                <label class="slds-form-element__label slds-assistive-text" for="objectswitcher-combobox-id-1">Filter Search by:</label>
	                                <div class="slds-form-element__control">
	                                    <div class="slds-combobox_container">
	                                        <div id="test-2" class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click" aria-controls="primary-search-combobox-id-1" aria-expanded="false" aria-haspopup="listbox" role="combobox">
	                                            <div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
	                                                <input type="text" class="slds-input slds-combobox__input slds-combobox__input-value" id="objectswitcher-combobox-id-1" aria-controls="objectswitcher-listbox-id-1" autocomplete="off" role="textbox" placeholder=" " value="All columns" onfocus="document.getElementById('test-2').classList.add('slds-is-open');" onblur="document.getElementById('test-2').classList.remove('slds-is-open');">
	                                                <span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
	                                                    <svg class="slds-icon slds-icon slds-icon_xx-small slds-icon-text-default" aria-hidden="true">
	                                                        <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#down"></use>
	                                                    </svg>
	                                                </span>
	                                            </div>
	                                            <div id="objectswitcher-listbox-id-1" class="slds-dropdown slds-dropdown_length-5 slds-dropdown_x-small slds-dropdown_left" role="listbox">
	                                                <ul class="slds-listbox slds-listbox_vertical" role="group" aria-label="Suggested for you">
	                                                    <li role="presentation" class="slds-listbox__item">
	                                                        <div id="object0" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="presentation">
	                                                            <h3 class="slds-text-title_caps" role="presentation">Columns</h3>
	                                                        </div>
	                                                    </li>
	                                                    <li role="presentation" class="slds-listbox__item">
	                                                        <div id="object1" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small slds-is-selected" role="option">
	                                                            <span class="slds-media__figure slds-listbox__option-icon">
	                                                                <span class="slds-icon_container slds-icon-utility-check slds-current-color">
	                                                                    <svg class="slds-icon slds-icon_x-small" aria-hidden="true">
	                                                                        <use xlink:href="/assets/icons/utility-sprite/svg/symbols.svg#check"></use>
	                                                                    </svg>
	                                                                </span>
	                                                            </span>
	                                                            <span class="slds-media__body">
	                                                                <span class="slds-truncate" title="Organization no">
	                                                                    <span class="slds-assistive-text">Current Selection:</span> All columns</span>
	                                                            </span>
	                                                        </div>
	                                                    </li>
	                                                    <li role="presentation" class="slds-listbox__item">
	                                                        <div id="object2" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
	                                                            <span class="slds-media__figure slds-listbox__option-icon"></span>
	                                                            <span class="slds-media__body">
	                                                                    <span class="slds-truncate" title="Organization no"> Organization no</span>
	                                                            </span>
	                                                        </div>
	                                                    </li>
	                                                    <li role="presentation" class="slds-listbox__item">
	                                                        <div id="object2" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
	                                                            <span class="slds-media__figure slds-listbox__option-icon"></span>
	                                                            <span class="slds-media__body">
	                                                                    <span class="slds-truncate" title="Organization name"> Organization name</span>
	                                                            </span>
	                                                        </div>
	                                                    </li>
	                                                    <li role="presentation" class="slds-listbox__item">
	                                                        <div id="object3" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
	                                                            <span class="slds-media__figure slds-listbox__option-icon"></span>
	                                                            <span class="slds-media__body">
	                                                                    <span class="slds-truncate" title="Billing city"> Billing city</span>
	                                                            </span>
	                                                        </div>
	                                                    </li>
	                                                    <li role="presentation" class="slds-listbox__item">
	                                                        <div id="object4" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
	                                                            <span class="slds-media__figure slds-listbox__option-icon"></span>
	                                                            <span class="slds-media__body">
	                                                                    <span class="slds-truncate" title="Website"> Website</span>
	                                                            </span>
	                                                        </div>
	                                                    </li>
	                                                    <li role="presentation" class="slds-listbox__item">
	                                                        <div id="object5" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
	                                                            <span class="slds-media__figure slds-listbox__option-icon"></span>
	                                                            <span class="slds-media__body">
	                                                                    <span class="slds-truncate" title="Phone"> Phone</span>
	                                                            </span>
	                                                        </div>
	                                                    </li>
	                                                    <li role="presentation" class="slds-listbox__item">
	                                                        <div id="object6" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
	                                                            <span class="slds-media__figure slds-listbox__option-icon"></span>
	                                                            <span class="slds-media__body">
	                                                                    <span class="slds-truncate" title="Assigned to"> Assigned to</span>
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
	                        <div class="slds-combobox_container slds-combobox-addon_end">
	                            <div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click" aria-expanded="false" aria-haspopup="listbox" id="primary-search-combobox-id-1" role="combobox">
	                                <div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_left slds-global-search__form-element" role="none">
	                                    <span class="slds-icon_container slds-icon-utility-search slds-input__icon slds-input__icon_left">
	                                            <svg class="slds-icon slds-icon slds-icon_xx-small slds-icon-text-default" aria-hidden="true">
	                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#search"></use>
	                                            </svg>
	                                        </span>
	                                    <input type="text" class="slds-input slds-combobox__input slds-text-color_default" id="combobox-id-1" aria-autocomplete="list" aria-controls="search-listbox-id-1" autocomplete="off" role="textbox" placeholder="Search Accounts">
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>                   
	            </div>
	            <div class="slds-col  slds-size_1-of-12">
	                <div class="slds-button-group">
	                    <button type="button" class="slds-button slds-button_icon slds-button_icon-border cbds-bg-white" title="Previous" onclick="getListViewEntries_js('{$PAGING_ARRAY.module}','parenttab={$PAGING_ARRAY.ptab}&start={$PAGING_ARRAY.prev}');">
	                        <svg class="slds-button__icon" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#left" xmlns:xlink="http://www.w3.org/1999/xlink" />
	                        </svg>
	                    </button>
	                    <div class="slds-form-element slds-border_top slds-border_bottom cbds-bg-white" style="height: 32px;">
	                      <div class="slds-form-element__control">
	                        <input id="text-input-id-1" size="3" class="slds-input slds-input_bare" type="text" value="{$PAGING_ARRAY.current}" />
	                      </div>
	                    </div>
	                    <button type="button" class="slds-button slds-button_icon slds-button_icon-border cbds-bg-white" title="Next" onclick="getListViewEntries_js('{$PAGING_ARRAY.module}','parenttab={$PAGING_ARRAY.ptab}&start={$PAGING_ARRAY.next}');">
	                        <svg class="slds-button__icon" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#right" xmlns:xlink="http://www.w3.org/1999/xlink" />
	                        </svg>
	                    </button>
	                </div>
	            </div>
	        </div>
	    </div>
	    <!-- Main listview table -->
	    <table aria-multiselectable="true" class="slds-table slds-table_bordered slds-table_fixed-layout slds-table_resizable-cols" role="grid">
	        <thead>
	            <tr class="slds-line-height_reset">
	                <th class="slds-text-title_caps slds-text-align_right" scope="col" style="width: 3.25rem;">
	                    <span id="column-group-header" class="slds-assistive-text">Choose a row</span> {* TO-DO: Translate *}
	                    <div class="slds-th__action slds-th__action_form">
	                        <div class="slds-checkbox">
	                            <input type="checkbox" name="options" id="checkbox-1" tabindex="-1" aria-labelledby="check-select-all-label column-group-header" value="checkbox-1">
	                            <label class="slds-checkbox__label" for="checkbox-1" id="check-select-all-label">
	                                <span class="slds-checkbox_faux"></span>
	                                <span class="slds-form-element__label slds-assistive-text">Select All</span> {* TO-DO: Translate *}
	                            </label>
	                        </div>
	                    </div>
	                </th>
	                {foreach name="listviewforeach" item=header from=$LISTHEADER_ARRAY}
	                {* Set some header variables *}
	                {if $header.curr_sorted}{if $header.sorder == 'ASC'}{$arrow = 'up'}{else}{$arrow = 'down'}{/if}{else}{$arrow = false}{/if}
	                {if !$header@last}{$label = $header.label|cat:$header.label_add}{else}{$label = 'Actions'|@getTranslatedString}{$arrow = false}{/if}

	                <th aria-label="Name" aria-sort="none" class="slds-text-title_caps slds-is-sortable" scope="col">
	                    <a class="slds-th__action slds-text-link_reset" href="javascript:void(0);" {if !$header@last}onclick="getListViewEntries_js('{$header.module}','parenttab={$header.ptab}&foldername=Default&order_by={$header.fieldname}&start={$header.start}&sorder={$header.sorder}{$header.s_query}');"{/if} role="button" tabindex="-1">
	                        <span class="slds-assistive-text">Sort by: </span>
	                        <div class="slds-grid slds-grid_vertical-align-center slds-has-flexi-truncate">
	                            <span class="slds-truncate" title="{$label}">{$label}</span>
	                            {if $arrow}
	                            <span class="slds-icon_container slds-icon-utility-arrow{$arrow}">
	                                <svg class="slds-icon slds-icon-text-default slds-is-sortable__icon " aria-hidden="true">
	                                    <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#arrow{$arrow}"></use>
	                                </svg>
	                            </span>
	                            {/if}
	                        </div>
	                    </a>
	                </th>
	                {/foreach}
	            </tr>
	        </thead>
	        <tbody>
	        	{foreach item=entity key=entity_id from=$LISTENTITY_ARRAY}
		            <tr aria-selected="false" class="slds-hint-parent">
		                <td class="slds-text-align_right" role="gridcell">
		                    <div class="slds-checkbox">
		                        <input type="checkbox" name="options" id="listview-checkbox-{$entity_id}" tabindex="-1" aria-labelledby="listview-checkboxlabel-{$entity_id} column-group-header" value="{$entity_id}">
		                        <label class="slds-checkbox__label" for="listview-checkbox-{$entity_id}" id="listview-checkboxlabel-{$entity_id}">
		                            <span class="slds-checkbox_faux"></span>
		                            <span class="slds-form-element__label slds-assistive-text">{* TO-DO: Get correct text here *}</span>
		                        </label>
		                    </div>
		                </td>
					{foreach item=cell key=array_key from=$entity}
						{if !$cell@last}
		                <td role="gridcell">
		                    <div class="slds-truncate" title="">{$cell}</div>
		                </td>
		                {else}
			            <td role="gridcell">
			                <div class="slds-button-group" role="group">
			                	{if $cell.edit != false}
			                    <button class="slds-button slds-button_icon slds-button_icon-border-filled" title="Edit" aria-pressed="false" onclick="location.href='{$cell.edit}'">
			                        <svg class="slds-button__icon" aria-hidden="true">
			                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#edit"></use>
			                        </svg>
			                        <span class="slds-assistive-text">Edit</span>
			                    </button>
			                	{/if}
			                	{if $cell.delete != false}
			                    <button class="slds-button slds-button_icon slds-button_icon-border-filled" title="Delete" aria-pressed="false" onclick="javascript:confirmdelete('{$cell.delete}');">
			                        <svg class="slds-button__icon" aria-hidden="true">
			                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
			                        </svg>
			                        <span class="slds-assistive-text">Delete</span>
			                    </button>
				                {/if}
			                	{if $cell.changed != false}
			                    <button class="slds-button slds-button_icon slds-button_icon-border-filled" title="This record has been changed" aria-pressed="false">
			                        <svg class="slds-button__icon slds-icon-text-error" aria-hidden="true">
			                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#announcement"></use>
			                        </svg>
			                        <span class="slds-assistive-text">This record has been changed</span>
			                    </button>
				                {/if}
			                </div>
			            </td>
		                {/if}
	                {/foreach}
	            </tr>
	            {/foreach}
	        </tbody>
	    </table>
	    <!-- // Main listview table -->
	</div>	
	<!-- // LDS listview table -->
	<!-- List View Master Holder starts -->
	<table border=0 cellspacing=1 cellpadding=0 width=100% class="lvtBg">
		<tr>
			<td>
				<!-- List View's Buttons and Filters starts -->
				<table width="100%" class="layerPopupTransport">
					<tr>
						<td width="25%" class="small" nowrap align="left">{$recordListRange}</td>
						<td><table align="center">
								<tr>
									<td>
										<!-- Filters -->
										{if empty($HIDE_CUSTOM_LINKS) || $HIDE_CUSTOM_LINKS neq '1'}
										<table cellpadding="5" cellspacing="0" class="small">
											<tr>
												<td style="padding-left:5px;padding-right:5px" align="center">
													<b><font size=2>{$APP.LBL_VIEW}</font></b> <SELECT NAME="viewname" id="viewname" class="small" style="max-width:240px;" onchange="showDefaultCustomView(this,'{$MODULE}','{$CATEGORY}')">{$CUSTOMVIEW_OPTION}</SELECT>
												</td>
												{if isset($ALL) && $ALL eq 'All'}
												<td style="padding-left:5px;padding-right:5px" align="center"><a href="index.php?module={$MODULE}&action=CustomView&parenttab={$CATEGORY}">{$APP.LNK_CV_CREATEVIEW}</a>
													<span class="small">|</span>
													<span class="small" disabled>{$APP.LNK_CV_EDIT}</span>
													<span class="small">|</span>
													<span class="small" disabled>{$APP.LNK_CV_DELETE}</span>
												</td>
												{else}
												<td style="padding-left:5px;padding-right:5px" align="center">
													<a href="index.php?module={$MODULE}&action=CustomView&parenttab={$CATEGORY}">{$APP.LNK_CV_CREATEVIEW}</a>
													<span class="small">|</span>
													{if $CV_EDIT_PERMIT neq 'yes' || $SQLERROR}
														<span class="small" disabled>{$APP.LNK_CV_EDIT}</span>
													{else}
														<a href="index.php?module={$MODULE}&action=CustomView&record={$VIEWID}&parenttab={$CATEGORY}">{$APP.LNK_CV_EDIT}</a>
													{/if}
													<span class="small">|</span>
													{if $CV_DELETE_PERMIT neq 'yes'}
														<span class="small" disabled>{$APP.LNK_CV_DELETE}</span>
													{else}
														<a href="javascript:confirmdelete('index.php?module=CustomView&action=Delete&dmodule={$MODULE}&record={$VIEWID}&parenttab={$CATEGORY}')">{$APP.LNK_CV_DELETE}</a>
													{/if}
													{if $CUSTOMVIEW_PERMISSION.ChangedStatus neq '' && $CUSTOMVIEW_PERMISSION.Label neq ''}
														<span class="small">|</span>
														<a href="#" id="customstatus_id" onClick="ChangeCustomViewStatus({$VIEWID},{$CUSTOMVIEW_PERMISSION.Status},{$CUSTOMVIEW_PERMISSION.ChangedStatus},'{$MODULE}','{$CATEGORY}')">{$CUSTOMVIEW_PERMISSION.Label}</a>
													{/if}
												</td>
												{/if}
											</tr>
										</table>
										<!-- Filters END-->
										{/if}
									</td>
								</tr>
							</table>
						</td>
						<!-- Page Navigation -->
						<td nowrap align="right" width="25%">
							<table border=0 cellspacing=0 cellpadding=0 class="small">
								<tr>{$NAVIGATION}</tr>
							</table>
						</td>
					</tr>
				</table>
				<table border=0 cellspacing=0 cellpadding=2 width=100% class="small">
					<tr>
						<!-- Buttons -->
						<td style="padding-right:20px" nowrap>{include file='ListViewButtons.tpl'}</td>
					</tr>
				</table>
				<!-- List View's Buttons and Filters ends -->

			<div>
			<table border=0 cellspacing=1 cellpadding=3 width=100% class="lvt small">
			<!-- Table Headers -->
			<tr>
				<td class="lvtCol"><input type="checkbox" name="selectall" id="selectCurrentPageRec" onClick=toggleSelect_ListView(this.checked,"selected_id")></td>
				{foreach name="listviewforeach" item=header from=$LISTHEADER}
					<td class="lvtCol">{$header}</td>
				{/foreach}
			</tr>
			<tr>
				<td id="linkForSelectAll" class="linkForSelectAll" style="display:none;" colspan=15>
					<span id="selectAllRec" class="selectall" style="display:inline;" onClick="toggleSelectAll_Records('{$MODULE}',true,'selected_id')">{$APP.LBL_SELECT_ALL} <span id="count"> </span> {$APP.LBL_RECORDS_IN} {$MODULE|@getTranslatedString:$MODULE}</span>
					<span id="deSelectAllRec" class="selectall" style="display:none;" onClick="toggleSelectAll_Records('{$MODULE}',false,'selected_id')">{$APP.LBL_DESELECT_ALL} {$MODULE|@getTranslatedString:$MODULE}</span>
				</td>
			</tr>
			<!-- Table Contents -->
			{foreach item=entity key=entity_id from=$LISTENTITY}
				<tr bgcolor=white onMouseOver="this.className='lvtColDataHover'" onMouseOut="this.className='lvtColData'" id="row_{$entity_id}">
					<td width="2%">{if $entity_id>0}<input type="checkbox" NAME="selected_id" id="{$entity_id}" value= '{$entity_id}' onClick="check_object(this)">{else}<span class="listview_row_sigma">&Sigma;</span>{/if}</td>
					{foreach item=data from=$entity}
						{* vtlib customization: Trigger events on listview cell *}
						<td onmouseover="vtlib_listview.trigger('cell.onmouseover', this)" onmouseout="vtlib_listview.trigger('cell.onmouseout', this)">{$data}</td>
					{/foreach}
				</tr>
			{foreachelse}
			<tr>
			<td style="background-color:#efefef;height:340px" align="center" colspan="{$smarty.foreach.listviewforeach.iteration+1}">
			<div id="no_entries_found" style="border: 3px solid rgb(153, 153, 153); background-color: rgb(255, 255, 255); width: 45%; position: relative;">
				{assign var=vowel_conf value='LBL_A'}
				{if $MODULE eq 'Accounts' || $MODULE eq 'Invoice'}
					{assign var=vowel_conf value='LBL_AN'}
				{/if}
				{assign var=MODULE_CREATE value=$SINGLE_MOD}
				{if $MODULE eq 'HelpDesk'}
					{assign var=MODULE_CREATE value='Ticket'}
				{/if}

				{if $SQLERROR}
					<table border="0" cellpadding="5" cellspacing="0" width="98%">
					<tr>
						<td rowspan="2" width="25%"><img src="{'empty.png'|@vtiger_imageurl:$THEME}" height="60" width="61"></td>
						<td style="border-bottom: 1px solid rgb(204, 204, 204);" nowrap="nowrap" width="75%">
							<span class="genHeaderSmall">{$APP.LBL_NO_DATA}</span>
						</td>
					</tr>
					<tr>
						<td class="small" align="left" nowrap="nowrap">{'ERROR_GETTING_FILTER'|@getTranslatedString:$MODULE}</td>
					</tr>
					</table>
				{else}
					{if $CHECK.EditView eq 'yes' && $MODULE neq 'Emails'}
						<table border="0" cellpadding="5" cellspacing="0" width="98%">
						<tr>
							<td rowspan="2" width="25%"><img src="{'empty.png'|@vtiger_imageurl:$THEME}" height="60" width="61"></td>
							<td style="border-bottom: 1px solid rgb(204, 204, 204);" nowrap="nowrap" width="75%">
								<span class="genHeaderSmall">{$APP.LBL_NO_DATA}</span>
							</td>
						</tr>
						<tr>
							<td class="small" align="left" nowrap="nowrap">
								{if $MODULE neq 'Calendar'}
									<b><a class="nef_action" href="index.php?module={$MODULE}&action=EditView&return_action=DetailView&parenttab={$CATEGORY}">{$APP.LBL_CREATE} {$APP.$vowel_conf}
										{$MODULE_CREATE|@getTranslatedString:$MODULE}
										{if $CHECK.Import eq 'yes' && $MODULE neq 'Documents'}
										</a></b><br>
										<b><a class="nef_action" href="index.php?module={$MODULE}&action=Import&step=1&return_module={$MODULE}&return_action=ListView&parenttab={$CATEGORY}">{$APP.LBL_IMPORT} {$MODULE|@getTranslatedString:$MODULE}
										{/if}
									</a></b><br>
								{else}
									<b><a class="nef_action" href="index.php?module=Calendar4You&amp;action=EventEditView&amp;return_module=Calendar4You&amp;activity_mode=Events&amp;return_action=DetailView&amp;parenttab={$CATEGORY}">{$APP.LBL_CREATE} {$APP.LBL_AN} {$APP.Event}</a></b><br>
									<b><a class="nef_action" href="index.php?module=Calendar4You&amp;action=EventEditView&amp;return_module=Calendar4You&amp;activity_mode=Task&amp;return_action=DetailView&amp;parenttab={$CATEGORY}">{$APP.LBL_CREATE} {$APP.LBL_A} {$APP.Task}</a></b>
								{/if}
							</td>
						</tr>
						</table>
					{else}
						<table border="0" cellpadding="5" cellspacing="0" width="98%">
						<tr>
							<td rowspan="2" width="25%"><img src="{'denied.gif'|@vtiger_imageurl:$THEME}"></td>
							<td style="border-bottom: 1px solid rgb(204, 204, 204);" nowrap="nowrap" width="75%"><span class="genHeaderSmall">{$APP.LBL_NO_DATA}</span></td>
						</tr>
						<tr>
							<td class="small" align="left" nowrap="nowrap">{$APP.LBL_YOU_ARE_NOT_ALLOWED_TO_CREATE} {$APP.$vowel_conf}
							{$MODULE_CREATE|@getTranslatedString:$MODULE}
							<br>
							</td>
						</tr>
						</table>
					{/if}
				{/if} {* SQL ERROR ELSE END *}
			</div>
			</td>
			</tr>
			{/foreach}
			</table>
			</div>

			<table border=0 cellspacing=0 cellpadding=2 width=100%>
			<tr>
				<td style="padding-right:20px" nowrap>{include file='ListViewButtons.tpl'}</td>
				<td align="right" width=40%>
					<table border=0 cellspacing=0 cellpadding=0 class="small">
					<tr>
						{if !empty($WORDTEMPLATES)}
							{if $WORDTEMPLATES|@count gt 0}
								<td>{'LBL_SELECT_TEMPLATE_TO_MAIL_MERGE'|@getTranslatedString:$MODULE}</td>
								<td style="padding-left:5px;padding-right:5px">
									<select class="small" name="mergefile">
									{foreach key=_TEMPLATE_ID item=_TEMPLATE_NAME from=$WORDTEMPLATES}
										<option value="{$_TEMPLATE_ID}">{$_TEMPLATE_NAME}</option>
									{/foreach}
									</select>
								</td>
								<td>
									<input title="{'LBL_MERGE_BUTTON_TITLE'|@getTranslatedString:$MODULE}" accessKey="{'LBL_MERGE_BUTTON_KEY'|@getTranslatedString:$MODULE}"
										class="crmbutton small create" onclick="return massMerge('{$MODULE}')" type="submit" name="Merge" value="{'LBL_MERGE_BUTTON_LABEL'|@getTranslatedString:$MODULE}">
								</td>
							{elseif $IS_ADMIN eq 'true'}
								<td>
									<a href='index.php?module=Settings&action=upload&tempModule={$MODULE}&parenttab=Settings'>{'LBL_CREATE_MERGE_TEMPLATE'|@getTranslatedString:$MODULE}</a>
								</td>
							{/if}
						{/if}
					</tr>
					</table>
				</td>
			</tr>
			</table>
		</td>
		</tr>
		<tr>
			<td>
				<table width="100%">
					<tr>
						<td class="small" nowrap align="left">{$recordListRange}</td>
						<td nowrap width="50%" align="right">
							<table border=0 cellspacing=0 cellpadding=0 class="small">
							<tr>{$NAVIGATION}</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
<div id="basicsearchcolumns" style="display:none;"><select name="search_field" id="bas_searchfield" class="txtBox" style="width:150px">{html_options options=$SEARCHLISTHEADER}</select></div>
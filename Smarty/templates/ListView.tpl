{*<!--
/*+********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ********************************************************************************/
-->*}
<script type="text/javascript" src="include/js/ListView.js"></script>
<script type="text/javascript" src="include/js/search.js"></script>
<script type="text/javascript" src="include/js/Merge.js"></script>
<script type="text/javascript" src="include/js/dtlviewajax.js"></script>
<script type="text/javascript" src="include/js/FieldDependencies.js"></script>
{if !isset($Document_Folder_View)}
	{assign var=Document_Folder_View value=0}
{/if}
<script>var Document_Folder_View={$Document_Folder_View};</script>

		{include file='Buttons_List.tpl'}
								<div id="searchingUI" style="display:none;">
										<table border=0 cellspacing=0 cellpadding=0 width=100%>
										<tr>
												<td align=center>
												<img src="{'searching.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_SEARCHING}" title="{$APP.LBL_SEARCHING}">
												</td>
										</tr>
										</table>
								</div>
						</td>
				</tr>
				</table>
		</td>
</tr>
</table>

<!-- Page header -->
<div class="slds-m-around_medium slds-p-around_medium slds-box slds-theme_default cbds-shadow-c--small">
    <!-- Top base row -->
    <div class="slds-grid">
        <div class="slds-col">
            <div class="slds-media">
                <div class="slds-media__figure">
                    <span class="slds-icon_container slds-icon-standard-opportunity">
                <svg class="slds-icon slds-page-header__icon" aria-hidden="true">
                  <use xlink:href="include/LD/assets/icons/standard-sprite/svg/symbols.svg#account" xmlns:xlink="http://www.w3.org/1999/xlink" />
                </svg>
              </span>
                </div>
                <div class="slds-media__body">
                    <div class="slds-page-header__name">
                        <div class="slds-page-header__name-title">
                            <h1>
                                <span class="slds-page-header__title slds-truncate" title="{$MODULE|@getTranslatedString:$MODULE}">{$MODULE|@getTranslatedString:$MODULE}</span>
                            </h1>
                            <span>{$recordListRange}</span>
                        </div>
                    </div>
                </div>
            </div>            
        </div>
        <div class="slds-col">
        	{if empty($HIDE_CUSTOM_LINKS) || $HIDE_CUSTOM_LINKS neq '1'}
            <span class="slds-text-title slds-truncate" title="{$MODULE|@getTranslatedString:$MODULE} {$APP.LBL_VIEW}">{$MODULE|@getTranslatedString:$MODULE} {$APP.LBL_VIEW}</span>
            <ul class="slds-button-group-list">
                <li>
                    <div class="slds-form-element">
                        <div class="slds-select_container">
                            <select class="slds-select" onchange="showDefaultCustomView(this,'{$MODULE}','{$CATEGORY}')">
                            	{foreach $CUSTOMVIEW_ARRAY as $CV_OPTION}
								<option {if $CV_OPTION.default} selected="selected"{/if}>{$CV_OPTION.name}</option>
                            	{/foreach}
                            </select>
                        </div>
                    </div>
                </li>
                <li>
                	<a href="index.php?module={$MODULE}&action=CustomView&parenttab={$CATEGORY}">
	                    <button class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LNK_CV_CREATEVIEW}">
	                        <svg class="slds-button__icon" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add" xmlns:xlink="http://www.w3.org/1999/xlink" />
	                        </svg>
	                        <span class="slds-assistive-text">{$APP.LNK_CV_CREATEVIEW}</span>
	                    </button>
                    </a>
                </li>
                {if $CV_EDIT_PERMIT == 'yes' || $SQLERROR}
                <li>
                	<a href="index.php?module={$MODULE}&action=CustomView&record={$VIEWID}&parenttab={$CATEGORY}">
	                    <button class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LNK_CV_EDIT}">
	                        <svg class="slds-button__icon" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#edit" xmlns:xlink="http://www.w3.org/1999/xlink" />
	                        </svg>
	                        <span class="slds-assistive-text">{$APP.LNK_CV_EDIT}</span>
	                    </button>
	                </a>
                </li>
                {/if}
                {if $CV_DELETE_PERMIT == 'yes'}
                <li>
                	<a href="javascript:confirmdelete('index.php?module=CustomView&action=Delete&dmodule={$MODULE}&record={$VIEWID}&parenttab={$CATEGORY}')">
	                    <button class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LNK_CV_DELETE}">
	                        <svg class="slds-button__icon" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete" xmlns:xlink="http://www.w3.org/1999/xlink" />
	                        </svg>
	                        <span class="slds-assistive-text">{$APP.LNK_CV_DELETE}</span>
	                    </button>
                	</a>
                </li>
                {/if}
                <li>
                    <button class="slds-button slds-button_icon slds-button_icon-border" title="{$CUSTOMVIEW_PERMISSION.Label}">
                        <svg class="slds-button__icon" aria-hidden="true">
                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#ban" xmlns:xlink="http://www.w3.org/1999/xlink" />
                        </svg>
                        <span class="slds-assistive-text">{$CUSTOMVIEW_PERMISSION.Label}</span>
                    </button>
                </li>
            </ul> 
            {/if}           
        </div>
        <div class="slds-col">
            <ul class="slds-button-group-list slds-float_right">
                <li>
                    <button class="slds-button slds-button_icon slds-button_icon-border" title="Advanced search" onclick="document.getElementById('cbds-advanced-search').classList.toggle('cbds-advanced-search--active');">
                        <svg class="slds-button__icon" aria-hidden="true">
                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#search" xmlns:xlink="http://www.w3.org/1999/xlink" />
                        </svg>
                        <span class="slds-assistive-text">Advanced search</span>
                    </button>
                </li>
				{if $CHECK.Import == 'yes'}
                <li>
                	<a href="index.php?module={$MODULE}&action=Import&step=1&return_module={$MODULE}&return_action=index&parenttab={$CATEGORY}">
	                    <button class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_IMPORT} {$MODULE|getTranslatedString:$MODULE}">
	                        <svg class="slds-button__icon" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#pop_in" xmlns:xlink="http://www.w3.org/1999/xlink" />
	                        </svg>
	                        <span class="slds-assistive-text">{$APP.LBL_IMPORT} {$MODULE|getTranslatedString:$MODULE}</span>
	                    </button>
                	</a>
                </li>
                {/if}
                {if $CHECK.Export == 'yes'}
                <li>
                	<a href="javascript:void(0)" onclick="return selectedRecords('{$MODULE}','{$CATEGORY}')">
	                    <button class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_EXPORT} {$MODULE|getTranslatedString:$MODULE}">
	                        <svg class="slds-button__icon" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#new_window" xmlns:xlink="http://www.w3.org/1999/xlink" />
	                        </svg>
	                        <span class="slds-assistive-text">{$APP.LBL_EXPORT} {$MODULE|getTranslatedString:$MODULE}</span>
	                    </button>
                	</a>
                </li>
                {/if}
                {if $CHECK.DuplicatesHandling == 'yes' && ($smarty.request.action == 'ListView' || $smarty.request.action == 'index')}
                <li>
                	<a href="javascript:;" onClick="mergeshowhide('mergeDup');searchhide('searchAcc','advSearch');">
	                	<button class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_FIND_DUPLICATES}">
	                		<svg class="slds-button__icon" aria-hidden="true">
	                			<use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#copy" xmlns:xlink="http://www.w3.org/1999/xlink" />
	                		</svg>
	                		<span class="slds-assistive-text">{$APP.LBL_FIND_DUPLICATES}</span>
	                	</button>
                	</a>
                </li>
                {/if}
                {if $CHECK.moduleSettings == 'yes'}
                <li>
                	<a href='index.php?module=Settings&action=ModuleManager&module_settings=true&formodule={$MODULE}&parenttab=Settings'>
	                    <button class="slds-button slds-button_icon slds-button_icon-border" title="{$MODULE|getTranslatedString:$MODULE} {$APP.LBL_SETTINGS}">
	                        <svg class="slds-button__icon" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#custom_apps" xmlns:xlink="http://www.w3.org/1999/xlink" />
	                        </svg>
	                        <span class="slds-assistive-text">{$MODULE|getTranslatedString:$MODULE} {$APP.LBL_SETTINGS}</span>
	                    </button>
                	</a>
                </li>
                {/if}
                {if $CHECK.CreateView == 'yes'}
                <li>
                	<a href="index.php?module={$MODULE}&action=EditView&return_action=DetailView&parenttab={$CATEGORY}">
	                    <button class="slds-button slds-button_success">
	                        <svg class="slds-button__icon slds-button__icon_left" aria-hidden="true">
	                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
	                        </svg>
	                        {$APP.LBL_CREATE_BUTTON_LABEL} {$SINGLE_MOD|getTranslatedString:$MODULE}
	                    </button>
	                </a>
                </li>
                {/if}
            </ul>            
        </div>
    </div>
    <!-- // Top base row -->
    <!-- Advanced search row -->
    <div class="slds-grid slds-m-top--large cbds-advanced-search--inactive" id="cbds-advanced-search">
        <div class="slds-col">
            <div class="slds-expression">
                <h2 class="slds-expression__title">Advanced search</h2>
                <ul>
                    <li class="slds-expression__group">
                        <fieldset>
                            <legend class="slds-expression__legend slds-expression__legend_group">
                                <span>AND</span>
                                <span class="slds-assistive-text">Condition Group 1</span>
                            </legend>
                            <div class="slds-expression__options">
                                <div class="slds-form-element">
                                    <label class="slds-form-element__label" for="combobox-id-91">Take Action When</label>
                                    <div class="slds-form-element__control">
                                        <div class="slds-combobox_container">
                                            <div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click" aria-expanded="false" aria-haspopup="listbox" role="combobox" id="combobox-1">
                                                <div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
                                                    <input class="slds-input slds-combobox__input slds-combobox__input-value" id="combobox-id-91" aria-controls="listbox-id-91" autocomplete="off" role="textbox" type="text" placeholder="Select an Option" readonly="" value="Any Condition Is Met in This Group" onfocus="document.getElementById('combobox-1').classList.add('slds-is-open');" onblur="document.getElementById('combobox-1').classList.remove('slds-is-open');">
                                                    <span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
                                                        <svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
                                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#down"></use>
                                                        </svg>
                                                    </span>
                                                </div>
                                                <div id="listbox-id-91" class="slds-dropdown slds-dropdown_length-5 slds-dropdown_fluid" role="listbox">
                                                    <ul class="slds-listbox slds-listbox_vertical" role="presentation">
                                                        <li role="presentation" class="slds-listbox__item">
                                                            <div id="listbox-option-id-383" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                <span class="slds-media__body">
                                                                    <span class="slds-truncate" title="All Conditions Are Met for This Group">
                                                                        All Conditions Are Met for This Group
                                                                    </span>
                                                                </span>
                                                            </div>
                                                        </li>
                                                        <li role="presentation" class="slds-listbox__item">
                                                            <div aria-selected="true" id="listbox-option-id-384" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small slds-is-selected slds-has-focus" role="option">
                                                                <span class="slds-media__figure slds-listbox__option-icon">
                                                                    <span class="slds-icon_container slds-icon-utility-check slds-current-color">
                                                                        <svg class="slds-icon slds-icon_x-small" aria-hidden="true">
                                                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#check"></use>
                                                                        </svg>
                                                                    </span>
                                                                </span>
                                                                <span class="slds-media__body">
                                                                    <span class="slds-truncate" title="Any Condition Is Met for This Group">
                                                                        <span class="slds-assistive-text">
                                                                            Current Selection:
                                                                        </span>
                                                                        Any Condition Is Met for This Group
                                                                    </span>
                                                                </span>
                                                            </div>
                                                        </li>
                                                        <li role="presentation" class="slds-listbox__item">
                                                            <div id="listbox-option-id-385" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                <span class="slds-media__body">
                                                                    <span class="slds-truncate" title="Custom Logic Is Met for This Group">
                                                                        Custom Logic Is Met for This Group
                                                                    </span>
                                                                </span>
                                                            </div>
                                                        </li>
                                                        <li role="presentation" class="slds-listbox__item">
                                                            <div id="listbox-option-id-386" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                <span class="slds-media__body">
                                                                    <span class="slds-truncate" title="Always (No Criteria)">
                                                                        Always (No Criteria)
                                                                    </span>
                                                                </span>
                                                            </div>
                                                        </li>
                                                        <li role="presentation" class="slds-listbox__item">
                                                            <div id="listbox-option-id-387" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                <span class="slds-media__body">
                                                                    <span class="slds-truncate" title="Formula Evaluates To True">
                                                                        Formula Evaluates To True
                                                                    </span>
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
                            <ul>
                                <li class="slds-expression__row slds-expression__row_group">
                                    <fieldset>
                                        <legend class="slds-expression__legend">
                                            <span class="slds-assistive-text">Condition 1 of Condition Group 1</span>
                                        </legend>
                                        <div class="slds-grid slds-gutters_xx-small">
                                            <div class="slds-col">
                                                <div class="slds-form-element">
                                                    <label class="slds-form-element__label" for="combobox-id-92">Resource</label>
                                                    <div class="slds-form-element__control">
                                                        <div class="slds-combobox_container">
                                                            <div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click" aria-expanded="false" aria-haspopup="listbox" role="combobox">
                                                                <div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
                                                                    <input class="slds-input slds-combobox__input slds-combobox__input-value" id="combobox-id-92" aria-controls="listbox-id-92" autocomplete="off" role="textbox" type="text" placeholder="Select an Option" readonly="" value="Resource 1">
                                                                    <span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
                                                                        <svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
                                                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#down"></use>
                                                                        </svg>
                                                                    </span>
                                                                </div>
                                                                <div id="listbox-id-92" class="slds-dropdown slds-dropdown_length-5 slds-dropdown_fluid" role="listbox">
                                                                    <ul class="slds-listbox slds-listbox_vertical" role="presentation">
                                                                        <li role="presentation" class="slds-listbox__item">
                                                                            <div aria-selected="true" id="listbox-option-id-388" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small slds-is-selected slds-has-focus" role="option">
                                                                                <span class="slds-media__figure slds-listbox__option-icon">
                                                                                    <span class="slds-icon_container slds-icon-utility-check slds-current-color">
                                                                                        <svg class="slds-icon slds-icon_x-small" aria-hidden="true">
                                                                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#check"></use>
                                                                                        </svg>
                                                                                    </span>
                                                                                </span>
                                                                                <span class="slds-media__body">
                                                                                    <span class="slds-truncate" title="Resource 1">
                                                                                        <span class="slds-assistive-text">
                                                                                            Current Selection:
                                                                                        </span>
                                                                                        Resource 1
                                                                                    </span>
                                                                                </span>
                                                                            </div>
                                                                        </li>
                                                                        <li role="presentation" class="slds-listbox__item">
                                                                            <div id="listbox-option-id-389" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                                <span class="slds-media__body">
                                                                                    <span class="slds-truncate" title="Resource 2">
                                                                                        Resource 2
                                                                                    </span>
                                                                                </span>
                                                                            </div>
                                                                        </li>
                                                                        <li role="presentation" class="slds-listbox__item">
                                                                            <div id="listbox-option-id-390" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                                <span class="slds-media__body">
                                                                                    <span class="slds-truncate" title="Resource 3">
                                                                                        Resource 3
                                                                                    </span>
                                                                                </span>
                                                                            </div>
                                                                        </li>
                                                                        <li role="presentation" class="slds-listbox__item">
                                                                            <div id="listbox-option-id-391" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                                <span class="slds-media__body">
                                                                                    <span class="slds-truncate" title="Resource 4">
                                                                                        Resource 4
                                                                                    </span>
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
                                            <div class="slds-col slds-grow-none">
                                                <div class="slds-form-element">
                                                    <label class="slds-form-element__label" for="combobox-id-93">Operator</label>
                                                    <div class="slds-form-element__control">
                                                        <div class="slds-combobox_container">
                                                            <div class="slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click" aria-expanded="false" aria-haspopup="listbox" role="combobox">
                                                                <div class="slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" role="none">
                                                                    <input class="slds-input slds-combobox__input" id="combobox-id-93" aria-controls="listbox-id-93" autocomplete="off" role="textbox" type="text" placeholder="Select an Option" readonly="" value="">
                                                                    <span class="slds-icon_container slds-icon-utility-down slds-input__icon slds-input__icon_right">
                                                                        <svg class="slds-icon slds-icon slds-icon_x-small slds-icon-text-default" aria-hidden="true">
                                                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#down"></use>
                                                                        </svg>
                                                                    </span>
                                                                </div>
                                                                <div id="listbox-id-93" class="slds-dropdown slds-dropdown_length-5 slds-dropdown_fluid" role="listbox">
                                                                    <ul class="slds-listbox slds-listbox_vertical" role="presentation">
                                                                        <li role="presentation" class="slds-listbox__item">
                                                                            <div id="listbox-option-id-392" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                                <span class="slds-media__body">
                                                                                    <span class="slds-truncate" title="Equals">
                                                                                        Equals
                                                                                    </span>
                                                                                </span>
                                                                            </div>
                                                                        </li>
                                                                        <li role="presentation" class="slds-listbox__item">
                                                                            <div id="listbox-option-id-393" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                                <span class="slds-media__body">
                                                                                    <span class="slds-truncate" title="Does Not Equal">
                                                                                        Does Not Equal
                                                                                    </span>
                                                                                </span>
                                                                            </div>
                                                                        </li>
                                                                        <li role="presentation" class="slds-listbox__item">
                                                                            <div id="listbox-option-id-394" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                                <span class="slds-media__body">
                                                                                    <span class="slds-truncate" title="Greater Than">
                                                                                        Greater Than
                                                                                    </span>
                                                                                </span>
                                                                            </div>
                                                                        </li>
                                                                        <li role="presentation" class="slds-listbox__item">
                                                                            <div id="listbox-option-id-395" class="slds-media slds-listbox__option slds-listbox__option_plain slds-media_small" role="option">
                                                                                <span class="slds-media__figure slds-listbox__option-icon"></span>
                                                                                <span class="slds-media__body">
                                                                                    <span class="slds-truncate" title="Less Than">
                                                                                        Less Than
                                                                                    </span>
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
                                                    <label class="slds-form-element__label" for="text-input-id-35">Value</label>
                                                    <div class="slds-form-element__control">
                                                        <input id="text-input-id-35" class="slds-input" type="text" value="">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="slds-col slds-grow-none">
                                                <div class="slds-form-element"><span class="slds-form-element__label">&nbsp;</span>
                                                    <div class="slds-form-element__control">
                                                        <button class="slds-button slds-button_icon slds-button_icon-border-filled" title="Delete Condition 1 of Condition Group 1">
                                                            <svg class="slds-button__icon" aria-hidden="true">
                                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
                                                            </svg>
                                                            <span class="slds-assistive-text">
                                                                Delete Condition 1 of Condition Group 1
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
                                <button class="slds-button slds-button_neutral">
                                    <svg class="slds-button__icon slds-button__icon_left" aria-hidden="true">
                                        <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
                                    </svg>Add Condition
                                </button>
                            </div>
                        </fieldset>
                    </li>
                </ul>
                <div class="slds-expression__buttons">
                    <button class="slds-button slds-button_neutral">
                        <svg class="slds-button__icon slds-button__icon_left" aria-hidden="true">
                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
                        </svg>Add Group
                    </button>
                </div>
            </div>               
        </div>
    </div>
    <!-- // Advanced search row -->
</div>
<!-- // Page header -->

<!-- Content table -->
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
                    <button class="slds-button slds-button_icon slds-button_icon-border cbds-bg-white" title="Previous">
                        <svg class="slds-button__icon" aria-hidden="true">
                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#left" xmlns:xlink="http://www.w3.org/1999/xlink" />
                        </svg>
                    </button>
                    <div class="slds-form-element slds-border_top slds-border_bottom cbds-bg-white" style="height: 32px;">
                      <div class="slds-form-element__control">
                        <input id="text-input-id-1" size="3" class="slds-input slds-input_bare" type="text" value="1" />
                      </div>
                    </div>
                    <button class="slds-button slds-button_icon slds-button_icon-border cbds-bg-white" title="Next">
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
                    <span id="column-group-header" class="slds-assistive-text">Choose a row</span>
                    <div class="slds-th__action slds-th__action_form">
                        <div class="slds-checkbox">
                            <input type="checkbox" name="options" id="checkbox-1" tabindex="-1" aria-labelledby="check-select-all-label column-group-header" value="checkbox-1">
                            <label class="slds-checkbox__label" for="checkbox-1" id="check-select-all-label">
                                <span class="slds-checkbox_faux"></span>
                                <span class="slds-form-element__label slds-assistive-text">Select All</span>
                            </label>
                        </div>
                    </div>
                </th>
                {foreach name="listviewforeach" item=header from=$LISTHEADER_ARRAY}
                <th aria-label="Name" aria-sort="none" class="slds-text-title_caps slds-is-sortable" scope="col">
                    <a class="slds-th__action slds-text-link_reset" href="javascript:void(0);" role="button" tabindex="-1">
                        <span class="slds-assistive-text">Sort by: </span>
                        <div class="slds-grid slds-grid_vertical-align-center slds-has-flexi-truncate">
                            <span class="slds-truncate" title="{$header}">{$header}</span>
                            <span class="slds-icon_container slds-icon-utility-arrowdown">
                                <svg class="slds-icon slds-icon-text-default slds-is-sortable__icon " aria-hidden="true">
                                    <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#arrowdown"></use>
                                </svg>
                            </span>
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
<!-- // Content table -->

{*<!-- Contents -->*}
<table border=0 cellspacing=0 cellpadding=0 width=98% align=center>
	<tr>
	<td valign=top><img src="{'showPanelTopLeft.gif'|@vtiger_imageurl:$THEME}"></td>
	<td class="showPanelBg" valign="top" width=100% style="padding:10px;">
	<!-- SIMPLE SEARCH -->
<div id="searchAcc" style="{$DEFAULT_SEARCH_PANEL_STATUS};position:relative;">
<form name="basicSearch" method="post" action="index.php" onSubmit="document.basicSearch.searchtype.searchlaunched='basic';return callSearch('Basic');">
<table width="100%" cellpadding="5" cellspacing="0" class="searchUIBasic small" align="center" border=0>
	<tr>
		<td class="searchUIName small" nowrap align="left">
		<span class="moduleName">{$APP.LBL_SEARCH}</span><br><span class="small"><a href="#" onClick="fnhide('searchAcc');show('advSearch');document.basicSearch.searchtype.value='advance';document.basicSearch.searchtype.searchlaunched='';">{$APP.LBL_GO_TO} {$APP.LNK_ADVANCED_SEARCH}</a></span>
		<!-- <img src="themes/images/basicSearchLens.gif" align="absmiddle" alt="{$APP.LNK_BASIC_SEARCH}" title="{$APP.LNK_BASIC_SEARCH}" border=0>&nbsp;&nbsp;-->
		</td>
		<td class="small" nowrap align=right><b>{$APP.LBL_SEARCH_FOR}</b></td>
		<td class="small"><input type="text" class="txtBox" style="width:120px" name="search_text"></td>
		<td class="small" nowrap><b>{$APP.LBL_IN}</b>&nbsp;</td>
		<td class="small" nowrap>
			<div id="basicsearchcolumns_real">
			<select name="search_field" id="bas_searchfield" class="txtBox" style="width:150px">
			{html_options options=$SEARCHLISTHEADER }
			</select>
			</div>
			<input type="hidden" name="searchtype" value="BasicSearch">
			<input type="hidden" name="module" value="{$MODULE}" id="curmodule">
			<input name="maxrecords" type="hidden" value="{$MAX_RECORDS}" id='maxrecords'>
			<input type="hidden" name="parenttab" value="{$CATEGORY}">
			<input type="hidden" name="action" value="index">
			<input type="hidden" name="query" value="true">
			<input type="hidden" name="search_cnt">
		</td>
		<td class="small" nowrap width=40% >
			<input name="submit" type="button" class="crmbutton small create" onClick="callSearch('Basic');document.basicSearch.searchtype.searchlaunched='basic';" value=" {$APP.LBL_SEARCH_NOW_BUTTON} ">&nbsp;
		</td>
		<td class="small closeX" valign="top" onMouseOver="this.style.cursor='pointer';" onclick="searchshowhide('searchAcc','advSearch');document.basicSearch.searchtype.searchlaunched='';">[x]</td>
	</tr>
	<tr>
		<td colspan="7" align="center" class="small">
			<table border=0 cellspacing=0 cellpadding=0 width=100%>
				<tr>
				{$ALPHABETICAL}
				</tr>
			</table>
		</td>
	</tr>
</table>
</form><br class="searchbreak">
</div>
<!-- ADVANCED SEARCH -->
<div id="advSearch" style="display:none;">
<form name="advSearch" method="post" action="index.php" onSubmit="document.basicSearch.searchtype.searchlaunched='advance';return callSearch('Advanced');">
	<table cellspacing=0 cellpadding=5 width=100% class="searchUIAdv1 small" align="center" border=0>
		<tr>
			<td class="searchUIName small" nowrap align="left"><span class="moduleName">{$APP.LBL_SEARCH}</span><br><span class="small"><a href="#" onClick="show('searchAcc');fnhide('advSearch');document.basicSearch.searchtype.searchlaunched='';">{$APP.LBL_GO_TO} {$APP.LNK_BASIC_SEARCH}</a></span></td>
			<td class="small closeX" align="right" valign="top" onMouseOver="this.style.cursor='pointer';" onclick="searchshowhide('searchAcc','advSearch');document.basicSearch.searchtype.searchlaunched='';">[x]</td>
		</tr>
	</table>
	<table cellpadding="2" cellspacing="0" width="100%" align="center" class="searchUIAdv2 small" border=0>
		<tr>
			<td align="center" class="small" width=90%>
				{include file='AdvanceFilter.tpl' SOURCE='customview' COLUMNS_BLOCK=$FIELDNAMES}
			</td>
		</tr>
	</table>

	<table border=0 cellspacing=0 cellpadding=5 width=100% class="searchUIAdv3 small" align="center">
		<tr>
			<td align="center" class="small"><input type="button" class="crmbutton small create" value=" {$APP.LBL_SEARCH_NOW_BUTTON} " onClick="callSearch('Advanced');document.basicSearch.searchtype.searchlaunched='advance';">
			</td>
		</tr>
	</table>
</form><br>
</div>
{*<!-- Searching UI -->*}

<div id="mergeDup" style="z-index:1;display:none;position:relative;">
	{include file="MergeColumns.tpl"}
</div>
	<!-- PUBLIC CONTENTS STARTS-->
	<div id="ListViewContents" class="small" style="width:100%;">
	{if $MODULE neq "Documents" || $Document_Folder_View eq 0}
		{include file="ListViewEntries.tpl"}
	{else}
		{include file="DocumentsListViewEntries.tpl"}
	{/if}
	</div>

	</td>
	<td valign=top><img src="{'showPanelTopRight.gif'|@vtiger_imageurl:$THEME}"></td>
	</tr>
</table>

<!-- MassEdit Feature -->
<div id="massedit" class="layerPopup" style="display:none;width:80%;">
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="layerHeadingULine">
<tr>
	<td class="layerPopupHeading" align="left" width="60%">{$APP.LBL_MASSEDIT_FORM_HEADER}</td>
	<td>&nbsp;</td>
	<td align="right" width="40%"><img onClick="fninvsh('massedit');" title="{$APP.LBL_CLOSE}" alt="{$APP.LBL_CLOSE}" style="cursor:pointer;" src="{'close.gif'|@vtiger_imageurl:$THEME}" align="absmiddle" border="0"></td>
</tr>
</table>
<div id="massedit_form_div"></div>

</div>
<div id="relresultssection" style="visibility:hidden;display:none;" class="slds-masseditprogress">
<div class="slds-grid">
<div class="slds-col">
	<div class="slds-page-header" role="banner">
		<div class="slds-col slds-has-flexi-truncate">
			<div class="slds-media slds-no-space slds-grow">
				<div class="slds-media__figure">
					<svg aria-hidden="true" class="slds-icon slds-icon-standard-user">
						<use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#relate"></use>
					</svg>
				</div>
				<div class="slds-media__body">
					<h1 class="slds-page-header__title slds-m-right--small slds-align-middle slds-truncate"
						title="{$APP.Updated}">{$APP.Updated}...</h1>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="slds-col slds-page-header" style="width:50%;">
<progress id='progressor' value="0" max='100' style="width:90%;height:14px;"></progress>
<span id="percentage" style="text-align:left; display:block; margin-top:5px;">0</span>
</div>
<div class="slds-col slds-page-header slds-p-top--small" style="width:10%;">
	<div class="slds-icon_container slds-icon_container--circle slds-p-around--xx-small slds-icon-action-close">
		<svg class="slds-icon slds-icon--xx-small" aria-hidden="true" onClick="fninvsh('relresultssection');">
			<use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#close"></use>
		</svg>
		<span class="slds-assistive-text">{$APP.LBL_CLOSE}</span>
	</div>
</div>
</div>
<div class="slds-grid">
<div class="slds-col">
<div id="relresults" style="border:1px solid #000; padding:10px; width:90%; height:450px; overflow:auto; background:#eee; margin:auto; margin-top:10px;"></div>
</div>
</div>
</div>
<!-- END -->
{if $MODULE|hasEmailField}
<form name="SendMail" method="post"><div id="sendmail_cont" style="z-index:100001;position:absolute;"></div></form>
{/if}
{if (vt_hasRTE())}
<script type="text/javascript" src="include/ckeditor/ckeditor.js"></script>
{/if}
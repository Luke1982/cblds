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

<!-- Listview content wrapper -->
<div id="listview-content-wrapper">
	{include file="ListViewEntries.tpl"}
</div>
<!-- // Listview content wrapper -->

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
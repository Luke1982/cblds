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

<!-- LDS mass edit modal -->
<section role="dialog" tabindex="-1" aria-labelledby="modal-heading-01" aria-modal="true" aria-describedby="modal-content-id-1" class="slds-modal slds-fade-in-open slds-modal_large">
	<form name="EditView" id="massedit_form" action="index.php" onsubmit="VtigerJS_DialogBox.block();" method="POST">
		<input id="idstring" name="idstring" value="{$IDS}" type="hidden" />
		<!-- Hidden Fields -->
		{include file='EditViewHidden.tpl'}
		<input type="hidden" name="massedit_recordids">
		<input type="hidden" name="massedit_module">		
	    <div class="slds-modal__container">
	        <header class="slds-modal__header cbds-bg-blue--gray slds-text-color_inverse">
	            <button type="button" class="slds-button slds-button_icon slds-modal__close slds-button_icon-inverse" title="{$APP.LBL_CLOSE}" onclick="document.getElementById('cbds-massedit').classList.remove('cbds-massedit--active');">
	                <svg class="slds-button__icon slds-button__icon_large" aria-hidden="true">
	                    <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#close" xmlns:xlink="http://www.w3.org/1999/xlink" />
	                </svg>
	                <span class="slds-assistive-text">{$APP.LBL_CLOSE}</span>
	            </button>
	            <h2 id="modal-heading-01" class="slds-text-heading_medium slds-hyphenate">{$APP.LBL_MASSEDIT_FORM_HEADER}</h2>
	            <span>{$APP.LBL_SELECT_FIELDS_TO_UDPATE_WITH_NEW_VALUE}</span>
	        </header>
	        <div class="slds-modal__content slds-p-around_medium" id="modal-content-id-1">
	            <div class="slds-tabs_default">
	                <ul class="slds-tabs_default__nav" role="tablist">
	                	{foreach key=header name=block item=data from=$BLOCKS}
	                    <li class="slds-tabs_default__item{if $data@first} slds-is-active{/if}" title="{$header}" role="presentation" id="tab{$smarty.foreach.block.index}" onclick="massedit_togglediv({$smarty.foreach.block.index},{$BLOCKS|@count});">
	                        <a class="slds-tabs_default__link" href="javascript:void(0);" role="tab" tabindex="0" aria-selected="{if $data@first}true{else}false{/if}" aria-controls="massedit_div{$smarty.foreach.block.index}">{$header}</a>
	                    </li>
	                    {/foreach}
	                </ul>
	                {foreach key=header name=block item=data from=$BLOCKS}
	                <div id="massedit_div{$smarty.foreach.block.index}" class="slds-tabs_default__content{if $data@first} slds-show{else} slds-hide{/if} slds-theme_shade slds-theme_alert-texture" role="tabpanel" aria-labelledby="tab-default-1__item">
	                    <!-- Tab content -->
	                    <div class="slds-form slds-form_horizontal">
	                    	{include file="DisplayFields.tpl"}
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Related to</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-grid slds-size_11-of-12">
	                                                    <div class="slds-col slds-size_4-of-12 slds-p-left--none slds-p-right_xxx-small">
	                                                        <div class="slds-form-element slds-col slds-grid slds-p-horizontal_none">
	                                                            <div class="slds-form-element__control slds-col slds-p-horizontal_none">
	                                                                <div class="slds-select_container">
	                                                                    <select class="slds-select" id="select-01">
	                                                                        <option value="">Please select an option</option>
	                                                                        <option>Leads</option>
	                                                                        <option>Quotes</option>
	                                                                        <option>Salesorders</option>
	                                                                    </select>
	                                                                </div>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                    <div class="slds-col slds-size_6-of-12 slds-p-left--none slds-p-right_xxx-small">
	                                                        <input class="slds-input" />
	                                                    </div>
	                                                    <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
	                                                        <div class="slds-button-group">
	                                                            <button class="slds-button slds-button_icon slds-button_icon-border" title="Search">
	                                                                <svg class="slds-button__icon" aria-hidden="true">
	                                                                    <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
	                                                                </svg>
	                                                                <span class="slds-assistive-text">Add</span>
	                                                            </button>
	                                                            <button class="slds-button slds-button_icon slds-button_icon-border" title="Search">
	                                                                <svg class="slds-button__icon" aria-hidden="true">
	                                                                    <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
	                                                                </svg>
	                                                                <span class="slds-assistive-text">Remove</span>
	                                                            </button>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Related to</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-grid slds-size_11-of-12">
	                                                    <div class="slds-col slds-size_10-of-12 slds-p-left--none slds-p-right_xxx-small">
	                                                        <input class="slds-input" />
	                                                    </div>
	                                                    <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
	                                                        <div class="slds-button-group">
	                                                            <button class="slds-button slds-button_icon slds-button_icon-border" title="Search">
	                                                                <svg class="slds-button__icon" aria-hidden="true">
	                                                                    <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
	                                                                </svg>
	                                                                <span class="slds-assistive-text">Add</span>
	                                                            </button>
	                                                            <button class="slds-button slds-button_icon slds-button_icon-border" title="Search">
	                                                                <svg class="slds-button__icon" aria-hidden="true">
	                                                                    <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
	                                                                </svg>
	                                                                <span class="slds-assistive-text">Remove</span>
	                                                            </button>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Website</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Phone</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Ticker</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Fax</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Notify owner</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <label class="slds-checkbox_toggle">
	                                                        <input name="checkbox-toggle-2" type="checkbox" aria-describedby="checkbox-toggle-2" value="checkbox-toggle-2" />
	                                                        <span id="checkbox-toggle-2" class="slds-checkbox_faux_container" aria-live="assertive">
	                                                            <span class="slds-checkbox_faux"></span>
	                                                            <span class="slds-checkbox_on">Yes</span>
	                                                            <span class="slds-checkbox_off">No</span>
	                                                        </span>
	                                                    </label>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Industry</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <div class="slds-form-element slds-col slds-grid slds-p-horizontal_none">
	                                                        <div class="slds-form-element__control slds-col slds-p-horizontal_none">
	                                                            <div class="slds-select_container">
	                                                                <select class="slds-select" id="select-01">
	                                                                    <option value="">Please select an option</option>
	                                                                    <option>Option One</option>
	                                                                    <option>Option Two</option>
	                                                                    <option>Option Three</option>
	                                                                </select>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Notify owner</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <label class="slds-checkbox_toggle">
	                                                        <input name="checkbox-toggle-2" type="checkbox" aria-describedby="checkbox-toggle-2" value="checkbox-toggle-2" />
	                                                        <span id="checkbox-toggle-2" class="slds-checkbox_faux_container" aria-live="assertive">
	                                                            <span class="slds-checkbox_faux"></span>
	                                                            <span class="slds-checkbox_on">Yes</span>
	                                                            <span class="slds-checkbox_off">No</span>
	                                                        </span>
	                                                    </label>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Industry</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <div class="slds-form-element slds-col slds-grid slds-p-horizontal_none">
	                                                        <div class="slds-form-element__control slds-col slds-p-horizontal_none">
	                                                            <div class="slds-grid">
	                                                                <div class="slds-col slds-size_5-of-12 slds-p-horizontal_none">
	                                                                    <div class="slds-radio_button-group">
	                                                                        <span class="slds-button slds-radio_button">
	                                                                            <input name="radio" type="radio" id="monday" value="monday" />
	                                                                            <label class="slds-radio_button__label" for="monday">
	                                                                                <span class="slds-radio_faux">User</span>
	                                                                            </label>
	                                                                        </span>
	                                                                        <span class="slds-button slds-radio_button">
	                                                                            <input name="radio" type="radio" id="tuesday" value="tuesday" />
	                                                                            <label class="slds-radio_button__label" for="tuesday">
	                                                                                <span class="slds-radio_faux">Group</span>
	                                                                            </label>
	                                                                        </span>
	                                                                    </div>
	                                                                </div>
	                                                                <div class="slds-col slds-size_7-of-12 slds-p-horizontal_none">
	                                                                    <div class="slds-select_container">
	                                                                        <select class="slds-select" id="select-01">
	                                                                            <option value="">Please select an option</option>
	                                                                            <option>Option One</option>
	                                                                            <option>Option Two</option>
	                                                                            <option>Option Three</option>
	                                                                        </select>
	                                                                    </div>
	                                                                </div>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                    </div>
	                    <!-- // Tab content -->
	                </div>
	                {/foreach}
	                <div id="tab-default-2" class="slds-tabs_default__content slds-hide" role="tabpanel" aria-labelledby="tab-default-2__item">
	                    <!-- Tab content -->
	                    <div class="slds-form slds-form_horizontal">
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Billing address</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <textarea class="slds-textarea"></textarea>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Shipping address</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <textarea class="slds-textarea"></textarea>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">B postbox</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">S postbox</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">B city</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">S city</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">B region</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">S region</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">B postal code</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">S postal code</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">B country</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-2 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">S country</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <input type="text" name="" class="slds-input" />
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                    </div>
	                    <!-- // Tab content -->
	                </div>
	                <div id="tab-default-3" class="slds-tabs_default__content slds-hide" role="tabpanel" aria-labelledby="tab-default-3__item">
	                    <!-- Tab content -->
	                    <div class="slds-form slds-form_horizontal">
	                        <!-- Form row -->
	                        <div class="slds-grid slds-gutters_small">
	                            <div class="slds-col slds-has-flexi-truncate slds-grid">
	                                <!-- Field -->
	                                <div class="slds-col slds-size_1-of-1 slds-grid">
	                                    <div class="slds-form-element slds-p-horizontal_small">
	                                        <label class="slds-form-element__label">Description</label>
	                                        <div class="slds-form-element__control">
	                                            <div class="slds-grid">
	                                                <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                                    <div class="slds-checkbox_add-button">
	                                                        <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                                        <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                                            <span class="slds-assistive-text">Edit website</span>
	                                                        </label>
	                                                    </div>
	                                                </div>
	                                                <div class="slds-col slds-size_11-of-12">
	                                                    <textarea class="slds-textarea"></textarea>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- // Field -->
	                            </div>
	                        </div>
	                        <!-- // Form row -->
	                    </div>
	                    <!-- // Tab content -->
	                </div>
	            </div>
	        </div>
	        <footer class="slds-modal__footer" style="width: 100%;">
	            <button class="slds-button slds-button_neutral">Cancel</button>
	            <button class="slds-button slds-button_brand">Save</button>
	        </footer>
	    </div>
	</form>
</section>
<div class="slds-backdrop slds-backdrop_open"></div>
<!-- LDS mass edit modal -->

<table border=0 cellspacing=0 cellpadding=5 width=100% align=center>
	<tr>
		<td class="small">
			<!-- popup specific content fill in starts -->
			<form name="EditView" id="massedit_form" action="index.php" onsubmit="VtigerJS_DialogBox.block();" method="POST">
				<input id="idstring" name="idstring" value="{$IDS}" type="hidden" />
				<table border=0 cellspacing=0 cellpadding=0 width=100% align=center bgcolor=white>
				<tr>
					<td colspan=4 valign="top">
						<div style='padding: 5px 0;'>
							<span class="helpmessagebox">{$APP.LBL_SELECT_FIELDS_TO_UDPATE_WITH_NEW_VALUE}</span>
						</div>
						<!-- Hidden Fields -->
						{include file='EditViewHidden.tpl'}
						<input type="hidden" name="massedit_recordids">
						<input type="hidden" name="massedit_module">
					</td>
				</tr>
					<tr>
						<td colspan=4>
							<table class="small" border="0" cellpadding="3" cellspacing="0" width="100%">
								<tbody><tr>
									<td class="dvtTabCache" style="width: 10px;" nowrap>&nbsp;</td>
									{foreach key=header name=block item=data from=$BLOCKS}
										{if $smarty.foreach.block.index eq 0}
											<td nowrap class="dvtSelectedCell" id="tab{$smarty.foreach.block.index}" onclick="massedit_togglediv({$smarty.foreach.block.index},{$BLOCKS|@count});">
											<b>{$header}</b>
											</td>
										{else}
											<td nowrap class="dvtUnSelectedCell" id="tab{$smarty.foreach.block.index}" onclick="massedit_togglediv({$smarty.foreach.block.index},{$BLOCKS|@count});">
											<b>{$header}</b>
											</td>
										{/if}
									{/foreach}
								<td class="dvtTabCache" nowrap style="width:55%;">&nbsp;</td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan=4>
							{foreach key=header name=block item=data from=$BLOCKS}
								{if $smarty.foreach.block.index eq 0}
									<div id="massedit_div{$smarty.foreach.block.index}" style='display:block;'>
									<table border=0 cellspacing=0 cellpadding=5 width=100% align=center bgcolor=white>
										{include file="DisplayFields.tpl"}
									</table>
									</div>
								{else}
									<div id="massedit_div{$smarty.foreach.block.index}" style='display:none;'>
									<table border=0 cellspacing=0 cellpadding=5 width=100% align=center bgcolor=white>
										{include file="DisplayFields.tpl"}
									</table>
									</div>
								{/if}
							{/foreach}
						</td>
					</tr>
			</table>
			<table border=0 cellspacing=0 cellpadding=5 width=100% class="layerPopupTransport">
				<tr>
					<td align="center">
						<!--input type="submit" name="save" class="crmbutton small edit" value="{$APP.LBL_SAVE_LABEL}">
						<input type="button" name="button" class="crmbutton small cancel" value="{$APP.LBL_CANCEL_BUTTON_LABEL}" onClick="fninvsh('massedit')"-->
						<input title="{$APP.LBL_SAVE_BUTTON_TITLE}" accessKey="{$APP.LBL_SAVE_BUTTON_KEY}" class="crmbutton small save" onclick="run_massedit();" type="button" name="button" value="  {$APP.LBL_SAVE_BUTTON_LABEL}  ">
						<input title="{$APP.LBL_CANCEL_BUTTON_TITLE}" accessKey="{$APP.LBL_CANCEL_BUTTON_KEY}" class="crmbutton small cancel" onclick="fninvsh('massedit')" type="button" name="button" value="  {$APP.LBL_CANCEL_BUTTON_LABEL}  ">
					</td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
</table>

<script type="text/javascript" id="massedit_javascript">
	window.fieldname = new Array({$VALIDATION_DATA_FIELDNAME});
	window.fieldlabel = new Array({$VALIDATION_DATA_FIELDLABEL});
	window.fielddatatype = new Array({$VALIDATION_DATA_FIELDDATATYPE});
	count=0;
	massedit_initOnChangeHandlers();
{if $PICKIST_DEPENDENCY_DATASOURCE neq ''}
	(new FieldDependencies({$PICKIST_DEPENDENCY_DATASOURCE})).setup();
{/if}
<!-- vtlib customization: Help information assocaited with the fields -->
{if $FIELDHELPINFO}
	window.fieldhelpinfo = {literal}{}{/literal};
{foreach item=FIELDHELPVAL key=FIELDHELPKEY from=$FIELDHELPINFO}
	fieldhelpinfo["{$FIELDHELPKEY}"] = "{$FIELDHELPVAL}";
{/foreach}
{/if}
<!-- END -->
</script>

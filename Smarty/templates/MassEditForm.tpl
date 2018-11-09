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
		<!-- Hidden Fields -->
		{include file='EditViewHidden.tpl'}
		<input type="hidden" name="massedit_recordids">
		<input type="hidden" name="massedit_module">
		<input id="idstring" name="idstring" value="{$IDS}" type="hidden" />
		<!-- Modal container -->
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
	        <div class="slds-modal__content slds-p-around_medium">
	            <div class="slds-tabs_default">
	                <ul class="slds-tabs_default__nav" role="tablist">
	                	{foreach key=header name=block item=data from=$BLOCKS}
	                    <li class="slds-tabs_default__item{if $data@first} slds-is-active{/if}" title="{$header}" role="presentation" id="tab{$smarty.foreach.block.index}" onclick="massedit_togglediv({$smarty.foreach.block.index},{$BLOCKS|@count});">
	                        <a class="slds-tabs_default__link" href="javascript:void(0);" role="tab" tabindex="0" aria-selected="{if $data@first}true{else}false{/if}" aria-controls="massedit_div{$smarty.foreach.block.index}">{$header}</a>
	                    </li>
	                    {/foreach}
	                </ul>
	                {foreach key=header name=block item=data from=$BLOCKS}
	                <div id="massedit_div{$smarty.foreach.block.index}" class="slds-tabs_default__content{if $data@first} slds-show{else} slds-hide{/if} slds-theme_shade slds-theme_alert-texture" role="tabpanel" aria-labelledby="massedit_div{$smarty.foreach.block.index}">
	                    <!-- Tab content -->
	                    <div class="slds-form slds-form_horizontal">
	                    	{include file="DisplayFields.tpl"}
	                    </div>
	                    <!-- // Tab content -->
	                </div>
	                {/foreach}
	            </div>
	        </div>
	        <footer class="slds-modal__footer" style="width: 100%;">
	            <button type="button" class="slds-button slds-button_neutral" onclick="document.getElementById('cbds-massedit').classList.remove('cbds-massedit--active');">{$APP.LBL_CANCEL_BUTTON_LABEL}</button>
	            <button type="button" class="slds-button slds-button_brand" onclick="run_massedit();">{$APP.LBL_SAVE_BUTTON_TITLE}</button>
	        </footer>
	    </div>
	    <!-- // Modal container -->
	</form>
</section>
<div class="slds-backdrop slds-backdrop_open"></div>
<!-- LDS mass edit modal -->

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

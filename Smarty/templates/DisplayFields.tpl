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

{assign var="fromlink" value=""}
{foreach key=label item=subdata from=$data}
    <!-- Form row -->
    <div class="slds-grid slds-gutters_small" name="tbl{$header|replace:' ':''}Content">
        <div class="slds-col slds-has-flexi-truncate slds-grid">	
	{foreach key=mainlabel item=maindata from=$subdata}
		{if count($maindata)>0}{include file='EditViewUI.tpl'}{/if}
	{/foreach}
		</div>
	</div>
	<!-- // Form row -->
{/foreach}

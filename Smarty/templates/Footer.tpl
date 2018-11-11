<div class="slds-box slds-grid slds-gutters cbds-bg-blue--dark slds-text-color_inverse slds-p-vertical_large">
	<div class="slds-col">
		<span>{$coreBOS_uiapp_name}&nbsp;{$coreBOS_uiapp_version}</span>
		{if ($coreBOS_uiapp_showgitversion || $coreBOS_uiapp_showgitdate)}
		<span>{if $coreBOS_uiapp_showgitversion}{$gitversion}{/if}</span>
		<span>{if $coreBOS_uiapp_showgitdate}{$gitdate}{/if}</span>
		{/if}
	</div>
	<div class="slds-col">
		<span>&copy; 2004 - {date('Y')}</span>
	</div>
	<div class="slds-col">
		<span>{if $$calculate_response_time}Server response time: {$deltaTime}{/if}</span>
	</div>
</div>
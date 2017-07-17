<form action="{""|fn_url}" method="post" class="form-horizontal form-edit  {$hide_inputs}" name="order_files_form_{$id}" enctype="multipart/form-data">
<input type="hidden" name="fake" value="1" />
<input type="hidden" name="selected_section" value="attachments" />
<input type="hidden" name="object_id" value="{$order_id}" />
<input type="hidden" name="attachment_id" value="{$id}" />
<input type="hidden" name="redirect_url" value="{$config.current_url}" />
<input type="hidden" name="attachment_data[description]" value="{$attachment.description}" />

<div class="cm-tabs-content">
    <div id="content_tab_details_{$id}">

        <div class="control-group">
            <label for="type_{"order_files[`$id`]"|md5}" class="control-label {if !$orfile}cm-required{/if}">{__("file")}</label>
            <div class="controls">
			    {if $orfile.filename}
                    <div class="text-type-value">
                        <a href="{"sd_file_loader_for_orders.getfile?file_id=`$orfile.file_id`"|fn_url}">{$orfile.filename}</a> ({$orfile.filesize|formatfilesize nofilter})
                    </div>
                {/if}
                {include file="common/fileuploader.tpl" var_name="order_files[`$id`]"}</div>
        </div>
    </div>
</div>
{if !$no_edit}
<div class="buttons-container">
    {if $orfile.file_id}
        {assign var="id" value=$orfile.file_id}    
    {else}
        {assign var="id" value="0"}
    {/if}
	
    {if $id}
        {assign var="hide_first_button" value=$hide_inputs}
    {/if}
	
    {include file="buttons/save_cancel.tpl" but_name="dispatch[sd_file_loader_for_orders.update]" cancel_action="close" hide_first_button=$hide_first_button save=$id}
</div>
{/if}
</form>

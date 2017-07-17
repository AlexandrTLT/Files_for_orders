{if "ULTIMATE"|fn_allowed_for}
    {if ($runtime.company_id && $product_data.shared_product == "Y" && $product_data.company_id != $runtime.company_id)}
        {assign var="hide_for_vendor" value=true}
        {assign var="skip_delete" value=true}
        {assign var="hide_inputs" value="cm-hide-inputs"}
        {assign var="edit_link_text" value=__("view")}
    {/if}
{/if}

{assign var="redirect_url" value=$config.current_url|escape:url}

<div class="items-container cm-sortable" data-ca-sortable-table="files" data-ca-sortable-id-name="file_id" id="files_list">

{if $files}
    <table class="table table-middle table-objects">
    {foreach from=$files item="a"}
        {capture name="object_group"}
            {include file="addons/sd_file_loader_for_orders/views/orders/update.tpl" orfile=$a order_id=$order_id hide_inputs=$hide_inputs}
        {/capture}
        {include file="addons/sd_file_loader_for_orders/views/orders/filelist.tpl"
		content=$smarty.capture.object_group id=$a.file_id table="files" 
		href_delete="sd_file_loader_for_orders.delete?file_id=`$a.file_id`&order_id=`$a.order_id`&filename=`$a.filename`&redirect_url=`$redirect_url`" 
		delete_target_id="files_list" additional_class="cm-sortable-row cm-sortable-id-`$a.file_id`" id_prefix="_files_"
		prefix="files" hide_for_vendor=$hide_for_vendor skip_delete=$skip_delete no_table="true" link_text=$edit_link_text
		text=$a.filename flink="sd_file_loader_for_orders.getfile?file_id=`$a.file_id`"}
    {/foreach}
    </table>
{else}
    <p>{__("no_data")}</p>
{/if}

</div>
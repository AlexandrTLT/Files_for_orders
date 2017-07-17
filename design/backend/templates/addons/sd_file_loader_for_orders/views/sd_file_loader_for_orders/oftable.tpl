{capture name="mainbox"}

{if $runtime.mode == "new"}
    <p>{__("text_admin_new_orders")}</p>
{/if}

<form action="{""|fn_url}" method="post" target="_self" name="orders_list_form">

{include file="common/pagination.tpl" save_current_page=true save_current_url=true div_id=$smarty.request.content_id}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

{assign var="rev" value=$smarty.request.content_id|default:"pagination_contents"}


{assign var="page_title" value=__("oftable")}
{assign var="get_additional_statuses" value=false}

{assign var="order_status_descr" value=$smarty.const.STATUSES_ORDER|fn_get_simple_statuses:$get_additional_statuses:true}
{assign var="extra_status" value=$config.current_url|escape:"url"}
{$statuses = []}
{assign var="order_statuses" value=$smarty.const.STATUSES_ORDER|fn_get_statuses:$statuses:$get_additional_statuses:true}

{if $orders}
<table width="100%" class="table table-middle">
<thead>
<tr>
    <th  class="left">
    </th>
    <th width="50%">{__("id")}</a></th>
	<th width="50%">{__("file")}</a></th>

</tr>
</thead>
{foreach from=$orders item="o"}

<tr>
    <td class="left">
        </td>
    <td>
        <a href="{"orders.details?order_id=`$o.order_id`"|fn_url}" class="underlined">{__("order")} #{$o.order_id}</a>
        {if $order_statuses[$o.status].params.appearance_type == "I" && $o.invoice_id}
            <p class="muted">{__("invoice")} #{$o.invoice_id}</p>
        {elseif $order_statuses[$o.status].params.appearance_type == "C" && $o.credit_memo_id}
            <p class="muted">{__("credit_memo")} #{$o.credit_memo_id}</p>
        {/if}
        {include file="views/companies/components/company_name.tpl" object=$o}
    </td>
    <td>
        <a href="{"sd_file_loader_for_orders.getfile?file_id=`$o.file_id`"|fn_url}">{$o.filename}</a> ({$o.filesize|formatfilesize nofilter})
    </td>
</tr>

{/foreach}
</table>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl" div_id=$smarty.request.content_id}

</form>
{/capture}

{include file="common/mainbox.tpl" title=$page_title sidebar=$smarty.capture.sidebar content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons content_id="manage_orders"}

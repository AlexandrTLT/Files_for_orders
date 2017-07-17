{assign var="ordfiles" value=$files.{$o.order_id}}
<td class="ty-orders-search__item">
{foreach from=$ordfiles item="f"}
    <a href="{"sd_file_loader_for_orders.getfile?file_id=`$f.file_id`"|fn_url}">{$f.filename}</a>
	({$f.filesize|formatfilesize nofilter})<p></p> 
{/foreach}</td>
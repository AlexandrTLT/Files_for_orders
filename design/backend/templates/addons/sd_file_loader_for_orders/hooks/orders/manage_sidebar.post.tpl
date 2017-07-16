<div class="sidebar-row">
<h6>{__("filters")}</h6>
<ul class="nav nav-list">
<li {if $filter_ordfile_active} class="active" {/if}>
<a class="cm-view-name" data-ca-view-id="1" href="{"sd_file_loader_for_orders.getforders?file_id=`$file_id`"|fn_url}">{__("filter_orderfiles")}</a>
</li>
</ul>
</div>

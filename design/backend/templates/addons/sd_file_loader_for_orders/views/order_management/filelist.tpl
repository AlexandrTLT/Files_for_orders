<table width="100%" class="table table-middle table-objects{if $table_striped} table-striped{/if}">
    <tbody>
        <tr class="cm-row-status-{$status|lower} {$additional_class} cm-row-item" {if $row_id}id="{$row_id}"{/if} data-ct-{$table}="{$id}">
		 <td width="1%" class="no-padding-td">
                    <span class="handler cm-sortable-handle"></span>
            </td>

            <td width="{if $href_desc}77{else}28{/if}%">
                <div class="object-group-link-wrap">
                <a class="row-status {if !$main_link}cm-external-click{/if}{if $non_editable} no-underline{/if}{if $main_link} link{/if} {$link_meta}{if $is_promo}cm-promo-popup{/if}"
				{if $flink} {if !$is_promo}href="{$flink|fn_url}{/if}"{/if}>{$text}</a>
                </div>
            </td>
            <td width="{if $href_desc}0{else}50{/if}%">
                <span class="row-status object-group-details">{$details nofilter}</span>
            </td>

            {if $extra_data}
                {$extra_data nofilter}
            {/if}

            <td width="22%" class="right nowrap">
                {if !$no_edit}
                <div class="pull-right hidden-tools">
                    {capture name="items_tools"}
                    {if $tool_items}
                        {$tool_items nofilter}
                    {/if}

                        {if !$non_editable}
                            {if $href_delete && !$skip_delete}
                                {if $is_promo}
                                    {$class="cm-promo-popup"}
                                {else}
                                    {$class="cm-delete-row"}
                                    {$href=$href_delete}
                                {/if}
                                <li>{btn type="text" text=__("delete") href=$href class="cm-confirm cm-tooltip cm-ajax cm-ajax-force cm-ajax-full-render `$class`" data=["data-ca-target-id" => $delete_target_id, "data-ca-params" => $delete_data] method="POST"}</li>
                            {/if}
                        {/if}
                    {/capture}
                    {dropdown content=$smarty.capture.items_tools class="dropleft"}
                </div>
				{/if}
                {$links nofilter}
            </td>
            
        </tr>
    </tbody>
</table>

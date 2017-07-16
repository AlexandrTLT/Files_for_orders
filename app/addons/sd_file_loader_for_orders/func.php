<?php
/***************************************************************************
*                                                                          *
*   (c) 2004 Vladimir V. Kalynyak, Alexey V. Vinokurov, Ilya M. Shalnev    *
*                                                                          *
* This  is  commercial  software,  only  users  who have purchased a valid *
* license  and  accept  to the terms of the  License Agreement can install *
* and use this program.                                                    *
*                                                                          *
****************************************************************************
* PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
* "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
****************************************************************************/

use Tygh\Storage;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

function fn_add_orderfiles($file_data, $file_id, $order_id, $files = null)
{
    $directory = 'orders/' . $order_id;

    if ($files != null) {
        $uploaded_data = $files;
    } else {
        $uploaded_data = fn_filter_uploaded_data('order_files');
    }

    if (!empty($file_data)) {
        $rec = array (
            'file_id' => $file_id,
			'order_id' => $order_id
        );

        $file_id = db_query("INSERT INTO ?:order_files ?e", $rec);

        $uploaded_data[$file_id] = $uploaded_data[0];
        unset($uploaded_data[0]);

    }

    if (isset($file_id) && !empty($uploaded_data[$file_id]) && isset($uploaded_data[$file_id]['size'])) {
        $filename = $uploaded_data[$file_id]['name'];

        list($filesize, $filename) = Storage::instance('order_files')->put($directory . '/' . $filename, array(
            'file' => $uploaded_data[$file_id]['path']
        ));

        if (isset($filesize)) {
            $filename = fn_basename($filename);
            db_query("UPDATE ?:order_files SET filename = ?s, filesize = ?i WHERE file_id = ?i", $filename, $filesize, $file_id);
        }
    }

    return $file_id;
}

function fn_get_orderfiles($order_id)
{

    return db_get_array("SELECT * FROM ?:order_files WHERE order_id = ?i ORDER BY file_id", $order_id);
}

function fn_get_orderfile($file_id)
{
    $data = db_get_row("SELECT * FROM ?:order_files WHERE file_id = ?i", $file_id);
	
    if (empty($data)) {
        return false;
    }

    $attachment_obj = Storage::instance('order_files');
    $attachment_filename = 'orders/' . $data['order_id'] . '/' . $data['filename'];

    if (!$attachment_obj->isExist($attachment_filename)) {
        return false;
    }

    $attachment_obj->get($attachment_filename);

    exit;
}

function fn_delete_orderfile($file_id, $order_id, $filename)
{
    $data = db_get_array("SELECT * FROM ?:order_files WHERE file_id = ?i", $file_id);

    Storage::instance('order_files')->delete('orders/' . $order_id . '/' . $filename);

    db_query("DELETE FROM ?:order_files WHERE file_id = ?i", $file_id);

    return true;
}
?>

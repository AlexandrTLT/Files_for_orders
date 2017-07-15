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
?>

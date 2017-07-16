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

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if ($mode == 'update' || $mode == 'add') {
        if (isset($_REQUEST['attachment_data'])) {
            fn_add_orderfiles($_REQUEST['attachment_data'], $_REQUEST['attachment_id'], $_REQUEST['object_id'], null);
        }
    }
	elseif ($mode == 'delete') {
        fn_delete_orderfile($_REQUEST['file_id'], $_REQUEST['order_id'], $_REQUEST['filename']);

        exit;
    }

    return array(CONTROLLER_STATUS_OK);
}

if ($mode == 'update' || $mode == 'add') {
	$order_files = fn_get_orderfiles($_REQUEST['order_id']);

    Registry::set('navigation.tabs.attachments', array (
        'title' => __('attachments'),
        'js' => true
    ));

    Tygh::$app['view']->assign('attachments', $order_files);
}
elseif ($mode == 'getfile') {
    if (!empty($_REQUEST['file_id'])) {
        fn_get_orderfile($_REQUEST['file_id']);
    }
    exit;
}
?>
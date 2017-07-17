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
    return;
}

if ($mode == 'details') {
	$order_id = $_REQUEST['order_id'];
    $order_files = fn_get_orderfiles($order_id);

    Registry::set('navigation.tabs.files', array (
        'title' => __('files'),
        'js' => true
    ));

    Tygh::$app['view']->assign('files', $order_files);
}elseif ($mode == 'search') {
	$orders = Registry::get('view')->getTemplateVars('orders');
	$ord_files = array();
	
	$a = 0;
    foreach($orders as $ord){
		$ofile = fn_get_orderfiles($ord['order_id']);
		if($ofile!=false){
		    $ord_files[$ord['order_id']] = $ofile;
			$a++;
		}
	}
	
    Registry::set('navigation.tabs.files', array (
        'title' => __('files'),
        'js' => true
    ));

    Tygh::$app['view']->assign('files', $ord_files);
}
?>
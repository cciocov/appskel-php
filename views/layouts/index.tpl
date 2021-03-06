<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>{block name='title'}{/block}</title>
<meta name="description" content="{block name='meta_description'}{/block}">
<meta name="keywords" content="{block name='meta_keywords'}{/block}">

<link type="text/css" href="{$BASE}/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link type="text/css" href="{$BASE}/css/common.css" rel="stylesheet">
{block name='head'}{/block}
<script type="text/javascript" src="{$BASE}/lib/less/less.min.js"></script>
</head>
<body>
{block name='content'}{/block}

<script type="text/javascript" src="{$BASE}/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="{$BASE}/lib/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var FRWK = {
		'BASE': '{$BASE}'
	};
</script>
{block name='foot'}{/block}
</body>
</html>

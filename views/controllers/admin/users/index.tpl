{extends 'layouts/admin.tpl'}
{block name='head' append}
<link type="text/css" href="{$BASE}/lib/datatables_custom/datatables.css" rel="stylesheet">
{/block}
{block name='content'}
<div class="container">
	<h1>{'Users'|i18n}</h1>
	<p class="lead">
		{'Manage application users.'|i18n}
	</p>
	<br>
	{flash}
	<form action="{href action='delete'}" method="post">
		<table id="t1" class="table table-striped x-datatables">
			<thead>
				<tr>
					<th width="10"><input type="checkbox"></th>
					<th>{'E-mail'|i18n}</th>
					<th>{'Username'|i18n}</th>
					<th>{'Status'|i18n}</th>
					<th width="120">{'Created on'|i18n}</th>
				</tr>
			</thead>
			<tbody>
				<tr><td colspan="5">&nbsp;</td></tr>
			</tbody>
		</table>
		<button type="submit" class="btn btn-danger">{'Delete Selected'|i18n}</button>
		<a href="{href action='create'}" class="btn btn-primary">{'Create'|i18n}</a>
	</form>
</div>
{/block}
{block name='foot' append}
<script type="text/javascript" src="{$BASE}/lib/datejs/date.js"></script>
<script type="text/javascript">
	var update_url = "{href action='update'}";
	var profile_url = "{href module='' controller='profile'}";
	var user_id = "{$SESSION.user_info.id}";
	var status_opt = {$status_opt_json};
	var dtcfg = {
		't1': {
			'bProcessing': true,
			'bServerSide': true,
			'sAjaxSource': "{href action='datatables'}",
			'aoColumns': [
				{
					'mData': 'id',
					'mRender': function(data, type, row) {
						return '<input type="checkbox" name="ids[]" value="' + data + '">';
					}
				},
				{
					'mData': 'email',
					'mRender': function(data, type, row) {
						var url = (row.id == user_id ? profile_url : update_url + '?id=' + row.id);
						return [
							'<a href="' + url + '">' + data + '</a>',
							'<br>',
							row.first_name + ' ' + row.last_name
						].join('');
					}
				},
				{
					'mData': 'username'
				},
				{
					'mData': 'status',
					'mRender': function(data, type, row) {
						return status_opt[data];
					}
				},
				{
					'mData': 'created_on',
					'mRender': function(data, type, row) {
						return (new Date(parseInt(data) * 1000)).toString('MMM d, yyyy');
					}
				}
			]
		}
	};
</script>
{include file='partials/datatables.tpl'}
{/block}

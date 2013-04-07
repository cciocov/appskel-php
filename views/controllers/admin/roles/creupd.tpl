{extends 'layouts/admin.tpl'}
{block name='head' append}
<link type="text/css" href="{$BASE}/css/permissions.css" rel="stylesheet">
{/block}
{block name='content'}
<div class="container">
	{if $id gt 0}
		<h1>{'Update Role'|i18n} - {$name}</h1>
	{else}
		<h1>{'Create Role'|i18n}</h1>
	{/if}
	<p class="lead">
		{''|i18n}
	</p>
	<br>
	<form id="creupd" method="post" class="form-horizontal" data-frwk-validation="role_model::default" {if $id gt 0}data-frwk-mode="upd"{/if}>
		<input type="hidden" name="mode" value="creupd">
		<fieldset>
			<div class="control-group">
				<label for="name" class="control-label">{'Name'|i18n}</label>
				<div class="controls">
					<input type="text" id="name" name="name" value="{$name}" maxlength="32">
				</div>
			</div>
			<div class="control-group">
				<label for="description" class="control-label">{'Description'|i18n}</label>
				<div class="controls">
					<textarea id="description" name="description" data-maxlength="255">{$description}</textarea>
					<p class="help-block">
						<small><span id="description_chars_remaining"></span> {'chars remaining'|i18n}</small>
					</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">{'Permissions'|i18n}</label>
				<div class="controls">
					{include file='partials/permissions.tpl'}
				</div>
			</div>
			<div class="form-actions">
				<button type="submit" class="btn btn-primary">{'Save Changes'|i18n}</button>
				<a href="{href}" class="btn">{'Cancel'|i18n}</a>
			</div>
		</fieldset>
	</form>
</div>
{/block}
{block name='foot' append}
<script type="text/javascript" src="{$BASE}/lib/frwk/js/forms.js"></script>
<script type="text/javascript" src="{$BASE}/lib/frwk/js/maxlength.js"></script>
<script type="text/javascript" src="{$BASE}/js/permissions.js"></script>
{show_errors form='creupd' errors=$errors}
{/block}

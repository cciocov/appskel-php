{extends 'layouts/admin.tpl'}
{block name='content'}
<div class="container">
	{if $id gt 0}
		<h1>{'Update User'|i18n} - {$name}</h1>
	{else}
		<h1>{'Create User'|i18n}</h1>
	{/if}
	<p class="lead">
		{''|i18n}
	</p>
	<br>
	<form id="creupd" method="post" class="form-horizontal" autocomplete="off" data-frwk-validation="user_model::default" data-frwk-submitfn="creupd" {if $id gt 0}data-frwk-mode="upd"{/if}>
		<input type="hidden" name="mode" value="creupd">
		<fieldset>
			<div class="control-group">
				<label for="status" class="control-label">{'Status'|i18n}</label>
				<div class="controls">
					<select id="status" name="status">
						{html_options options=$status_opt selected=$status}
					</select>
				</div>
			</div>
			<div class="control-group">
				<label for="username" class="control-label">{'Username'|i18n}</label>
				<div class="controls">
					<input type="text" id="username" name="username" value="{$username}" maxlength="32">
				</div>
			</div>
			<div class="control-group">
				<label for="first_name" class="control-label">{'First name'|i18n}</label>
				<div class="controls">
					<input type="text" id="first_name" name="first_name" value="{$first_name}" maxlength="32">
				</div>
			</div>
			<div class="control-group">
				<label for="last_name" class="control-label">{'Last name'|i18n}</label>
				<div class="controls">
					<input type="text" id="last_name" name="last_name" value="{$last_name}" maxlength="32">
				</div>
			</div>
			<div class="control-group">
				<label for="email" class="control-label">{'E-mail'|i18n}</label>
				<div class="controls">
					<input type="email" id="email" name="email" value="{$email}" maxlength="64">
				</div>
			</div>
			<div class="control-group">
				<label for="password" class="control-label">{if $id gt 0}{'New password'|i18n}{else}{'Password'|i18n}{/if}</label>
				<div class="controls">
					<input type="password" id="password" name="password" value="" maxlength="32">
				</div>
			</div>
			<div class="control-group">
				<label for="password_retype" class="control-label">{if $id gt 0}{'Retype new password'|i18n}{else}{'Retype password'|i18n}{/if}</label>
				<div class="controls">
					<input type="password" id="password_retype" name="password_retype" value="" maxlength="32">
				</div>
			</div>
			{if $SESSION.user_info.root_access eq '1'}
			<div class="control-group">
				<label for="root_access" class="control-label">{'Root access'|i18n}</label>
				<div class="controls">
					<label class="checkbox">
						<input type="checkbox" id="root_access" name="root_access" value="1" {if $root_access eq '1'}checked{/if}>
						- {'Grant unlimited access to the entire application'|i18n}
					</label>
				</div>
			</div>
			{/if}
			<div class="control-group">
				<label for="roles" class="control-label">{'Roles'|i18n}</label>
				<div class="controls">
					<select name="roles[]" multiple="true">
						{html_options options=$roles_opt selected=$roles}
					</select>
					<p class="help-block">
						<small>{'Press CTRL to select multiple items from the list.'|i18n}</small>
					</p>
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
<script type="text/javascript">
	function creupd($form) {
		if ($('#password').val() != $('#password_retype').val()) {
			FRWK.Forms.show_errors($form[0], {
				'password_retype': {
					'custom': "{'Passwords don\'t match.'|i18n}"
				}
			});
			return false;
		}

		return true;
	}
</script>
{show_errors form='creupd' errors=$errors}
{/block}

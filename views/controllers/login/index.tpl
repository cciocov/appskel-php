{extends 'layouts/index.tpl'}
{block name='content'}
<form id="login" method="post" action="{href}" class="well page_centered" data-frwk-validation="login">
	{if $failed}
	<div class="alert alert-error">{'Wrong e-mail/password combination.'|i18n}</div>
	{/if}
	<div class="control-group">
		<label for="email" class="control-label">{'E-mail'|i18n}:</label>
		<div class="controls">
			<input type="email" id="email" name="email" value="{$email}" class="span4">
		</div>
	</div>
	<div class="control-group">
		<label for="password" class="control-label">{'Password'|i18n}:</label>
		<div class="controls">
			<input type="password" id="password" name="password" value="{$password}" class="span4">
		</div>
	</div>
	<label class="checkbox">
		<input type="checkbox" id="remember_me" name="remember_me" value="Y">
		{'Remember me'|i18n}
	</label>
	<br>
	<input type="submit" value="{'Login'|i18n}" class="btn btn-primary">
	<a href="{href controller='register'}" class="btn btn-link">{'Register'|i18n}</a>
	|
	<a href="{href action='forgot-password'}" class="btn btn-link">{'Forgot password?'|i18n}</a>
</form>
{/block}
{block name='foot' append}
<script type="text/javascript" src="{$BASE}/lib/frwk/js/forms.js"></script>
{/block}

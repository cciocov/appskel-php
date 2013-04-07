{extends 'layouts/index.tpl'}
{block name='content'}
{if $success}
<form id="reset_password" method="post" action="" class="well page_centered" data-frwk-validation="reset_password" data-frwk-submitfn="reset_password">
	<div class="alert alert-error hide x-form_errors"></div>
	<div class="control-group">
		<label for="password" class="control-label">{'New password'|i18n}:</label>
		<div class="controls">
			<input type="password" id="password" name="password" class="span4" maxlength="32">
		</div>
	</div>
	<div class="control-group">
		<label for="password_retype" class="control-label">{'Retype password'|i18n}:</label>
		<div class="controls">
			<input type="password" id="password_retype" name="password_retype" class="span4" maxlength="32">
		</div>
	</div>
	<input type="submit" value="{'Reset'|i18n}" class="btn btn-primary">
</form>
{else}
<div class="alert alert-block alert-error page_centered">
	<h4>{'Error'|i18n}</h4>
	<br>
	<p>{'Something went wrong. The link you are trying to access may be broken or expired. For any assistance please contact our support.'|i18n}</p>
	<br>
	<a href="mailto: {$CFG.SUPPORT_EMAIL}" class="btn btn-danger">{'Contact Support'|i18n}</a>
</div>
{/if}
{/block}
{block name='foot' append}
{if $success}
<script type="text/javascript" src="{$BASE}/lib/frwk/js/forms.js"></script>
<script type="text/javascript">
	function reset_password($form) {
		if ($('#password').val() != $('#password_retype').val()) {
			FRWK.Forms.show_errors($form[0], {
				'password_retype': {
					'custom': 'Passwords don\'t match.'
				}
			});
			return false;
		}

		return true;
	}
</script>
{show_errors form='reset_password' errors=$errors}
{/if}
{/block}

{extends 'layouts/front.tpl'}
{block name='content'}
<div class="container">
	<h1>{'Edit Profile'|i18n}</h1>
	<p class="lead">
		{'Change your profile information below.'|i18n}
	</p>
	<br>
	{flash}
	<div class="row">
		<div class="pull-left span6">
			<form id="profile" method="post" action="{href}" autocomplete="off" data-frwk-validation="user_model::default" data-frwk-mode="upd">
				<div class="alert alert-error hide x-form_errors"></div>
				<div class="control-group">
					<label for="username" class="control-label">{'Username'|i18n}:</label>
					<div class="controls">
						<input type="text" id="username" name="username" value="{$username}" class="span3" maxlength="32">
					</div>
				</div>
				<div class="control-group">
					<label for="first_name" class="control-label">{'First name'|i18n}:</label>
					<div class="controls">
						<input type="text" id="first_name" name="first_name" value="{$first_name}" class="span3" maxlength="32">
					</div>
				</div>
				<div class="control-group">
					<label for="last_name" class="control-label">{'Last name'|i18n}:</label>
					<div class="controls">
						<input type="text" id="last_name" name="last_name" value="{$last_name}" class="span3" maxlength="32">
					</div>
				</div>
				<input type="submit" value="{'Save'|i18n}" class="btn btn-primary">
				<span class="hide x-state x-state_loading">
					<img src="{$BASE}/img/ajax-loader.gif">
					{'Please wait...'|i18n}
				</span>
				<span class="hide x-state x-state_success">
					<i class="icon-ok"></i>
					{'Saved!'|i18n}
				</span>
			</form>
		</div>
		<div class="pull-left span6">
			<div class="well">
				{'E-mail'|i18n}: <b>{$email}</b> <span id="change_email">(<a href="javascript:;">{'Change'|i18n}</a>)</span>
				<div class="hide">
					<br>
					<p>{'Enter your new e-mail address below. Your current e-mail will be changed once you confirm the new one.'|i18n}</p>
					<form id="change_email" method="post" action="{href action='change-email'}" autocomplete="off" data-frwk-validation="change_email" data-frwk-ajaxsubmit="true">
						<div class="control-group">
							<div class="controls">
								<input type="email" id="email" name="email" value="" class="span5" maxlength="64">
							</div>
						</div>
						<input type="submit" value="{'Change'|i18n}" class="btn btn-primary">
						<span class="hide x-state x-state_loading">
							<img src="{$BASE}/img/ajax-loader.gif">
							{'Please wait...'|i18n}
						</span>
						<span class="hide x-state x-state_success">
							<i class="icon-ok"></i>
							{'E-mail sent, please check your inbox.'|i18n}
						</span>
					</form>
				</div>
			</div>
			<div class="well">
				<a href="javascript:;" id="change_password">{'Change Password'|i18n}</a>
				<div class="hide">
					<br>
					<form id="change_password" method="post" action="{href action='change-password'}" autocomplete="off" data-frwk-validation="change_password" data-frwk-submitfn="change_password">
						<div class="control-group">
							<label for="current_password" class="control-label">{'Current password'|i18n}:</label>
							<div class="controls">
								<input type="password" id="current_password" name="current_password" class="span3" maxlength="32">
							</div>
						</div>
						<div class="control-group">
							<label for="password" class="control-label">{'New password'|i18n}:</label>
							<div class="controls">
								<input type="password" id="password" name="password" class="span3" maxlength="32">
							</div>
						</div>
						<div class="control-group">
							<label for="password_retype" class="control-label">{'Retype new password'|i18n}:</label>
							<div class="controls">
								<input type="password" id="password_retype" name="password_retype" class="span3" maxlength="32">
							</div>
						</div>
						<input type="submit" value="{'Change'|i18n}" class="btn btn-primary">
						<span class="hide x-state x-state_loading">
							<img src="{$BASE}/img/ajax-loader.gif">
							{'Please wait...'|i18n}
						</span>
						<span class="hide x-state x-state_success">
							<i class="icon-ok"></i>
							{'Password changed successfully!'|i18n}
						</span>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
{/block}
{block name='foot' append}
<script type="text/javascript" src="{$BASE}/lib/frwk/js/forms.js"></script>
<script type="text/javascript">
	$(function() {
		$('#change_email').click(function(e) {
			var $el = $(this);
			$el.hide().siblings('div').slideDown('fast');
			$('#email').focus();
		});

		$('#change_password').click(function(e) {
			var $el = $(this);
			$el.siblings('div').slideToggle('fast', function() {
				if ($(this).hasClass('hide')) {
					$('#current_password').focus();
				}
			});
		});
	});

	function change_password() {
		if ($('#password').val() != $('#password_retype').val()) {
			FRWK.Forms.show_errors(this, {
				'password_retype': {
					'custom': "{'Passwords don\'t match.'|i18n}"
				}
			});
			return false;
		}

		FRWK.Forms.ajax_submit(this, function(json) {
			if (json.ok) {
				$(this).find('input[type=password]').val('');
			}
		});

		return false;
	}
</script>
{show_errors form='profile' errors=$errors}
{/block}

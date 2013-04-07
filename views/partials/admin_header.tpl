<div class="navbar navbar-static-top">
	<div class="navbar-inner">
		<div class="container">
			<a class="brand" href="{href module='admin'}">{'AppSkel Admin'|i18n}</a>
			<ul class="nav">
				<li id="topnav_dashboard"><a href="{href controller='dashboard'}">{'Dashboard'|i18n}</a></li>
				<li id="topnav_manage" class="dropdown">
					<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">{'Manage'|i18n} <b class="caret"></b></a>
					<ul class="dropdown-menu">
						{if 'manage_roles,manage_users'|p_any}
							<li class="divider"></li>
							{if 'manage_roles'|p_all}
							<li><a href="{href controller='roles'}">{'Roles'|i18n}</a></li>
							{/if}
							{if 'manage_users'|p_all}
							<li><a href="{href controller='users'}">{'Users'|i18n}</a></li>
							{/if}
						{/if}
					</ul>
				</li>
			</ul>
			<ul class="nav pull-right">
				<li id="topnav_user" class="dropdown">
					<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">{$SESSION.user_info.name} <b class="caret"></b></a>
					<ul class="dropdown-menu" style="text-align: right;">
						<li><a href="{href module='' controller='profile'}">{'Edit Profile'|i18n}</a></li>
						<li><a href="{href module='' controller='logout'}">{'Logout'|i18n}</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>

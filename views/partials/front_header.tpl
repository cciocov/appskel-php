<div class="navbar navbar-static-top">
	<div class="navbar-inner">
		<div class="container">
			<a class="brand" href="{$BASE}/">{'AppSkel'|i18n}</a>
			<ul class="nav">
				<li id="topnav_dashboard"><a href="{href controller='dashboard'}">{'Dashboard'|i18n}</a></li>
			</ul>
			<ul class="nav pull-right">
				{if $CFG.P_ADMIN|p_any}
				<li><a href="{href module='admin'}">{'Admin'|i18n}</a></li>
				{/if}
				<li id="topnav_user" class="dropdown">
					<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">{$SESSION.user_info.name} <b class="caret"></b></a>
					<ul class="dropdown-menu" style="text-align: right;">
						<li><a href="{href controller='profile'}">{'Edit Profile'|i18n}</a></li>
						<li><a href="{href controller='logout'}">{'Logout'|i18n}</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>

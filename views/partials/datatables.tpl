<script type="text/javascript" src="{$BASE}/lib/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="{$BASE}/lib/datatables_custom/datatables.js"></script>
<script type="text/javascript">
	$(function() {
		var $instances = $('table.x-datatables');

		// initialize:
		$instances.each(function() {
			var $el = $(this);
			var id = $el.attr('id');

			var cfg = $.extend(true, {
				'sDom': "<'row'<'span6'f><'span6'l>r>t<'row'<'span6'i><'span6'p>>",
				'sPaginationType': 'bootstrap',
				
				'oLanguage': {
					'sLengthMenu': "_MENU_ {'records'|i18n}",
					'sZeroRecords': "{'No data available'|i18n}",

					'sSearch': [
						'<a href="javascript:;" class="btn btn-danger">{"Delete Selected"|i18n}</a>',
						'<a href="{href action="create"}" class="btn btn-primary">{"Create"|i18n}</a>',
						'<div class="input-prepend"><span class="add-on"><i class="icon-search"></i></span>_INPUT_</div>'
					].join(' ')
				},

				'aoColumnDefs': [
					{ 'aTargets': [0], 'bSortable': false }
				],

				// disable initial sorting:
				'aaSorting': [],

				// by default, don't save state:
				'bStateSave': false,

				'fnDrawCallback': function() {
					$el.find('input [type=checkbox]').prop('checked', false);
				}
			}, (id && typeof(dtcfg) != 'undefined' && dtcfg[id] ? dtcfg[id] : {}));

			if (cfg['bServerSide']) {
				$el.dataTable(cfg).fnSetFilteringDelay(450);
			}
			else {
				$el.dataTable(cfg);
			}
		});

		$instances.find('thead input[type=checkbox]').click(function(e) {
			var $el = $(this);
			$el.closest('table').find('tbody input[type=checkbox]').prop('checked', $el.prop('checked'));
		});
		$instances.on('click', 'input[type=checkbox]', function(e) {
			var $el = $(e.target);
			if (!$el.prop('checked')) {
				$el.closest('table').find('thead input[type=checkbox]').prop('checked', false);
			}
		});

		$instances.closest('form').find('.btn-danger').click(function(e) {
			if (confirm("{'Are you sure you want to delete selected records?'|i18n}")) {
				$(e.target).closest('form').submit();
			}
		});
	});
</script>

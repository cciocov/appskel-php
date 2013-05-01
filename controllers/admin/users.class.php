<?php
/**
 * users controller
 *
 ******************************************************************************/

class users_controller extends admin_controller {
	/**
	 * Controller attributes.
	 * @var array
	 */
	protected $attr = array(
	);

	/**
	 * Associated model.
	 * @var object
	 */
	public $model = null;


	/**
	 * Init.
	 */
	public function init() {
		parent::init();
		auth::require_permissions(array(
			'all' => array('manage_users')
		));

		$this->model = new user_model();

		$this->set('topnav', 'manage');
	}

	//////////////////////////////////////////////////////////////////////////////
	//
	// Actions
	//
	//////////////////////////////////////////////////////////////////////////////

	/**
	 * Implement basic CRUD operations.
	 */

	public function action_index() {
		$this->set('status_opt_json', json_encode(user_model::status_opt()));
	}

	public function action_create() {
		return $this->creupd();
	}

	public function action_update() {
		return $this->creupd();
	}

	public function action_delete() {
		$ids = $this->params->ids;
		if (is_array($ids) && count($ids) > 0) {
			$n = 0;
			foreach ($ids as $id) {
				$this->model->load($id);
				if (!$this->model->exists() || !$this->model->access_allowed()) {
					continue;
				}

				if ($this->model->delete()) {
					$n++;
				}
			}

			if ($n) {
				$this->session()->flash(_("Successfully deleted $n record(s)."));
			}
		}

		$this->redirect();
	}

	/**
	 * Datatables AJAX source (for large data sets).
	 */
	public function action_datatables_ajax() {
		return $this->model->datatables(array(
			// table columns:
			'cols' => array('id', 'email', 'username', 'status', 'created_on'),
			// searchable columns:
			'search_cols' => array('email', 'username', 'first_name', 'last_name')
		));
	}

	//////////////////////////////////////////////////////////////////////////////
	//
	// Private Methods
	//
	//////////////////////////////////////////////////////////////////////////////

	/**
	 * Create/Update.
	 */
	private function creupd() {
		$this->view = 'creupd';
		$id = $this->params->get('id', 0);
		$this->model->load($id);
		$item = array();

		if ($id > 0) {
			if (!$this->model->exists() || !$this->model->access_allowed()) {
				return response::access_denied();
			}
		}

		$user_info = $this->session()->user_info;

		if ($this->req->is('post')) {
			if ($this->params->mode == 'creupd') {
				$data = $this->params->all();

				if ($user_info['root_access'] == 1) {
					$data['root_access'] = ($this->params->root_access == 1 ? 1 : 0);
				}
				else {
					unset($data['root_access']);
				}

				if ($this->model->save($data)) {
					$this->model->set_roles($this->params->roles);

					$this->session()->flash(_('Data saved successfully.'));
					
					if ($this->req->is('ajax')) {
						return response::ajax_success($this->model->get());
					}
					$this->redirect();
				}
				
				// get model errors:
				$errors = $this->model->get_errors();

				if ($this->req->is('ajax')) {
					return response::ajax_error($errors);
				}

				$this->set('errors', $errors);
			}
		}

		if ($id > 0) {
			$item = $this->model->get();
			$this->set($item);
			$this->set('roles', $this->model->get_roles());
		}
		$this->pass();

		// get all roles:
		$role = new role_model();
		$this->set('roles_opt', $role->opt());

		// user statuses:
		$this->set('status_opt', user_model::status_opt());
	}
}

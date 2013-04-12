<?php
/**
 * sample controller
 *
 ******************************************************************************/

class sample_controller extends app_controller {
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

		$this->model = new sample_model();
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
		$this->set('items', $this->model->all());
	}

	public function action_create() {
		return $this->creupd();
	}

	public function action_update() {
		return $this->creupd();
	}

	public function action_delete() {
		if ($this->model->del(array('ids' => $this->params->ids))) {
			$n = $this->model->rows_affected();
			$this->session()->flash(_("Successfully deleted $n record(s)."));
		}
		$this->redirect();
	}

	/**
	 * Datatables AJAX source (for large data sets).
	 */
	//public function action_datatables_ajax() {
	//	return $this->model->datatables(
	//		// table columns:
	//		array('id', 'name', 'created_on'),
	//		// searchable columns:
	//		array('name')
	//	);
	//}

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

		if ($this->req->is('post')) {
			if ($this->params->mode == 'creupd') {
				if ($this->model->save_from_req()) {
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
		}
		$this->pass();
	}
}

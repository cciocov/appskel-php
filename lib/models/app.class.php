<?php
/**
 * app model
 *
 ******************************************************************************/

class app_model extends model {
	/**
	 * Check if a user is allowed to access this instance of the model.
	 */
	public function access_allowed($user_info = null) {
		// no instance loaded, access allowed:
		if (!$this->require_instance()) {
			return true;
		}

		if ($this->user_id || $this->account_id) {
			// make sure we have a user:
			if (is_null($user_info)) {
				$user_info = $this->frwk->session()->user_info;
			}
			if (!is_array($user_info)) {
				return false;
			}

			// model has user access constraints:
			if ($this->user_id) {
				if (!$user_info['root_access']) {
					if ($this->user_id != $user_info['id']) {
						return false;
					}
				}
			}

			// model has account access constraints:
			if ($this->account_id) {
				if (!$user_info['root_access']) {
					if ($this->account_id != $user_info['account_id']) {
						return false;
					}
				}
			}
		}

		// allow access:
		return true;
	}

	/**
	 * Datatables source.
	 */
	public function datatables($cols, $search_cols = array()) {
		$params =& $this->frwk->req->params;
		$data = array();

		// paging:
		$limit_str = '';
		$iDisplayStart = $params->iDisplayStart;
		$iDisplayLength = $params->get('iDisplayLength', '-1');
		if (!is_null($iDisplayStart) && $iDisplayLength != '-1') {
			$limit_str = "LIMIT $iDisplayStart, $iDisplayLength";
		}

		// ordering:
		$order_str = '';
		if ($params->iSortCol_0 !== null) {
			$order_arr = array();
			for ($i = 0; $i < intval($params->iSortingCols); $i++) {
				$col_index = intval($params->get("iSortCol_$i"));
				if ($params->get("bSortable_$col_index") == 'true') {
					$dir = ($params->get("sSortDir_$i") == 'asc' ? 'ASC' : 'DESC');
					$order_arr[] = $cols[$col_index] . ' ' . $dir;
				}
			}
			$order_str = implode(', ', $order_arr);
		}

		// filtering:
		$where_arr = array();

		$sSearch = $params->sSearch;
		if (!empty($sSearch)) {
			$data['search'] = $sSearch;
			$search_arr = array();
			for ($i = 0; $i < count($search_cols); $i++) {
				$search_arr[] = $search_cols[$i] . " LIKE CONCAT('%', :search, '%')";
			}
			if (count($search_arr)) {
				$where_arr[] = '(' . implode(' OR ', $search_arr) . ')';
			}
		}

		$where_str = implode(' AND ', $where_arr);

		// run query:
		$qstr = implode(' ', array(
			"SELECT SQL_CALC_FOUND_ROWS *",
			"FROM " . $this->attr('tb'),
			(!empty($where_str) ? "WHERE $where_str" : ''),
			(!empty($order_str) ? "ORDER BY $order_str" : ''),
			$limit_str
		));

		$results = array(
			'sEcho' => intval($params->sEcho),
			'iTotalRecords' => 0,
			'iTotalDisplayRecords' => 0,
			'aaData' => array()
		);

		$q = $this->query($qstr, $data);
		while (is_array($res = $q->getrow())) {
			$results['aaData'][] = $res;
		}

		// data set length before limit:
		$q = $this->query("SELECT FOUND_ROWS()");
		if (is_array($res = $q->getrow())) {
			$results['iTotalDisplayRecords'] = intval(array_shift($res));
		}

		// total data set length:
		$n = $this->db()->get_fields('COUNT(*)', $this->attr('tb'));
		$results['iTotalRecords'] = intval($n);

		return $results;
	}
}

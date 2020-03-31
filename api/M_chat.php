<?php defined('BASEPATH') OR exit('No direct script access allowed');

require_once(APPPATH . 'models/Parents_Model.php');

class M_chat extends Parents_Model {

    public function __construct() {
        parent::__construct();
        $this->load->model("M_app");
    }

    public function getDisplayUser($schUid, $userUid){
        $this->initDBAPI($schUid);

        $this->db->select('id_siswa_url AS display_id_url,
        siswa_nama AS display_name,
        siswa_foto AS display_foto');
        $this->db->where('id_siswa_url', $userUid);
        $query = $this->db->get('tbl_master_siswa');
        if ($query->num_rows() > 0){
            return $query->row();
        }

        $this->db->select("id_guru_url AS display_id_url, 
        CONCAT_WS(' ',guru_gelar_depan, guru_nama, guru_gelar_belakang) AS display_name,
        guru_foto AS display_foto");
        $this->db->where('id_guru_url', $userUid);
        $query = $this->db->get('tbl_master_guru');
        if ($query->num_rows() > 0){
            return $query->row();
        }

        $this->db->select("o.id_siswa_ortu_url AS display_id_url,
        CONCAT_WS(' ', IFNULL(o.nama_ayah, IFNULL(o.nama_ibu, IFNULL(o.nama_wali, NULL))), CONCAT('Wali(', s.siswa_nama, ')')) AS display_name,
        o.ortu_foto AS display_foto");
        $this->db->from('tbl_siswa_ortu o');
        $this->db->join('tbl_master_siswa s', 'o.id_siswa = s.id_siswa');
        $this->db->where('o.id_siswa_ortu_url', $userUid);
        $query = $this->db->get('tbl_siswa_ortu');
        if ($query->num_rows() > 0){
            return $query->row();
        }
    }

    public function getAvailableTeacher($schUid, $userUid){
        $this->initDBAPI($schUid);
        $this->db->select('g.id_guru_url, c.last_logout, c.status_login, g.guru_nama, 
        g.guru_gelar_depan, g.guru_gelar_belakang, g.guru_foto');
        $this->db->from('tbl_chat_user c');
        $this->db->join('tbl_master_guru g', 'c.id_user_url = g.id_guru_url');
        $this->db->where('c.id_user_url !=', $userUid);
        $sql = $this->db->get();
        return $sql->result_array();
    }

    public function getAvailableStudent($schUid, $userUid){
        $this->initDBAPI($schUid);
        $this->db->select('s.id_siswa_url, c.last_logout, c.status_login, s.siswa_nama, 
        s.siswa_nisn, s.siswa_nis, s.siswa_foto');
        $this->db->from('tbl_chat_user c');
        $this->db->join('tbl_master_siswa s', 'c.id_user_url = s.id_siswa_url');
        $this->db->where('c.id_user_url !=', $userUid);
        $sql = $this->db->get();
        return $sql->result_array();
    }

    public function getAvailableParent($schUid, $userUid){
        $this->initDBAPI($schUid);
        $this->db->select('c.last_logout, c.status_login, o.id_siswa_ortu_url, o.nama_ayah,
        o.nama_ibu, o.nama_wali, o.ortu_foto, s.siswa_nama, s.siswa_nisn, s.siswa_nis');
        $this->db->from('tbl_chat_user c');
        $this->db->join('tbl_siswa_ortu o', 'c.id_user_url = o.id_siswa_ortu_url');
        $this->db->join('tbl_master_siswa s', 'o.id_siswa = s.id_siswa');
        $this->db->where('c.id_user_url !=', $userUid);
        $sql = $this->db->get();
        return $sql->result_array();
    }

    public function getLastSeen($schUid, $userUid){
        $this->initDBAPI($schUid);
        $this->db->select('last_logout AS last_seen, status_login');
        $this->db->where('id_user_url', $userUid);
        $this->db->from('tbl_chat_user');
        $sql = $this->db->get();
        return $sql->row();
    }

    public function insert($schUid, $userUid, $socketId){
        $this->initDBAPI($schUid);
        $data['id_user_url'] = $userUid;
        $data['socket_id'] = $socketId;
        $data['last_logout'] = null;
        $data['status_login'] = 1;

        $sql = $this->db->insert('tbl_chat_user', $data);
        return $sql;
    }

    public function isUserExists($schUid, $userUid){
        $this->initDBAPI($schUid);
        $this->db->where('id_user_url', $userUid);
        $query = $this->db->get('tbl_chat_user');
        if ($query->num_rows() > 0){
            return true;
        }
        else{
            return false;
        }
    }

    public function update($schUid, $userUid, $socketId, $statusLogin){
        $this->initDBAPI($schUid);
        $data['socket_id'] = $socketId;
        $data['status_login'] = $statusLogin;
        if($statusLogin == 0){
            $data['last_logout'] = $this->M_app->datetimeNow();
        }

        $sql = $this->db->update('tbl_chat_user', $data, ['id_user_url' => $userUid]);
        return $sql;
    }
}
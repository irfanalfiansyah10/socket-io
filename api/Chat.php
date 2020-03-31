<?php defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;

class Chat extends REST_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model("M_chat");
        $this->load->model("M_app");
    }

    function display_user_get($schUid, $userUid){
        $proc = $this->M_chat->getDisplayUser($schUid, $userUid);
        if ($proc == TRUE) {
            $this->response([
                'display_name' => $proc->display_name,
                'display_foto' => $proc->display_foto,
                'display_id_url' => $proc->display_id_url,
                'status' => TRUE,
                'message' => 'Pengguna Ditemukan',
            ], REST_Controller::HTTP_OK);
        }
        else {
            $this->response(['status' => FALSE, 'message' => 'Pengguna tidak ditemukan'], 
            REST_Controller::HTTP_OK);
        }
    }

    function last_seen_user_post($schUid, $userUid){
        $proc = $this->M_chat->getLastSeen($schUid, $userUid);
        if ($proc == TRUE) {
            $this->response([
                'last_seen' => $proc->status_login == 1 ? "Online" : $proc->last_seen,
                'status' => TRUE,
                'message' => 'Pengguna Ditemukan',
            ], REST_Controller::HTTP_OK);
        }
        else {
            $this->response(['status' => FALSE, 'message' => 'Pengguna tidak ditemukan'], 
            REST_Controller::HTTP_OK);
        }
    }

    function available_teacher_post($schUid, $userUid){
        $proc = $this->M_chat->getAvailableTeacher($schUid, $userUid);
        if ($proc == TRUE) {
            $this->response([
                'data' => $proc,
                'status' => TRUE,
                'message' => 'Data Ditemukan',
            ], REST_Controller::HTTP_OK);
        }
        else {
            $this->response(['data' => [], 'status' => TRUE, 'message' => 'Pengguna tidak ditemukan'], 
            REST_Controller::HTTP_OK);
        }
    }

    function available_student_post($schUid, $userUid){
        $proc = $this->M_chat->getAvailableStudent($schUid, $userUid);
        if ($proc == TRUE) {
            $this->response([
                'data' => $proc,
                'status' => TRUE,
                'message' => 'Data Ditemukan',
            ], REST_Controller::HTTP_OK);
        }
        else {
            $this->response(['data' => [], 'status' => TRUE, 'message' => 'Pengguna tidak ditemukan'], 
            REST_Controller::HTTP_OK);
        }
    }

    function available_parent_post($schUid, $userUid){
        $proc = $this->M_chat->getAvailableParent($schUid, $userUid);
        if ($proc == TRUE) {
            $this->response([
                'data' => $proc,
                'status' => TRUE,
                'message' => 'Data ditemukan',
            ], REST_Controller::HTTP_OK);
        }
        else {
            $this->response(['data' => [], 'status' => TRUE, 'message' => 'Pengguna tidak ditemukan'], 
            REST_Controller::HTTP_OK);
        }
    }

    function joinchat_post(){
        $schUid = $this->post('school_uid');
        $userUid = $this->post('id_user_url');
        $socketId = $this->post('socket_id');

        if($this->M_chat->isUserExists($schUid, $userUid)){
            $proc = $this->M_chat->update($schUid, $userUid, $socketId, 1);
        }else {
            $proc = $this->M_chat->insert($schUid, $userUid, $socketId);
        }

        if($proc == TRUE) {
            $this->response([
                'message' => 'Sukses join chat',
                'status' => TRUE
            ], REST_Controller::HTTP_OK);
        } else {
            $this->response([
                'message' => 'Terjadi kesalahan ketika join chat',
                'status' => FALSE
            ], REST_Controller::HTTP_OK);
        }
    }

    function exitchat_post(){
        $schUid = $this->post('school_uid');
        $userUid = $this->post('id_user_url');
        $socketId = $this->post('socket_id');

        $proc = $this->M_chat->update($schUid, $userUid, $socketId, 0);

        if($proc == TRUE) {
            $this->response([
                'message' => "Sukses exit chat",
                'last_logout' => $this->M_app->datetimeNow(),
                'status' => TRUE,
            ], REST_Controller::HTTP_OK);
        } else {
            $this->response([
                'message' => "Terjadi kesalahan ketika exit chat",
                'status' => FALSE
            ], REST_Controller::HTTP_OK);
        }
    }
}
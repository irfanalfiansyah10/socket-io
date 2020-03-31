<?php defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;

class Chat_conversation extends REST_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model("M_chat_conversation");
        $this->load->model("M_chat");
        $this->load->model("M_app");
    }

    function sendconversation_post($schUid){
        $receivedByServerAt = $this->M_app->millisecondSinceEpoch();

        $data['id_conversation'] = $this->post('conversation_id');
        $data['from_user_id_url'] = $this->post('sender_url_id');
        $data['to_user_id_url'] = $this->post('receiver_url_id');
        $data['conversation'] = $this->post('conversation');
        $data['send_at'] = $this->post('send_at');
        $data['received_by_server_at'] = $receivedByServerAt;
        $data['status'] = 1;

        $proc1 = $this->M_chat->getDisplayUser($schUid, $this->post('sender_url_id'));

        if($proc1 == TRUE) {
            $proc2 = $this->M_chat_conversation->insertmessage($schUid, $data);
            
            if($proc2 == TRUE){
                $this->response([
                    'display_name' => $proc1->display_name,
                    'display_foto' => $proc1->display_foto,
                    'display_id_url' => $proc1->display_id_url,
                    'message' => 'Sukses mengirim pesan',
                    'received_by_server_at' => $receivedByServerAt,
                    'status' => TRUE
                ], REST_Controller::HTTP_OK);
            }else {    
                $this->response([
                    'message' => 'Terjadi kesalahan ketika mengirim pesan',
                    'received_by_server_at' => $receivedByServerAt,
                    'status' => FALSE
                ], REST_Controller::HTTP_OK);
            }
        } else {
            $this->response([
                'message' => 'Pengguna tidak ditemukan',
                'status' => FALSE
            ], REST_Controller::HTTP_OK);
        }
    }

    function messagereceived_post($schUid){
        $receivedByClientAt = $this->M_app->millisecondSinceEpoch();
        $conversationId = $this->post('conversation_id');

        $conversation = $this->M_chat_conversation->getStatus($schUid, $conversationId);
        if($conversation == TRUE){
            if($conversation->status < 2){
                $data['sent_at'] = $receivedByClientAt;
                $data['status'] = 2;
            }else {
                $data['sent_at'] = $receivedByClientAt;
            }

            $proc = $this->M_chat_conversation->updateMessage($schUid, $conversationId, $data);
            
            if($proc == TRUE){
                $this->response([
                    'message' => 'Berhasil ubah status pesan',
                    'status' => TRUE
                ], REST_Controller::HTTP_OK);
            }else {
                $this->response([
                    'message' => 'Terjadi kesalahan ketika ubah status pesan',
                    'status' => TRUE
                ], REST_Controller::HTTP_OK);
            }
        }else {
            $this->response([
                'message' => 'Percakapan tidak ditemukan',
                'conversation_id' => $conversationId,
                'status' => FALSE
            ], REST_Controller::HTTP_OK);
        }
    }

    function askfordelayedmessage_post($schUid, $userUid){
        $proc = $this->M_chat_conversation->getDelayedMessage($schUid, $userUid);

        if($proc == TRUE){
            $this->response([
                'data' => $proc,
                'message' => 'Berhasil mengambil semua pesan yang belum terkirim',
                'status' => TRUE
            ], REST_Controller::HTTP_OK);
        }else {
            $this->response([
                'message' => 'Pesan telah terkirim ke Anda semua',
                'status' => TRUE
            ], REST_Controller::HTTP_OK);
        }
    }

    function messageread_post($schUid){
        $senderId = $this->post('sender_id');
        $receiverId = $this->post('receiver_id');
        $readAt = $this->post('read_at');

        $data['read_at'] = $readAt;
        $data['status'] = 3;

        $where['from_user_id_url'] = $senderId;
        $where['to_user_id_url'] = $receiverId;
        $where['status'] = 2;

        $proc = $this->M_chat_conversation->readAllMessage($schUid, $data, $where);
            
        if($proc == TRUE){
            $this->response([
                'message' => 'Berhasil membaca semua pesan pengirim',
                'status' => TRUE
            ], REST_Controller::HTTP_OK);
        }else {
            $this->response([
                'message' => 'Sudah membaca semua pesan pengirim',
                'status' => TRUE
            ], REST_Controller::HTTP_OK);
        }
    }

    function lateststatusmessage_post($schUid){
        $messages = json_decode($this->post('messages'));

        $proc = $this->M_chat_conversation->getLatestStatusMessage($schUid, $messages->data);
            
        if($proc == TRUE){
            $this->response([
                'data' => $proc,
                'message' => 'Berhasil mengambil status pesan terbaru',
                'status' => TRUE
            ], REST_Controller::HTTP_OK);
        }else {
            $this->response([
                'message' => 'Terjadi kesalahan ketika mengambil status pesan terbaru',
                'status' => FALSE
            ], REST_Controller::HTTP_OK);
        }
    }
}
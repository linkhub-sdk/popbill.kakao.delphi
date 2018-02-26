(*
*=================================================================================
* Unit for base module for Popbill API SDK. It include base functionality for
* RESTful web service request and parse json result. It uses Linkhub module
* to accomplish authentication APIs.
*
* http://www.popbill.com
* Author : Jeong Yohan (code@linkhub.co.kr)
* Written : 2018-02-26
* Updated : 
* Thanks for your interest.
*=================================================================================
*)

unit PopbillKakao;

interface

uses
        TypInfo,SysUtils,Classes,Popbill,Linkhub;
type
        // ATS-알림톡, FTS-친구톡, FMS-친구톡 이미지
        EnumKakaoType = (ATS,FTS,FMS);

        // 과금정보
        TKakaoChargeInfo = class
        public
                unitCost : string;
                chargeMethod : string;
                rateSystem : string;
        end;

        // 발신번호
        TKakaoSenderNumber = class
        public
            number : string;
            state : integer;
            representYN : Boolean;
        end;

        TKakaoSenderNumberList = Array of TKakaoSenderNumber;


        // 전송요청 - 수신정보/메시지 내용
        TSendKakaoReceiver = class
        public
                receiveNum : string;
                receiveName : string;
                content : string;
                altContent : string;
        end;

        TSendKakaoReceiverList = Array Of TSendKakaoReceiver;


        // 전송요청 - 친구톡 버튼 정보
        TSendKakaoButton = class
        public
                buttonName : string;
                buttonType : string;
                buttonURL1 : string;
                buttonURL2 : string;
        end;

        TSendKakaoButtonList = Array Of TSendKakaoButton;



        // 전송결과 정보 Detail 배열
        TSentKakaoDetail = class
        public
                state : integer;
                contentType : string;
                sendDT : string;
                receiveNum : string;
                receiveName : string;
                content : string;
                result : integer;
                resultDT : string;
                altContent : string;
                altContentType : string;
                altSendDT : string;
                altResult : string;
                altResultDT : string;
        end;
        TSentKakaoDetailList = Array Of TSentKakaoDetail;

         // 전송결과정보 GetMessage
        TSentKakaoInfo = class
        public
                contentType : string;
                templateCode : string;
                plusFriendID : string;
                sendNum : string;
                altContent : string;
                altSendType : string;
                reserveDT : string;
                adsYN : Boolean;
                imageURL : string;
                sendCnt : string;
                successCnt : string;
                failCnt : string;
                altCnt : string;
                cancelCnt : string;
                msgs : TSentKakaoDetailList;
                btns : TSendKakaoButtonList;
        end;


        // 목록조회 Search
        TKakaoSearchList = class
        public
                code : Integer;
                total : Integer;
                perPage : Integer;
                pageNum : Integer;
                pageCount : Integer;
                message : string;
                list : TSentKakaoDetailList;
        end;

        TKakaoService = class(TpopbillBaseService)
        public
                constructor Create(LinkID : String; SecretKey : String);
        end;
implementation

constructor TKakaoService.Create(LinkID : String; SecretKey : String);
begin
        inherited Create(LinkID,SecretKey);
        AddScope('153');
        AddScope('154');
        AddScope('155');
end;

function BoolToStr(b:Boolean):String;
begin
        if b = true then BoolToStr:='True';
        if b = false then BoolToStr:='False';
end;



// End of Unit
end.

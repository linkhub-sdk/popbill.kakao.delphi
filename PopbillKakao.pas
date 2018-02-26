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
        // ATS-�˸���, FTS-ģ����, FMS-ģ���� �̹���
        EnumKakaoType = (ATS,FTS,FMS);

        // ��������
        TKakaoChargeInfo = class
        public
                unitCost : string;
                chargeMethod : string;
                rateSystem : string;
        end;

        // �߽Ź�ȣ
        TKakaoSenderNumber = class
        public
            number : string;
            state : integer;
            representYN : Boolean;
        end;

        TKakaoSenderNumberList = Array of TKakaoSenderNumber;


        // ���ۿ�û - ��������/�޽��� ����
        TSendKakaoReceiver = class
        public
                receiveNum : string;
                receiveName : string;
                content : string;
                altContent : string;
        end;

        TSendKakaoReceiverList = Array Of TSendKakaoReceiver;


        // ���ۿ�û - ģ���� ��ư ����
        TSendKakaoButton = class
        public
                buttonName : string;
                buttonType : string;
                buttonURL1 : string;
                buttonURL2 : string;
        end;

        TSendKakaoButtonList = Array Of TSendKakaoButton;



        // ���۰�� ���� Detail �迭
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

         // ���۰������ GetMessage
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


        // �����ȸ Search
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

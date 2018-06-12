(*
*=================================================================================
* Unit for base module for Popbill API SDK. It include base functionality for
* RESTful web service request and parse json result. It uses Linkhub module
* to accomplish authentication APIs.
*
* http://www.popbill.com
* Author : Jeong Yohan (code@linkhub.co.kr)
* Written : 2018-02-26
* Updated : 2018-02-27
* Contributor : Kim Eunhye (code@linkhub.co.kr)
* Updated : 2018-06-12
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

        // 플러스친구 정보
        TPlusFriendInfo = class
        public
                plusFriendID : string;
                plusFriendName : string;
                regDT : string;
        end;

        TPlusFriendList = Array of TPlusFriendInfo;

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
                rcv : string;
                rcvnm : string;
                msg : string;
                altmsg : string;
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
                altContentType : integer;
                altSendDT : string;
                altResult : integer;
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

        // 템플릿 정보
        TATSTemplate = class
        public
                templateCode : string;
                templateName : String;
                template : string;
                plusFriendID : string;
                btns : TSendKakaoButtonList;
        end;

        TATSTemplateList = Array of TATSTemplate;

        TKakaoService = class(TpopbillBaseService)
        public
                constructor Create(LinkID : String; SecretKey : String);

                // GetURL
                function GetURL(CorpNum : String; TOGO: String; UserID: String = '') : String;

                // 플러스친구 목록 확인
                function ListPlusFriendID(CorpNum : String; UserID : String = '') : TPlusFriendList;

                // 발신번호 목록 확인
                function GetSenderNumberList(CorpNum: String; UserID : String = '') : TKakaoSenderNumberList;

                // 알림톡 템플릿 목록 확인
                function ListATSTemplate(CorpNum : String; UserID : String = '') : TATSTemplateList;



                // 알림톡 전송(단건)
                function SendATS(CorpNum : String; TemplateCode : String; SenderNum : String; AltSendType : String; ReserveDT: String; ReceiverNum : String; ReceiverName : String; ATSMsg : String; ATSAltMsg : String; UserID : String = ''; RequestNum : String = '') : String; overload;

                // 알림톡 전송(대량)
                function SendATS(CorpNum : String; TemplateCode : String; SenderNum : String; Content : String; AltContent: String; AltSendType : String; ReserveDT: String; Receivers : TSendKakaoReceiverList; UserID : String = ''; RequestNum : String = '') : String; overload;


                // 친구톡 텍스트 전송(단건)
                function SendFTS(CorpNum : String; PlusFriendID : String; SenderNum : String; AltSendType : String; ReserveDT : String; AdsYN : Boolean; ReceiverNum : String; ReceiverName : String; FTSMsg : String; FTSAltMsg : String; Buttons : TSendKakaoButtonList; UserID : string = ''; RequestNum : String = '') : String; overload;

                // 친구톡 텍스트 전송 (대량)
                function SendFTS(CorpNum : String; PlusFriendID : String; SenderNum : String; Content : String; AltContent : String; AltSendType : String; ReserveDT : String; AdsYN : Boolean; Receivers : TSendKakaoReceiverList; Buttons : TSendKakaoButtonList; UserID : string = ''; RequestNum : String = '') : String; overload;


                // 친구톡 이미지 전송(단건)
                function SendFMS(CorpNum : String; PlusFriendID : String; SenderNum : String; AltSendType : String; ReserveDT : String; AdsYN : Boolean; ReceiverNum : String; ReceiverName : String; FTSMsg : String; FTSAltMsg : String; FMSFilePath : String; ImageURL : String; Buttons : TSendKakaoButtonList; UserID : string = ''; RequestNum : String = '') : String; overload;

                // 친구톡 이미지 전송(대량)
                function SendFMS(CorpNum : String; PlusFriendID : String; SenderNum : String; Content : String; AltContent : String; AltSendType : String; ReserveDT : String; AdsYN : Boolean; Receivers : TSendKakaoReceiverList; FMSFilePath : String; ImageURL : String; Buttons : TSendKakaoButtonList; UserID : string = ''; RequestNum : String = '') : String; overload;



                // 예약취소
                function CancelReserve(CorpNum : String; receiptNum : String; UserID : String = '') : TResponse;

                // 예약취소 - 요청번호 할당
                function CancelReserveRN(CorpNum : String; RequestNum : String; UserID : String = '') : TResponse;

                // 상세내역 및 전송상태 확인
                function GetMessages(CorpNum : String; receiptNum : String; UserID : String = '') : TSentKakaoInfo;

                // 상세내역 및 전송상태 확인 - 요청번호 할당
                function GetMessagesRN(CorpNum : String; RequestNum : String; UserID : String = '') : TSentKakaoInfo;

                // 목록조회
                function Search(CorpNum : String; SDate: String; EDate : String; State : Array Of String; Item : Array Of String; ReserveYN : String; SenderYN : boolean; Page : Integer; PerPage : Integer; Order : String; UserID : String = ''): TKakaoSearchList;

                // 연동회원 전송단가 확인
                function GetUnitCost(CorpNum : String; KakaoMsgType:EnumKakaoType; UserID : String = '') : Single;

                // 과금정보 확인
                function GetChargeInfo(CorpNum : String; KakaoMsgType:EnumKakaoType; UserID : String = '') : TKakaoChargeInfo;



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

// 팝업 URL
function TKakaoService.GetURL(CorpNum : String; TOGO : String; UserID : String) : string;
var
        responseJson : String;
begin
        // 발신번호 관리 팝업
        if TOGO = 'SENDER' then
                responseJson := httpget('/Message/?TG='+TOGO, CorpNum, UserID)
        else
                responseJson := httpget('/KakaoTalk/?TG='+TOGO, CorpNum, UserID);

        result := getJsonString(responseJson, 'url');
end;


// 플러스친구 계정 목록
function TKakaoService.ListPlusFriendID(CorpNum : String; UserID : String = '') : TPlusFriendList;
var
        responseJson : String;
        jSons : ArrayOfString;
        i : Integer;
begin
        responseJson := httpget('/KakaoTalk/ListPlusFriendID',CorpNum, UserID);

        try

                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i:=0 to Length(jSons)-1 do
                begin
                        result[i] := TPlusFriendInfo.Create;
                        result[i].plusFriendID := getJsonString(jSons[i], 'plusFriendID');
                        result[i].plusFriendName := getJsonString(jSons[i], 'plusFriendName');
                        result[i].regDT := getJsonString(jSons[i], 'regDT');
                end;
        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
end;

// 발신번호 목록 조회
function TKakaoService.GetSenderNumberList(CorpNum : String; UserID: String = '') : TKakaoSenderNumberList;
var
        responseJson : String;
        jSons : ArrayOfString;
        i : Integer;
begin

        responseJson := httpget('/Message/SenderNumber',CorpNum, UserID);

        try
                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i:= 0 to Length(jSons)-1 do
                begin
                        result[i] := TKakaoSenderNumber.Create;
                        result[i].number := getJsonString(jSons[i],'number');
                        result[i].state := getJsonInteger(jSons[i],'state');
                        result[i].representYN := getJsonBoolean(jSons[i],'representYN');
                end;
        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
end;

// 알림톡 템플릿 목록 확인
function TKakaoService.ListATSTemplate(CorpNum : String; UserID : String = '') : TATSTemplateList;
var
        responseJson : String;
        jSons, btnjSons : ArrayOfString;
        i, j: Integer;

begin
        responseJson := httpget('/KakaoTalk/ListATSTemplate', CorpNum, UserID);

        try
                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i:= 0 to Length(jSons)-1 do
                begin
                        result[i] := TATSTemplate.Create;
                        result[i].templateCode := getJsonString(jSons[i], 'templateCode');
                        result[i].templateName := getJsonString(jSons[i], 'templateName');
                        result[i].template := getJsonString(jSons[i], 'template');
                        result[i].plusFriendID := getJsonString(jSons[i], 'plusFriendID');

                        // 알림톡 템플릿 버튼
                        btnjSons := getJSonList(responseJson, 'btns');
                        SetLength(result[i].btns, Length(btnjSons));

                        for j:= 0 to Length(btnjSons)-1 do
                        begin
                                result[i].btns[j] := TSendKakaoButton.Create;
                                result[i].btns[j].buttonName := getJSonString(btnjSons[j],'n');
                                result[i].btns[j].buttonType := getJSonString(btnjSons[j],'t');
                                result[i].btns[j].buttonURL1 := getJSonString(btnjSons[j],'u1');
                                result[i].btns[j].buttonURL2 := getJSonString(btnjSons[j],'u2');
                        end;
                end;
        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');

        end;
end;


// 예약전송 취소
function TKakaoService.CancelReserve(CorpNum : String; receiptNum : String; UserID : String = '') : TResponse;
var
        responseJson : String;
begin
        if receiptNum = '' then raise EPopbillException.Create(-99999999,'접수번호가 입력되지 않았습니다');
        try
                responseJson := httpget('/KakaoTalk/'+receiptNum+'/Cancel',CorpNum,UserID);
                result.code := getJsonInteger(responseJson,'code');
                result.message := getJsonString(responseJson,'message');

        except on le : EPopbillException do begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(le.code, le.Message);
                end;
                result.code := le.code;
                result.message := le.message;
                end;
        end;
end;


function TKakaoService.GetMessages(CorpNum : String; receiptNum : String; UserID : String = '') : TSentKakaoInfo;
var
        responseJson : String;
        jSons : ArrayofString;
        i : Integer;
begin
        if receiptNum = '' then raise EPopbillException.Create(-99999999,'접수번호가 입력되지 않았습니다');

        responseJson := httpget('/KakaoTalk/'+receiptNum, CorpNum, UserID);

        try
                result := TSentKakaoInfo.Create;
                result.contentType := getJsonString(responseJson, 'contentType');
                result.templateCode := getJsonString(responseJson, 'templateCode');
                result.plusFriendID := getJsonString(responseJson, 'plusFriendID');
                result.sendNum := getJsonString(responseJson, 'sendNum');
                result.altContent := getJsonString(responseJson, 'altContent');
                result.altSendType := getJsonString(responseJson, 'altSendType');
                result.reserveDT := getJsonString(responseJson, 'reserveDT');
                result.adsYN := getJsonBoolean(responseJson, 'adsYN');
                result.imageURL := getJsonString(responseJson, 'imageURL');
                result.sendCnt := getJsonString(responseJson, 'sendCnt');
                result.successCnt := getJsonString(responseJson, 'successCnt');
                result.failCnt := getJsonString(responseJson, 'failCnt');
                result.altCnt := getJsonString(responseJson, 'altCnt');
                result.cancelCnt := getJsonString(responseJson, 'cancelCnt');

                jSons := getJSonList(responseJson, 'btns');
                SetLength(result.btns, Length(jSons));

                for i:= 0 to Length(jSons)-1 do
                begin
                        result.btns[i] := TSendKakaoButton.Create;
                        result.btns[i].buttonName := getJSonString(jSons[i],'n');
                        result.btns[i].buttonType := getJSonString(jSons[i],'t');
                        result.btns[i].buttonURL1 := getJSonString(jSons[i],'u1');
                        result.btns[i].buttonURL2 := getJSonString(jSons[i],'u2');
                end;

                jSons := getJSonList(responseJson, 'msgs');
                SetLength(result.msgs, Length(jSons));

                for i:= 0 to Length(jSons)-1 do
                begin
                        result.msgs[i] := TSentKakaoDetail.Create;
                        result.msgs[i].state := getJsonInteger(jSons[i],'state');
                        result.msgs[i].sendDT := getJsonString(jSons[i],'sendDT');
                        result.msgs[i].receiveNum := getJsonString(jSons[i], 'receiveNum');
                        result.msgs[i].receiveName := getJsonString(jSons[i], 'receiveName');
                        result.msgs[i].content := getJsonString(jSons[i], 'content');
                        result.msgs[i].result := getJsonInteger(jSons[i], 'result');
                        result.msgs[i].resultDT := getJsonString(jSons[i], 'resultDt');
                        result.msgs[i].altContent := getJsonString(jSons[i], 'altContent');
                        result.msgs[i].altContentType := getJsonInteger(jSons[i], 'altContentType');
                        result.msgs[i].altResult := getJsonInteger(jSons[i], 'altResult');
                        result.msgs[i].altResultDT := getJsonString(jSons[i], 'altResultDT');
                end;

        except on E:Exception do
                raise EPopbillException.Create(-99999999, '결과처리 실패.[Malformed Json]');
        end;
end;


// 목록조회
function TKakaoService.Search(CorpNum : String; SDate: String; EDate : String; State : Array Of String; Item : Array Of String; ReserveYN : String; SenderYN : boolean; Page : Integer; PerPage : Integer; Order : String; UserID : String = ''): TKakaoSearchList;
var
        responseJson : String;
        uri: String;
        StateList : String;
        ItemList : String;
        jSons : ArrayOfString;
        i : Integer;
begin

        for i := 0 to High(State)do
        begin
                if State[i] <> '' Then
                StateList := StateList + State[i] + ',';
        end;

        for i:= 0 to High(Item) do
        begin
                if Item[i] <> '' Then
                ItemList := ItemList + Item[i] + ',';
        end;

        uri := '/KakaoTalk/Search?SDate='+SDate+'&&EDate='+EDate;
        uri := uri + '&&State='+StateList;
        uri := uri + '&&Item='+ItemList;

        if Page < 1 then Page := 1;
        uri := uri + '&&Page='+IntToStr(Page);
        uri := uri + '&&PerPage=' + IntToStr(Perpage);

        if ReserveYN <> '' then uri := uri + '&&ReserveYN=' + ReserveYN;

        if SenderYN then uri := uri + '&&SenderYN=1'
        else uri := uri +'&&SenderYN=0';

        uri := uri + '&&Order=' + Order;

        responseJson := httpget(uri, CorpNum, UserID);


        result := TKakaoSearchList.Create;

        result.code := getJsonInteger(responseJson, 'code');
        result.message := getJsonString(responseJson, 'message');
        result.total := getJsonInteger(responseJson, 'total');
        result.perPage := getJsonInteger(responseJson, 'perPage');
        result.pageNum := getJsonInteger(responseJson, 'pageNum');
        result.pageCount := getJsonInteger(responseJson, 'pageCount');

        try
                jSons := getJSonList(responseJson, 'list');
                SetLength(result.list, Length(jSons));

                for i:= 0 to Length(jSons)-1 do
                begin
                        result.list[i] := TSentKakaoDetail.Create;
                        result.list[i].state := getJsonInteger(jSons[i],'state');
                        result.list[i].sendDT := getJsonString(jSons[i],'sendDT');
                        result.list[i].receiveNum := getJsonString(jSons[i], 'receiveNum');
                        result.list[i].receiveName := getJsonString(jSons[i], 'receiveName');
                        result.list[i].content := getJsonString(jSons[i], 'content');
                        result.list[i].result := getJsonInteger(jSons[i], 'result');
                        result.list[i].resultDT := getJsonString(jSons[i], 'resultDT');
                        result.list[i].altContent := getJsonString(jSons[i], 'altContent');
                        result.list[i].altContentType := getJsonInteger(jSons[i], 'altContentType');
                        result.list[i].altResult := getJsonInteger(jSons[i], 'altResult');
                        result.list[i].altSendDT := getJsonString(jSons[i], 'altSendDT');                        
                        result.list[i].altResultDT := getJsonString(jSons[i], 'altResultDT');
                        result.list[i].contentType := getJsonString(jSons[i], 'contentType');
                end;
        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;

end;



// 알림톡 단건전송
function TKakaoService.SendATS(CorpNum : String; TemplateCode : String; SenderNum : String; AltSendType : String; ReserveDT: String; ReceiverNum : String; ReceiverName : String; ATSMsg : String; ATSAltMsg : String; UserID : String = ''; RequestNum : String = '') : String;
var
        Receivers : TSendKakaoReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TSendKakaoReceiver.Create;
        Receivers[0].rcv := ReceiverNum;
        Receivers[0].rcvnm := ReceiverName;
        Receivers[0].msg := ATSMsg;
        Receivers[0].altmsg := ATSAltMsg;

        result := SendATS(CorpNum, TemplateCode, SenderNum, '', '', AltSendType, ReserveDT, Receivers, UserID, RequestNum);
end;

// 알림톡 대량전송
function TKakaoService.SendATS(CorpNum : String; TemplateCode : String; SenderNum : String; Content : String; AltContent: String; AltSendType : String; ReserveDT: String; Receivers : TSendKakaoReceiverList; UserID : String = ''; RequestNum : String = '') : String;
var
         requestJson, responseJson : string;
         i : Integer;
begin
        if TemplateCode      = '' then raise EPopbillException.Create(-99999999, '알림톡 템플릿코드가 입력되지 않았습니다.');
        if SenderNum         = '' then raise EPopbillException.Create(-99999999, '알림톡 발신번호가 입력되지 않았습니다.');
        if Length(Receivers) = 0  then raise EPopbillException.Create(-99999999, '수신정보배열이 입력되지 않았습니다.');

        requestJson := '{';

        if TemplateCode <> ''  then requestJson := requestJson + '"templateCode":"' + EscapeString(TemplateCode) + '",';
        if SenderNum    <> ''  then requestJson := requestJson + '"snd":"'          + EscapeString(SenderNum)    + '",';
        if Content      <> ''  then requestJson := requestJson + '"content":"'      + EscapeString(Content)      + '",';
        if AltContent   <> ''  then requestJson := requestJson + '"altContent":"'   + EscapeString(AltContent)   + '",';
        if AltSendType  <> ''  then requestJson := requestJson + '"altSendType":"'  + EscapeString(AltSendType)  + '",';
        if reserveDT    <> ''  then requestJson := requestJson + '"sndDT":"'        + EscapeString(reserveDT)    + '",';
        if RequestNum   <> ''  then requestJson := requestJson + '"requestNum":"'   + EscapeString(RequestNum)   + '",';

        requestJson := requestJson + '"msgs":[';
        for i := 0 to Length(Receivers) - 1 do begin
                requestJson := requestJson
                        + '{"rcv":"'   + EscapeString(Receivers[i].rcv)      + '",'
                        + '"rcvnm":"'  + EscapeString(Receivers[i].rcvnm)    + '",'
                        + '"msg":"'    + EscapeString(Receivers[i].msg)      + '",'
                        + '"altmsg":"' + EscapeString(Receivers[i].altmsg)   + '"}';
                if i < Length(Receivers) - 1 then requestJson := requestJson + ',';
        end;
        requestJson := requestJson + ']';

        requestJson := requestJson + '}';

        responseJson := httppost('/ATS', CorpNum, UserID, requestJson);

        result := getJsonString(responseJson, 'receiptNum');
end;

// 친구톡 텍스트 (단건)
function TKakaoService.SendFTS(CorpNum : String; PlusFriendID : String; SenderNum : String; AltSendType : String; ReserveDT : String; AdsYN : Boolean; ReceiverNum : String; ReceiverName : String; FTSMsg : String; FTSAltMsg : String; Buttons : TSendKakaoButtonList; UserID : string = ''; RequestNum : String = '') : String;
var
        Receivers : TSendKakaoReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TSendKakaoReceiver.Create;
        Receivers[0].rcv := ReceiverNum;
        Receivers[0].rcvnm := ReceiverName;
        Receivers[0].msg := FTSMsg;
        Receivers[0].altmsg := FTSAltMsg;

        result := SendFTS(CorpNum, PlusFriendID, SenderNum, '', '', AltSendType, ReserveDT, AdsYN, Receivers, Buttons, UserID, RequestNum);
end;

// 친구톡 텍스트 (대량)
function TKakaoService.SendFTS(CorpNum : String; PlusFriendID : String; SenderNum : String; Content : String; AltContent : String; AltSendType : String; ReserveDt : String; AdsYN : Boolean; Receivers : TSendKakaoReceiverList; Buttons : TSendKakaoButtonList; UserID : string = ''; RequestNum : String = '') : String;
var
        requestJson, responseJson : string;
        i : Integer;
begin
        if PlusFriendID      = '' then raise EPopbillException.Create(-99999999, '플러스친구 아이디가 입력되지 않았습니다.');
        if SenderNum         = '' then raise EPopbillException.Create(-99999999, '친구톡 발신번호가 입력되지 않았습니다.');
        if Length(Receivers) = 0  then raise EPopbillException.Create(-99999999, '수신정보배열이 입력되지 않았습니다.');

        requestJson := '{';

        if PlusFriendID <> ''  then requestJson := requestJson + '"plusFriendID":"' + EscapeString(PlusFriendID) + '",';
        if SenderNum    <> ''  then requestJson := requestJson + '"snd":"'          + EscapeString(SenderNum)    + '",';
        if Content      <> ''  then requestJson := requestJson + '"content":"'      + EscapeString(Content)      + '",';
        if AltContent   <> ''  then requestJson := requestJson + '"altContent":"'   + EscapeString(AltContent)   + '",';
        if AltSendType  <> ''  then requestJson := requestJson + '"altSendType":"'  + EscapeString(AltSendType)  + '",';
        if reserveDT    <> ''  then requestJson := requestJson + '"sndDT":"'        + EscapeString(reserveDT)    + '",';
        if RequestNum   <> ''  then requestJson := requestJson + '"requestNum":"'   + EscapeString(RequestNum)    + '",';
        if adsYN then requestJson := requestJson + '"adsYN":true,';

        requestJson := requestJson + '"msgs":[';
        for i := 0 to Length(Receivers) - 1 do begin
                requestJson := requestJson +
                        '{"rcv":"'+EscapeString(Receivers[i].rcv)+'",'+
                        '"rcvnm":"'+EscapeString(Receivers[i].rcvnm)+'",'+
                        '"msg":"'+EscapeString(Receivers[i].msg)+'",'+
                        '"altmsg":"'+EscapeString(Receivers[i].altmsg)+'"}';

                if i < Length(Receivers) - 1 then requestJson := requestJson + ',';
        end;
        requestJson := requestJson + ']';

        requestJson := requestJson + ',"btns":[';
        for i := 0 to Length(Buttons) - 1 do begin
                requestJson := requestJson +
                        '{"n":"'+EscapeString(Buttons[i].buttonName)+'",'+
                        '"t":"'+EscapeString(Buttons[i].buttonType)+'",'+
                        '"u1":"'+EscapeString(Buttons[i].buttonURl1)+'",'+
                        '"u2":"'+EscapeString(Buttons[i].buttonURL2)+'"}';

                if i < Length(Buttons) - 1 then requestJson := requestJson + ',';
        end;
        requestJson := requestJson + ']';

        requestJson := requestJson + '}';


        responseJson := httppost('/FTS', CorpNum, UserID, requestJson);

        result := getJsonString(responseJson, 'receiptNum');
end;


// 친구톡 이미지 (단건)
function TKakaoService.SendFMS(CorpNum : String; PlusFriendID : String; SenderNum : String; AltSendType : String; ReserveDT : String; AdsYN : Boolean; ReceiverNum : String; ReceiverName : String; FTSMsg : String; FTSAltMsg : String; FMSFilePath : String; ImageURL : String; Buttons : TSendKakaoButtonList; UserID : string = ''; RequestNum : String = '') : String;
var
        Receivers : TSendKakaoReceiverList;
begin
        SetLength(Receivers,1);
        Receivers[0] := TSendKakaoReceiver.Create;
        Receivers[0].rcv := ReceiverNum;
        Receivers[0].rcvnm := ReceiverName;
        Receivers[0].msg := FTSMsg;
        Receivers[0].altmsg := FTSAltMsg;

        result := SendFMS(CorpNum, PlusFriendID, SenderNum, '', '', AltSendType, ReserveDT, AdsYN, Receivers, FMSFilePath, ImageURL, Buttons, UserID, RequestNum);
end;

// 친구톡 이미지 (대량)
function TKakaoService.SendFMS(CorpNum : String; PlusFriendID : String; SenderNum : String; Content : String; AltContent : String; AltSendType : String; ReserveDT : String; AdsYN : Boolean; Receivers : TSendKakaoReceiverList; FMSFilePath : String; ImageURl: string; Buttons : TSendKakaoButtonList; UserID : string = ''; RequestNum : String = '') : String;
var
        requestJson, responseJson : string;
        i : Integer;
        files : TFileList;
begin
        if PlusFriendID = '' then raise EPopbillException.Create(-99999999, '플러스친구 아이디가 입력되지 않았습니다.');
        if SenderNum = '' then raise EPopbillException.Create(-99999999, '친구톡 발신번호가 입력되지 않았습니다.');
        if Length(Receivers) = 0 then raise EPopbillException.Create(-99999999, '수신정보배열이 입력되지 않았습니다.');

        SetLength(files,1);

        files[0] := TFile.Create;
        files[0].FieldName := 'file';
        files[0].FileName := ExtractFileName(FMSFilePath);
        files[0].Data := TFileStream.Create(FMSFilePath,fmOpenRead);

        requestJson := '{';

        if PlusFriendID <> ''          then requestJson := requestJson + '"plusFriendID":"' + EscapeString(PlusFriendID) + '",';
        if SenderNum <> ''          then requestJson := requestJson + '"snd":"' + EscapeString(SenderNum) + '",';
        if Content <> ''         then requestJson := requestJson + '"content":"' + EscapeString(Content) + '",';
        if AltContent <> ''         then requestJson := requestJson + '"altContent":"' + EscapeString(AltContent) + '",';
        if AltSendType <> ''         then requestJson := requestJson + '"altSendType":"' + EscapeString(AltSendType) + '",';
        if reserveDT <> ''       then requestJson := requestJson + '"sndDT":"' + EscapeString(reserveDT) + '",';
        if imageURL <> ''       then requestJson := requestJson + '"imageURL":"' + EscapeString(imageURL) + '",';
        if RequestNum <> ''       then requestJson := requestJson + '"requestNum":"' + EscapeString(RequestNum) + '",';
        if adsYN then requestJson := requestJson + '"adsYN":true,';

        requestJson := requestJson + '"msgs":[';
        for i := 0 to Length(Receivers) - 1 do begin
                requestJson := requestJson +
                        '{"rcv":"'+EscapeString(Receivers[i].rcv)+'",'+
                        '"rcvnm":"'+EscapeString(Receivers[i].rcvnm)+'",'+
                        '"msg":"'+EscapeString(Receivers[i].msg)+'",'+
                        '"altmsg":"'+EscapeString(Receivers[i].altmsg)+'"}';

                if i < Length(Receivers) - 1 then requestJson := requestJson + ',';
        end;
        requestJson := requestJson + ']';

        requestJson := requestJson + ',"btns":[';
        for i := 0 to Length(Buttons) - 1 do begin
                requestJson := requestJson +
                        '{"n":"'+EscapeString(Buttons[i].buttonName)+'",'+
                        '"t":"'+EscapeString(Buttons[i].buttonType)+'",'+
                        '"u1":"'+EscapeString(Buttons[i].buttonURl1)+'",'+
                        '"u2":"'+EscapeString(Buttons[i].buttonURL2)+'"}';

                if i < Length(Buttons) - 1 then requestJson := requestJson + ',';
        end;
        requestJson := requestJson + ']';

        requestJson := requestJson + '}';


        responseJson := httppost('/FMS', CorpNum, UserID, requestJson, files);

        result := getJsonString(responseJson, 'receiptNum');
end;


// 전송단가 조회
function TKakaoService.GetUnitCost(CorpNum : String; KakaoMsgType:EnumKakaoType; UserID : String = '') : Single;
var
        responseJson : String;
begin
        responseJson := httpget('/KakaoTalk/UnitCost?Type='+GetEnumName(TypeInfo(EnumKakaoType),integer(KakaoMsgType)), CorpNum, UserID);

        try
                result := strToFloat(getJsonString(responseJson, 'unitCost'));
        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;

end;

// 과금정보 조회
function TKakaoService.GetChargeInfo(CorpNum : String; KakaoMsgType:EnumKakaoType; UserID : String = '') : TKakaoChargeInfo;
var
        responseJson : String;
begin
        responseJson := httpget('/KakaoTalk/ChargeInfo?Type='+GetEnumName(TypeInfo(EnumKakaoType),integer(KakaoMsgType)), CorpNum, UserID);

        try
                result := TKakaoChargeInfo.Create;

                result.unitCost := getJSonString(responseJson, 'unitCost');
                result.chargeMethod := getJSonString(responseJson, 'chargeMethod');
                result.rateSystem := getJSonString(responseJson, 'rateSystem');

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
end;

function TKakaoService.GetMessagesRN(CorpNum, RequestNum, UserID: String): TSentKakaoInfo;
var
        responseJson : String;
        jSons : ArrayofString;
        i : Integer;
begin
        if RequestNum = '' then raise EPopbillException.Create(-99999999,'요청번호(RequestNum)가 입력되지 않았습니다');

        responseJson := httpget('/KakaoTalk/Get/'+ RequestNum, CorpNum, UserID);

        try
                result := TSentKakaoInfo.Create;
                result.contentType := getJsonString(responseJson, 'contentType');
                result.templateCode := getJsonString(responseJson, 'templateCode');
                result.plusFriendID := getJsonString(responseJson, 'plusFriendID');
                result.sendNum := getJsonString(responseJson, 'sendNum');
                result.altContent := getJsonString(responseJson, 'altContent');
                result.altSendType := getJsonString(responseJson, 'altSendType');
                result.reserveDT := getJsonString(responseJson, 'reserveDT');
                result.adsYN := getJsonBoolean(responseJson, 'adsYN');
                result.imageURL := getJsonString(responseJson, 'imageURL');
                result.sendCnt := getJsonString(responseJson, 'sendCnt');
                result.successCnt := getJsonString(responseJson, 'successCnt');
                result.failCnt := getJsonString(responseJson, 'failCnt');
                result.altCnt := getJsonString(responseJson, 'altCnt');
                result.cancelCnt := getJsonString(responseJson, 'cancelCnt');

                jSons := getJSonList(responseJson, 'btns');
                SetLength(result.btns, Length(jSons));

                for i:= 0 to Length(jSons)-1 do
                begin
                        result.btns[i] := TSendKakaoButton.Create;
                        result.btns[i].buttonName := getJSonString(jSons[i],'n');
                        result.btns[i].buttonType := getJSonString(jSons[i],'t');
                        result.btns[i].buttonURL1 := getJSonString(jSons[i],'u1');
                        result.btns[i].buttonURL2 := getJSonString(jSons[i],'u2');
                end;

                jSons := getJSonList(responseJson, 'msgs');
                SetLength(result.msgs, Length(jSons));

                for i:= 0 to Length(jSons)-1 do
                begin
                        result.msgs[i] := TSentKakaoDetail.Create;
                        result.msgs[i].state := getJsonInteger(jSons[i],'state');
                        result.msgs[i].sendDT := getJsonString(jSons[i],'sendDT');
                        result.msgs[i].receiveNum := getJsonString(jSons[i], 'receiveNum');
                        result.msgs[i].receiveName := getJsonString(jSons[i], 'receiveName');
                        result.msgs[i].content := getJsonString(jSons[i], 'content');
                        result.msgs[i].result := getJsonInteger(jSons[i], 'result');
                        result.msgs[i].resultDT := getJsonString(jSons[i], 'resultDt');
                        result.msgs[i].altContent := getJsonString(jSons[i], 'altContent');
                        result.msgs[i].altContentType := getJsonInteger(jSons[i], 'altContentType');
                        result.msgs[i].altResult := getJsonInteger(jSons[i], 'altResult');
                        result.msgs[i].altResultDT := getJsonString(jSons[i], 'altResultDT');
                end;

        except on E:Exception do
                raise EPopbillException.Create(-99999999, '결과처리 실패.[Malformed Json]');
        end;
end;

function TKakaoService.CancelReserveRN(CorpNum, RequestNum, UserID: String): TResponse;
var
        responseJson : String;
begin
        if RequestNum = '' then raise EPopbillException.Create(-99999999,'요청번호(RequestNum)가 입력되지 않았습니다');
        try
                responseJson := httpget('/KakaoTalk/Cancel/' + RequestNum, CorpNum, UserID);
                result.code := getJsonInteger(responseJson,'code');
                result.message := getJsonString(responseJson,'message');

        except on le : EPopbillException do begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(le.code, le.Message);
                end;
                result.code := le.code;
                result.message := le.message;
                end;
        end;
end;


// End of Unit
end.

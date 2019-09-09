/**
 * Created by OLga Skrynnikova on 09.09.2019.
 */

public with sharing class SalesforceLoginRemoteCall extends RemoteCall{

    private String username;
    private String password;
    public SalesforceLoginRemoteCall(String username, String password){
        this.username = username;
        this.password = password;
        this.endPointURL = 'callout:SFLoginDemo';
        this.httpMethod = METHOD_POST;
        this.headersMap.putAll(new Map<String, String>{
                'Content-Type' => 'text/xml; charset=utf-8',
                'SOAPAction' => 'login',
                'Connection' => 'Keep-Alive'
        });
        this.hiddenParams = new Map<String, String>{
                'username' => username,
                'password' => password
        };
    }
    public override Type getType() {
        return SalesforceLoginRemoteCall.class;
    }

    protected override String buildRequestBody() {
        String requestBody = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:enterprise.soap.sforce.com">' +
                '<soapenv:Body>' +
                '<urn:login>' +
                '<urn:username>{!username}</urn:username>' +
                '<urn:password>{!password}</urn:password>' +
                '</urn:login>' +
                '</soapenv:Body>' +
                '</soapenv:Envelope>';
        return requestBody;
    }

    protected override Object parseResponse(String responseBody) {
        Dom.Document document = new Dom.Document();
        document.load(responseBody);
        String soapenv = 'http://schemas.xmlsoap.org/soap/envelope/';
        String commonNamespace = 'urn:enterprise.soap.sforce.com';
        String sessionId = document.getRootElement().getChildElement('Body', soapenv).
                getChildElement('loginResponse', commonNamespace).
                getChildElement('result', commonNamespace).
                getChildElement('sessionId', commonNamespace).getText();
        document.getRootElement().getChildren();
        if(log.Response_Body__c != null)
            log.Response_Body__c = log.Response_Body__c.replace(sessionId, 'SESSION_ID_REMOVED');
        return sessionId;
    }
}
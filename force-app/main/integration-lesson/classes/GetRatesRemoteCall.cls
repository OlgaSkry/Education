/**
 * Created by OLga Skrynnikova on 09.09.2019.
 */

public with sharing class GetRatesRemoteCall extends RemoteCall{

    public class GetRatesResponse {
        public String base;
        public Map<String, Decimal> rates;
    }

    public GetRatesRemoteCall(String currencyBase){

        this.endPointURL = 'callout:GetRates' + '?base=' + currencyBase;
        this.httpMethod = METHOD_GET;

    }

    public override Type getType() {
        return SalesforceLoginRemoteCall.class;
    }

    protected override String buildRequestBody() {
        return null;
    }

    protected override Object parseResponse(String responseBody) {
        GetRatesResponse response = (GetRatesResponse)JSON.deserialize(responseBody, GetRatesResponse.class);
        return response.rates;
    }
}
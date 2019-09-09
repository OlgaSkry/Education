/**
 * Created by OLga Skrynnikova on 09.09.2019.
 */

public with sharing class Schedule_UpdateRates implements Schedulable{


    public void execute(SchedulableContext sc) {
        GetRatesRemoteCall getRatesRemoteCall = new GetRatesRemoteCall('USD');
        Map<String, Decimal> remoteRates = (Map<String, Decimal>)getRatesRemoteCall.execute();

        List<Exchange_Rate__c> exchangeRates = [SELECT Id, Currency__c, Rate__c FROM Exchange_Rate__c];
        Map<String, Exchange_Rate__c> exchangeRatesMap = new Map<String, Exchange_Rate__c>();

        for (Exchange_Rate__c rate: exchangeRates) exchangeRatesMap.put(rate.Currency__c, rate);

        List<Exchange_Rate__c> ratesToUpsert = new List<Exchange_Rate__c>();

        for (String curr : remoteRates.keySet()) {
            Exchange_Rate__c exchangeRate = exchangeRatesMap.get(curr);
            if(exchangeRate == null) {
                exchangeRate = new Exchange_Rate__c(
                        Currency__c = curr,
                        Rate__c = remoteRates.get(curr)
                );
            } else {
                exchangeRate.Rate__c = remoteRates.get(curr);

            }
            ratesToUpsert.add(exchangeRate);
        }
        upsert ratesToUpsert;
    }
}
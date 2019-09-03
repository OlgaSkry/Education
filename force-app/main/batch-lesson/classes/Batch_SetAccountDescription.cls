/**
 * Created by user on 03.09.2019.
 */

public with sharing class Batch_SetAccountDescription implements Database.Batchable<SObject>, Database.Stateful{

    public Database.Querylocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id,
                                                Name,
                                                BillingStreet,
                                                BillingCity,
                                                BillingState,
                                                BillingCountry
                                        FROM Account]);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Account> accounts = new List<Account>();
        for (Account acc : scope) {
            List<String> description = new List<String>{
                    acc.Name,
                    acc.BillingStreet,
                    acc.BillingCity,
                    acc.BillingState,
                    acc.BillingCountry
            };
            acc.Description = String.join(description, ' ');
            delete accounts;
            System.debug('>>> Account' + acc.Name + 'processed');
        }
    }

    public void finish(Database.BatchableContext bc) {
    }

    public static void run() {
        Database.executeBatch(new Batch_SetAccountDescription(), 1);
    }

}
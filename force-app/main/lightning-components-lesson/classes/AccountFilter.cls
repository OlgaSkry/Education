/**
 * Created by OLga Skrynnikova on 05.09.2019.
 */

public with sharing class AccountFilter implements SearchFilter{
    @AuraEnabled public String accName;


    public List<String> getFields() {
        return new List<String>{
                'Name'
        };
    }

    public SObjectType getSObjectType() {
        return Account.getSObjectType();
    }

    public String getFilterString() {
        List<String> filters = new List<String>();
        if(!String.isEmpty(accName)) filters.add(
                ' Name LIKE \'%' + accName + '%\' '
        );

        if (filters.size() > 0) return ' WHERE ' + String.join(filters, ' AND ');
        return '';
    }
}
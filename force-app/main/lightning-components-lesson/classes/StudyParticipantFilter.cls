/**
 * Created by OLga Skrynnikova on 05.09.2019.
 */

public with sharing class StudyParticipantFilter implements SearchFilter{
    @AuraEnabled public String status;
    @AuraEnabled public String StudyTitleTerm;


    public List<String> getFields() {
        return new List<String>{
                'Contact__r.Name',
                'Clinical_Study__r.Title__c'
        };
    }

    public SObjectType getSObjectType() {
        return Study_Participant__c.getSObjectType();
    }

    public String getFilterString() {
        return ' WHERE Status__c = \'' + status + '\' AND Clinical_Study__r.Title__c LIKE \'%' +
                StudyTitleTerm + '%\' ';
    }
}
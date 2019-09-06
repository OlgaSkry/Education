/**
 * Created by OLga Skrynnikova on 05.09.2019.
 */

public with sharing class StudyParticipantFilter implements SearchFilter{
    @AuraEnabled public String status;
    @AuraEnabled public String studyTitleTerm;


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
        String filter = ' WHERE Clinical_Study__r.Title__c LIKE \'%' + studyTitleTerm + '%\' ';
        if(status != null) filter += ' AND Status__c = \'' + status + '\'';
        return filter;
    }
}
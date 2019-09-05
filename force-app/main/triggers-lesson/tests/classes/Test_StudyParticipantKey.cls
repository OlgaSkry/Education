/**
 * Created by user on 04.09.2019.
 */
@IsTest
private class Test_StudyParticipantKey {
    @TestSetup
    static void dataCreation() {
        Clinical_Study__c csTest = new Clinical_Study__c();
        Contact testCon1 = new Contact(LastName = 'SurnameTest01');
        insert csTest;
        insert testCon1;
    }
    @IsTest
    static void TestKey() {
        Contact contact = [SELECT Id FROM Contact LIMIT 1];
        Clinical_Study__c clinicalStudy = [SELECT Id FROM Clinical_Study__c LIMIT 1];

        try {
            Test.startTest();
            Study_Participant__c studyParticipant = new Study_Participant__c(
                    Clinical_Study__c = clinicalStudy.Id,
                    Contact__c = contact.Id
            );
            insert studyParticipant;
            Study_Participant__c studyParticipant1 = new Study_Participant__c(
                    Clinical_Study__c = clinicalStudy.Id,
                    Contact__c = contact.Id
            );
            insert studyParticipant1;
            System.assert(false, 'Here is exception');
            Test.stopTest();
        }catch (Exception e){
            System.assert(e.getMessage().containsIgnoreCase('duplicate'), 'Wrong exception type');
        }
    }
}